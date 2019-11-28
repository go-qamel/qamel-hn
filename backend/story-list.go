package backend

import (
	"fmt"
	"math"
	"sync"
	"time"

	"github.com/go-qamel/qamel"
	"github.com/pkg/browser"
	"github.com/sirupsen/logrus"
)

// StoryList is back end for StoryList.qml
type StoryList struct {
	qamel.QmlObject

	storyIDs   []int
	mapStories map[int]Story
	mutex      sync.Mutex

	_ string `property:"storiesType"`

	_ func()            `slot:"openURL"`
	_ func()            `slot:"clearCache"`
	_ func(page int)    `slot:"loadData"`
	_ func(string, int) `signal:"loaded"`
	_ func(string)      `signal:"error"`
}

func (b *StoryList) openURL() {
	url := "https://news.ycombinator.com/"
	switch b.storiesType() {
	case "new":
		url += "newest"
	case "ask":
		url += "ask"
	case "show":
		url += "show"
	case "jobs":
		url += "jobs"
	case "top":
	default:
	}

	err := browser.OpenURL(url)
	if err != nil {
		b.error(fmt.Sprintf("Failed to open url: %v", err))
	}
}

func (b *StoryList) clearCache() {
	b.mutex.Lock()
	b.storyIDs = []int{}
	b.mapStories = map[int]Story{}
	b.mutex.Unlock()

	b.loadData(1)
}

func (b *StoryList) loadData(page int) {
	go b.fetchStories(page)
}

func (b *StoryList) fetchStories(page int) {
	// If the story IDs is still empty, fetch it
	var err error
	if len(b.storyIDs) == 0 {
		b.storyIDs, err = getStoryIDs(b.storiesType())
		if err != nil {
			b.error(fmt.Sprintf("Failed to load stories: %v", err))
			return
		}
	}

	if len(b.mapStories) == 0 {
		b.mapStories = make(map[int]Story)
	}

	// Calculate max page
	maxPage := int(math.Ceil(float64(len(b.storyIDs)) / 20.0))

	// Validate page number
	if page < 1 {
		page = 1
	}

	if page > maxPage {
		page = maxPage
	}

	// Get story IDs for current page
	start := (page - 1) * 20
	finish := start + 20
	if finish >= len(b.storyIDs) {
		finish = len(b.storyIDs)
	}
	storyIDs := b.storyIDs[start:finish]

	// Fetch story details concurrently (10 at a time)
	wg := sync.WaitGroup{}
	wg.Add(len(storyIDs))

	guard := make(chan struct{}, 10)
	for _, id := range storyIDs {
		guard <- struct{}{}

		go func(id int) {
			defer func() {
				wg.Done()
				<-guard
			}()

			if _, ok := b.mapStories[id]; ok {
				return
			}

			nTries := 0
			for {
				nTries++
				if nTries >= 3 {
					break
				}

				story, err := getStory(id)
				if err != nil {
					logrus.WithError(err).WithField("id", id).Errorln("Failed to get story")
					time.Sleep(time.Second)
					continue
				}

				b.mutex.Lock()
				b.mapStories[id] = story
				b.mutex.Unlock()
				break
			}
		}(id)
	}

	wg.Wait()

	// Create final list of stories for this page
	stories := make([]Story, len(storyIDs))
	for i, id := range storyIDs {
		stories[i] = b.mapStories[id]
	}

	// Encode data to JSON
	jsonData, _ := encodeJSON(&stories)
	b.loaded(jsonData, maxPage)
}

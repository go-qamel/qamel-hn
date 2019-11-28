package backend

import (
	"fmt"
	"sync"

	"github.com/go-qamel/qamel"
	"github.com/pkg/browser"
)

// StoryDetail is back end for StoryDetail.qml
type StoryDetail struct {
	qamel.QmlObject

	_ func(id int) `slot:"loadData"`
	_ func(string) `slot:"openURL"`
	_ func(string) `signal:"loaded"`
	_ func(string) `signal:"error"`
}

func (b *StoryDetail) loadData(id int) {
	go b.fetchStory(id)
}

func (b *StoryDetail) openURL(url string) {
	err := browser.OpenURL(url)
	if err != nil {
		b.error(fmt.Sprintf("Failed to open url: %v", err))
	}
}

func (b *StoryDetail) fetchStory(id int) {
	// Fetch story from HN API
	story, err := getStory(id)
	if err != nil {
		b.error(fmt.Sprintf("Failed to load story: %v", err))
		return
	}

	// Get all comments from the story recursively
	comments, err := b.fetchComments(story)
	if err != nil {
		b.error(fmt.Sprintf("Failed to load story: %v", err))
		return
	}

	// Encode data to JSON
	finalData := map[string]interface{}{
		"story":    story,
		"comments": comments,
	}

	jsonData, _ := encodeJSON(&finalData)
	b.loaded(jsonData)
}

func (b *StoryDetail) fetchComments(parent interface{}) ([]Comment, error) {
	// Get list of IDs to be fetched from the parent
	var parents []int
	var parentKids []int
	switch tp := parent.(type) {
	case Story:
		parents = []int{tp.ID}
		parentKids = tp.Kids
	case Comment:
		parents = append(tp.Parents, tp.ID)
		parentKids = tp.Kids
	default:
		return nil, fmt.Errorf("invalid parent type")
	}

	// Create initial variable
	wg := sync.WaitGroup{}
	mutex := sync.Mutex{}
	mapResults := make(map[int][]Comment)
	wg.Add(len(parentKids))

	// Download each comment recursively
	for _, id := range parentKids {
		go func(id int) {
			defer wg.Done()

			tempComment, err := getComment(id)
			if err != nil {
				return
			}
			tempComment.Parents = parents

			tempResults := append([]Comment{}, tempComment)
			if len(tempComment.Kids) > 0 {
				comments, err := b.fetchComments(tempComment)
				if err != nil {
					return
				}

				for _, comment := range comments {
					tempResults = append(tempResults, comment)
				}
			}
			tempResults[0].Descendants = len(tempResults) - 1

			mutex.Lock()
			mapResults[id] = tempResults
			mutex.Unlock()
		}(id)
	}

	wg.Wait()

	// Create final results
	results := []Comment{}
	for _, id := range parentKids {
		results = append(results, mapResults[id]...)
	}

	return results, nil
}

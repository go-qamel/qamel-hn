package backend

import (
	"fmt"

	"github.com/go-resty/resty"
)

func getStoryIDs(storiesType string) ([]int, error) {
	// Get API URL
	apiPath := ""
	switch storiesType {
	case "top":
		apiPath = "topstories.json"
	case "new":
		apiPath = "newstories.json"
	case "ask":
		apiPath = "askstories.json"
	case "show":
		apiPath = "showstories.json"
	case "jobs":
		apiPath = "jobstories.json"
	default:
		apiPath = "topstories.json"
	}

	// Fetch list of ids
	storyIDs := []int{}
	_, err := resty.R().
		SetResult(&storyIDs).
		Get("https://hacker-news.firebaseio.com/v0/" + apiPath)
	if err != nil {
		return nil, err
	}

	return storyIDs, nil
}

func getStory(id int) (Story, error) {
	story := Story{}
	storyURL := fmt.Sprintf("https://hacker-news.firebaseio.com/v0/item/%d.json", id)
	_, err := resty.R().SetResult(&story).Get(storyURL)

	return story, err
}

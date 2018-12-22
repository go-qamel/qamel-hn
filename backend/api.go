package backend

import (
	"fmt"

	"github.com/go-resty/resty"
)

// Story is the story that submitted in HN
type Story struct {
	ID          int       `json:"id"`
	By          string    `json:"by"`
	Title       string    `json:"title"`
	URL         string    `json:"url"`
	Text        string    `json:"text"`
	Time        int64     `json:"time"`
	Score       int       `json:"score"`
	Descendants int       `json:"descendants"`
	Kids        []int     `json:"kids"`
	Comments    []Comment `json:"comments"`
}

// Comment is the comment that submitted in HN
type Comment struct {
	ID          int    `json:"id"`
	By          string `json:"by"`
	Text        string `json:"text"`
	Time        int64  `json:"time"`
	Parent      int    `json:"parent"`
	Parents     []int  `json:"parents"`
	Kids        []int  `json:"kids"`
	Descendants int    `json:"descendants"`
	Dead        bool   `json:"dead"`
}

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

func getComment(id int) (Comment, error) {
	comment := Comment{}
	commentURL := fmt.Sprintf("https://hacker-news.firebaseio.com/v0/item/%d.json", id)
	_, err := resty.R().SetResult(&comment).Get(commentURL)

	return comment, err
}

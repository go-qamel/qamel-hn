package backend

import (
	"fmt"
	"math"
	"sync"
	"time"

	"github.com/RadhiFadlillah/qamel"
	"github.com/sirupsen/logrus"
)

// ListStory is back end for ListStory.qml
type ListStory struct {
	qamel.QmlObject

	storyIDs   []int
	mapStories map[int]Story
	mutex      sync.Mutex

	_ string `property:"storiesType"`

	_ func(page int)    `slot:"loadData"`
	_ func(string, int) `signal:"loaded"`
	_ func(string)      `signal:"error"`
}

func (b *ListStory) loadData(page int) {
	go b.fetchStories(page)
	// jsonData := `[{"by":"OrangeTux","id":18714985,"kids":[18715242,18715121],"score":69,"title":"Python gets a new governance model","url":"https://lwn.net/SubscriberLink/775105/5db16cfe82e78dc3/","text":"","time":1545219883},{"by":"HeinZawHtet","id":18713844,"kids":[18714727,18714275,18715007,18714236,18715067,18714459,18714605,18715033],"score":149,"title":"Writing copy for landingpages","url":"https://stripe.com/atlas/guides/landing-page-copy","text":"","time":1545204448},{"by":"slobodan_","id":18715131,"kids":[18715244,18715235],"score":12,"title":"Serverless and startups","url":"https://aws.amazon.com/blogs/aws/serverless-and-startups/","text":"","time":1545222334},{"by":"laurentdc","id":18705200,"kids":[18715124,18713982,18714552,18714098,18713656,18714558,18714105,18713799,18713915,18714097,18714088,18714110,18713888],"score":201,"title":"Building a Spotify Player for My Mac SE/30","url":"https://68kmla.org/forums/index.php?/topic/55998-building-a-spotify-player-for-my-mac-se30/","text":"","time":1545120830},{"by":"adgasf","id":18705621,"kids":[18714831],"score":39,"title":"Program Verification with F* (2017)","url":"http://prosecco.gforge.inria.fr/personal/hritcu/teaching/mpri-jan2017/","text":"","time":1545129056},{"by":"varal7","id":18714406,"kids":[18714881],"score":34,"title":"Show HN: A new annotation tool for information extraction with Mechanical Turk","url":"https://github.com/varal7/ieturk","text":"","time":1545211784},{"by":"learnaholic","id":18713488,"kids":[18715280,18714970,18714470,18714211,18714758,18713978,18714565,18714774,18714390,18714805,18714568,18714320,18714602,18714839,18713899,18713995,18714310,18714003,18714095,18714242,18714107],"score":121,"title":"Shanghai City in panoramic view in 195 gigapixels","url":"http://sh-meet.bigpixel.cn/","text":"","time":1545200008},{"by":"xuande","id":18715230,"kids":null,"score":3,"title":"LibreRouter: Powering community networks with freeand open hardware","url":"https://blog.apnic.net/2018/12/18/librerouter-powering-community-networks-with-free-and-open-hardware/","text":"","time":1545223868},{"by":"gavino","id":18714461,"kids":[18715198,18714875,18714976,18715187,18714843],"score":40,"title":"Show HN: CoolQLCool – Turn Websites into GraphQL Accessible APIs","url":"https://coolql.cool","text":"","time":1545212533},{"by":"fanf2","id":18714981,"kids":[18715213],"score":23,"title":"Evaluating high availability solutions for TimescaleDB and PostgreSQL","url":"https://blog.timescale.com/high-availability-timescaledb-postgresql-patroni-a4572264a831","text":"","time":1545219783},{"by":"colinprince","id":18707776,"kids":[18714553,18714579,18714423,18714452,18714210],"score":58,"title":"Path Tracing vs. Ray Tracing (2016)","url":"https://www.dusterwald.com/2016/07/path-tracing-vs-ray-tracing/","text":"","time":1545150266},{"by":"matt_d","id":18712832,"kids":[18713845,18713328,18713601,18713362,18713442,18713299,18713787,18713215,18713172],"score":108,"title":"Searching statically-linked vulnerable library functions in executable code","url":"https://googleprojectzero.blogspot.com/2018/12/searching-statically-linked-vulnerable.html","text":"","time":1545190827},{"by":"boyd","id":18715079,"kids":null,"score":1,"title":"One Codex is hiring a senior front-end engineer – Genomics, data viz, React","url":"https://jobs.onecodex.com/o/software-engineer-front-end","text":"","time":1545221296},{"by":"evan_","id":18710205,"kids":[18714200,18715107,18714048,18714741,18714076,18714654,18713842],"score":108,"title":"Dad and the Egg Controller","url":"https://www.pentadact.com/2018-12-18-dad-and-the-egg-controller/","text":"","time":1545164679},{"by":"Hooke","id":18710079,"kids":[18714245,18713232,18713505,18713507,18713886,18714060],"score":87,"title":"The universal decay of collective memory and attention","url":"https://www.nature.com/articles/s41562-018-0474-5","text":"","time":1545163756},{"by":"luu","id":18710440,"kids":[18715228,18710505],"score":6,"title":"The unknown hackers (2000)","url":"https://www.salon.com/2000/05/17/386bsd/","text":"","time":1545166378},{"by":"arctux","id":18711599,"kids":[18712480,18712531,18712437,18712416,18712864,18711795,18712318,18712708],"score":196,"title":"Librem 5 devkits are shipping","url":"https://puri.sm/posts/2018-devkits-are-shipping/","text":"","time":1545175998},{"by":"liamzebedee","id":18711980,"kids":[18714055,18712089,18714756,18714668,18712490,18713226,18712671,18713568,18712113,18712914,18712407,18712537,18714127],"score":157,"title":"Kademlia:A Peer-To-peer Information System Based on the XOR Metric (2002) [pdf]","url":"https://pdos.csail.mit.edu/~petar/papers/maymounkov-kademlia-lncs.pdf","text":"","time":1545179851},{"by":"prostoalex","id":18713436,"kids":[18714539,18713896,18715191,18713587,18713608,18713851,18713602,18713887,18714847,18714338,18713737,18714004,18714258,18713999,18713914,18714913,18713654,18714467,18714216,18713681,18714350,18713739,18713941,18714182,18713630,18714596,18714873,18713853,18714272,18713715,18713821,18714687],"score":389,"title":"Windows Sandbox","url":"https://techcommunity.microsoft.com/t5/Windows-Kernel-Internals/Windows-Sandbox/ba-p/301849?ranMID=43674\u0026ranEAID=je6NUbpObpQ\u0026ranSiteID=je6NUbpObpQ-_UZUOlZ2ZyTOTejYypcnAQ\u0026epi=je6NUbpObpQ-_UZUOlZ2ZyTOTejYypcnAQ\u0026irgwc=1\u0026OCID=AID681541_aff_7795_1243925\u0026tduid=(ir__i0avhykzmgkfrw2i0ckzh9lp2u2xhyajo2v1pvjr00)(7795)(1243925)(je6NUbpObpQ-_UZUOlZ2ZyTOTejYypcnAQ)()\u0026irclickid=_i0avhykzmgkfrw2i0ckzh9lp2u2xhyajo2v1pvjr00","text":"","time":1545199276},{"by":"jumelles","id":18712382,"kids":[18712431,18712484,18712441,18712860,18713975,18713508,18712884,18713144,18712629,18713312,18715026,18714389,18712589,18712672,18714422,18714718,18713113,18712564,18712998,18713101,18713631,18712591,18713761,18712388,18712643,18713363,18713112,18712385,18712764,18712565],"score":359,"title":"As Facebook Raised a Privacy Wall, It Carvedan Opening for Tech Giants","url":"https://www.nytimes.com/2018/12/18/technology/facebook-privacy.html","text":"","time":1545184315}]`
	// b.loaded(jsonData, 1)
}

func (b *ListStory) fetchStories(page int) {
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
	maxPage := int(math.Floor(float64(len(b.storyIDs))/20.0 + 0.5))

	// Make sure page doesn't pass max page
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

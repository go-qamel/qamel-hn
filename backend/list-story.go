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

	_ func()            `slot:"clearCache"`
	_ func(page int)    `slot:"loadData"`
	_ func(string, int) `signal:"loaded"`
	_ func(string)      `signal:"error"`
}

func (b *ListStory) clearCache() {
	b.mutex.Lock()
	b.storyIDs = []int{}
	b.mapStories = map[int]Story{}
	b.mutex.Unlock()

	b.loadData(1)
}

func (b *ListStory) loadData(page int) {
	go b.fetchStories(page)
	// jsonData := `[{"id":18724107,"by":"jwildeboer","title":"Slack is closing accounts of ethnic Iranians, even when they live abroad","url":"https://twitter.com/a_h_a/status/1075510422617219077","text":"","time":1545306656,"score":133,"descendants":43,"kids":[18724451,18724258,18724304,18724373,18724432,18724279,18724394,18724288,18724333,18724438,18724412,18724446,18724318,18724443,18724222,18724398]},{"id":18723936,"by":"johanhammar","title":"VirtualBox 6.0 released","url":"https://www.virtualbox.org/wiki/Changelog-6.0#v0","text":"","time":1545304187,"score":89,"descendants":42,"kids":[18724174,18724087,18724379,18724421,18724076,18724272,18724140,18724269,18724282,18724203,18724149,18724151]},{"id":18720850,"by":"ingve","title":"For First Time in More Than 20 Years, Copyrighted Works Will Enter Public Domain","url":"https://www.smithsonianmag.com/arts-culture/first-time-20-years-copyrighted-works-enter-public-domain-180971016/?preview","text":"","time":1545261191,"score":618,"descendants":201,"kids":[18723654,18721082,18722360,18721587,18721783,18724200,18721025,18721352,18721386,18721407,18721744,18721510,18722488,18721752,18723566,18723334,18721302,18721185,18723497,18723154]},{"id":18715440,"by":"Dowwie","title":"Knowledge from small number of debates outperforms wisdom of large crowds (2017)","url":"https://arxiv.org/abs/1703.00045##","text":"","time":1545226413,"score":74,"descendants":29,"kids":[18723965,18723422,18724064,18723542,18723311,18715805,18723933]},{"id":18719816,"by":"ductionist","title":"Introducing Project Mu","url":"https://blogs.windows.com/buildingapps/2018/12/19/%e2%80%afintroducing-project-mu/","text":"","time":1545254731,"score":404,"descendants":125,"kids":[18720195,18723476,18720826,18721225,18720570,18723596,18720806,18722242,18720439,18721049,18722101,18723658,18720169,18722093,18720092,18720717,18722207,18723690,18723159,18721768,18721699,18720202,18721252,18721641,18723198,18720371,18720240,18722508,18720314,18723304,18720158]},{"id":18721754,"by":"lawrenceyan","title":"Alphabet spinoff Malta raises $26M for technology to store power in molten salt","url":"https://www.bloomberg.com/news/articles/2018-12-19/gates-bezos-among-billionaires-backing-alphabet-energy-spinoff","text":"","time":1545269251,"score":187,"descendants":101,"kids":[18723549,18724000,18722885,18722756,18721948,18721786,18722592,18721979,18723212,18723129,18722628,18722181,18722830,18722041,18721921,18722252,18723224,18722219,18721923,18723585]},{"id":18721635,"by":"bonyt","title":"WireGuard for iOS","url":"https://lists.zx2c4.com/pipermail/wireguard/2018-December/003694.html","text":"","time":1545267949,"score":217,"descendants":40,"kids":[18723533,18721797,18724009,18723006,18723421,18722877,18723498,18723050,18723260,18723644,18722662,18723647,18722680,18723735,18723650]},{"id":18721555,"by":"Tideflat","title":"MagicaVoxel: A free voxel art editor and path tracing renderer","url":"https://ephtracy.github.io/","text":"","time":1545267194,"score":217,"descendants":34,"kids":[18721970,18722941,18722288,18721697,18723828,18722589,18722505,18721763]},{"id":18721594,"by":"alexyoung","title":"MiSTer: Run Amiga, SNES, NES and Genesis on an FPGA","url":"https://github.com/MiSTer-devel/Main_MiSTer/wiki","text":"","time":1545267531,"score":127,"descendants":20,"kids":[18722456,18721739,18723697]},{"id":18723676,"by":"stargazer-3","title":"Max Planck Society Discontinues Agreement with Elsevier","url":"https://www.mpdl.mpg.de/en/505","text":"","time":1545300144,"score":89,"descendants":12,"kids":[18724455,18724427,18723781,18723863,18724300,18723743,18723812]},{"id":18715145,"by":"Down_n_Out","title":"Breakthrough ultrasound treatment to reverse dementia moves to human trials","url":"https://newatlas.com/ultrasound-dementia-alzheimers-human-trials/57725/","text":"","time":1545222531,"score":89,"descendants":18,"kids":[18723467,18716208,18723642,18723437,18716132,18723115]},{"id":18714634,"by":"vermaden","title":"The Future of ZFS in FreeBSD","url":"https://lists.freebsd.org/pipermail/freebsd-current/2018-December/072422.html","text":"","time":1545214761,"score":219,"descendants":76,"kids":[18723332,18717340,18722184,18722398,18717333,18717228,18721589,18721417,18714637,18718302,18722457,18722778]},{"id":18722541,"by":"Osiris30","title":"A Lens-Less Camera Built Specially for AI and Computer Vision Programs","url":"https://spectrum.ieee.org/tech-talk/computing/software/a-lensless-camera-built-specially-for-ai-and-computer-vision-programs-sorry-humans","text":"","time":1545280503,"score":67,"descendants":9,"kids":[18724385,18722965,18723684,18723701,18723486]},{"id":18721513,"by":"wglb","title":"On VBScript","url":"https://googleprojectzero.blogspot.com/2018/12/on-vbscript.html","text":"","time":1545266845,"score":98,"descendants":57,"kids":[18722044,18724223,18721861,18722538,18721528,18722365,18723309,18722276,18723417]},{"id":18717168,"by":"philliphaydon","title":"Bye Bye Mongo, Hello Postgres","url":"https://www.theguardian.com/info/2018/nov/30/bye-bye-mongo-hello-postgres","text":"","time":1545239333,"score":1384,"descendants":361,"kids":[18718447,18718364,18719650,18723573,18718483,18718154,18719132,18718488,18718858,18723921,18720807,18719160,18717643,18717838,18719259,18720855,18723681,18719195,18720830,18719460,18720134,18718207,18718869,18718567,18718210,18719336,18717600,18719035,18719270,18720043,18722884,18718192,18722375,18721230,18720875,18718431,18719659,18721702,18721866,18719678,18719247,18723458,18721462,18720157,18718593,18718448,18719135,18718068,18720194,18721356,18718953,18718484,18717922,18723633,18721544,18721548]},{"id":18720175,"by":"ChuckMcM","title":"Korg NuTube, vacuum tube for the 21st century","url":"https://korgnutube.com/en/","text":"","time":1545256974,"score":147,"descendants":69,"kids":[18721020,18721147,18721160,18723442,18720610,18720520,18720603,18721093,18720763,18720188,18721568,18721022,18720522,18720941,18720965,18720922]},{"id":18722548,"by":"MikusR","title":"Work with Git Forges inside Emacs","url":"https://emacsair.me/2018/12/19/forge-0.1/","text":"","time":1545280733,"score":71,"descendants":3,"kids":[18724410,18723090,18723734]},{"id":18714154,"by":"filipkappa","title":"3D airplane visualization","url":"https://mdbootstrap.com/snippets/jquery/ascensus/212648","text":"","time":1545208510,"score":93,"descendants":20,"kids":[18714819,18722982,18722519,18715582,18716368,18714937,18714702,18714859]},{"id":18722547,"by":"vojtamolda","title":"Show HN: Autodrome – Framework for Development of Self-Driving Cars","url":"https://github.com/vojtamolda/autodrome/","text":"","time":1545280732,"score":35,"descendants":7,"kids":[18723171,18723452]},{"id":18715116,"by":"etiam","title":"We Have Given People Amyloid Disease","url":"http://blogs.sciencemag.org/pipeline/archives/2018/12/17/we-have-given-people-amyloid-disease","text":"","time":1545222005,"score":100,"descendants":8,"kids":[18724039,18723170,18723691,18720733]}]`
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

package backend

import (
	"bytes"
	"encoding/json"
)

func init() {
	RegisterQmlStoryList("BackEnd", 1, 0, "BackEndStoryList")
}

func encodeJSON(src interface{}) (string, error) {
	bt, err := json.Marshal(src)
	return string(bt), err
}

func decodeJSON(jsonString string, dst interface{}) error {
	buffer := bytes.NewBufferString(jsonString)
	err := json.NewDecoder(buffer).Decode(dst)
	return err
}

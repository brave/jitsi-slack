package jitsi

import (
	"crypto/rand"
	"encoding/base64"
	"fmt"
)

// RandomName will generate a new video name randomly.
func RandomName() string {
	// grab 256 bits randomly
	b := make([]byte, 32)
	_, err := rand.Read(b)
	if err != nil {
		// should not get here, if we do there is no more randomness
		panic(fmt.Sprintf("error making room name: %s", err.Error()))
	}
	// return url safe base64 encoded string
	return string(base64.URLEncoding.EncodeToString(b[:]))
}

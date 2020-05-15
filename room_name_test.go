package jitsi

import (
	"fmt"
	"regexp"
	"testing"
)

var roomNameRE = regexp.MustCompile(`^[A-Za-z0-9-_]{43}$`)

func TestRandomName(t *testing.T) {
	for i := 0; i < 10; i++ {
		var name = RandomName()
		fmt.Println("name: ", name)
		fmt.Println("name length: ", len(name))
		if !roomNameRE.Match([]byte(name)) {
			t.Error("failed to match the pre-existing regular expression")
		}
	}
}

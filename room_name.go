package jitsi

import (
	"crypto/rand"
	"fmt"
	"math/big"
	"strings"
)

var (
	roomAlphabet = []byte("abcdefghijklmnopqrstubwxyzABCDEFGHIJKLMNOPQRSTUBWXYZ0123456789-_")
	roomLength   = 43
)

// RandomName will generate a new video name randomly.
func RandomName() string {
	roomName := strings.Builder{}
	for i := 0; i < 43; i++ {
		j, err := rand.Int(rand.Reader, big.NewInt(int64(len(roomAlphabet)-1)))
		if err != nil {
			// should not get here, if we do there is no more randomness
			panic(fmt.Sprintf("error making room name, randomness: %s", err.Error()))
		}
		err = roomName.WriteByte(roomAlphabet[int(j.Int64())])
		if err != nil {
			// should not get here, if we do there is no more randomness
			panic(fmt.Sprintf("error making room name, name building: %s", err.Error()))
		}
	}
	return roomName.String()
}

package decode

import (
	"strconv"
	"strings"
)

// Decode decodes the message encoded by Encode
func Decode(message string) string {
	// Stage 1, unreverse the letters
	// we'll need to create a temporary slice to help us with that
	tmpSlice := []byte{}
	// we'll also need to extract the length of the original string, we do that by getting the last part of the string after the _
	characters, _ := strconv.Atoi(strings.Split(message, "_")[1])
	// then we  loop backwards
	for i := characters - 1; i >= 0; i-- {
		// add each letter backwards to the slice
		tmpSlice = append(tmpSlice, message[i])
	}
	// then we loop again and shift each letter back 1
	for i := 0; i < characters; i++ {
		tmpSlice[i] = tmpSlice[i] - 1
	}
	// then we return it as a string
	return string(tmpSlice)
}

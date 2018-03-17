package encode

import (
	"fmt"
	"strings"
)

// Encode encodes a message that can be decrypted by the Decode function
// Requires a string to be passed
func Encode(message string) string {
	// Count the number of characters in the message
	characters := len(message)
	// create a temporary array to store each new letter
	tmpSlice := []byte{}
	// loop through the message
	for i := 0; i < characters; i++ {
		// get the letter and shift it up one and append it to the tmpArr slice
		letter := message[i] + 1
		tmpSlice = append(tmpSlice, letter)
	}
	// after the loop convert the slice to a string
	message = string(tmpSlice)
	// and reverse it by first clearing the tmpSlice and reusing it
	tmpSlice = []byte{}
	// then looping backwords
	for i := characters - 1; i >= 0; i-- {
		// add each letter backwards to the slice
		tmpSlice = append(tmpSlice, message[i])
	}
	// convert the slice to a string again
	message = string(tmpSlice)
	// replace all double quotes with backslash doublequote
	message = strings.Replace(message, "\"", "\\\"", -1)
	return fmt.Sprintf("%s_%d", message, characters)
}

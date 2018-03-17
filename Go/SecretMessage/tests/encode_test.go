package tests

import (
	"SecretMessage/encode"
	"fmt"
	"testing"
)

func ExampleEncode() {
	// Encode a test message
	encoded := encode.Encode("Hello World!")
	fmt.Println(encoded)
	// Output: \"emspX!pmmfI_12
}

func TestEncode(t *testing.T) {
	// Encode a test message
	encoded := encode.Encode("Hello World!")
	fmt.Println(encoded)
	// make sure that it doesn't equal Hello World!_12
	if encoded == "Hello World!_12" || encoded == "" {
		t.Error("Encoded string should not be Hello World!_12 and it should not be blank!")
	}
}

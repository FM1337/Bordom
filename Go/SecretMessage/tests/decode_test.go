package tests

import (
	"SecretMessage/decode"
	"fmt"
)

func ExampleDecode() {
	// Decode an encoded message
	decoded := decode.Decode("\"emspX!pmmfI_12")
	fmt.Println(decoded)
	// Output: Hello World!
}

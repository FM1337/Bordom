package main

import (
	"SecretMessage/decode"
	"SecretMessage/encode"
	"bufio"
	"fmt"
	"os"
	"strings"
)

func main() {
	if len(os.Args) < 3 {
		fmt.Println("You must specify a message to encode/decode!")
		os.Exit(1)
	}
	message := strings.Join(os.Args[2:], " ")
	method := os.Args[1]

	if method == "encode" {
		fmt.Println(encode.Encode(message))
		fmt.Print("Press 'Enter' to exit...")
		bufio.NewReader(os.Stdin).ReadBytes('\n')

	} else if method == "decode" {
		fmt.Println(decode.Decode(message))
		fmt.Print("Press 'Enter' to exit...")
		bufio.NewReader(os.Stdin).ReadBytes('\n')

	} else {
		fmt.Println("You must specify whether you want to decode or encode a message!")
		os.Exit(1)
	}
}

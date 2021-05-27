package main

import (
	"flag"
	"fmt"

	"{{RepoBase}}/{{RepoGroup}}/{{Name}}/version"
)

var (
	printVersion = flag.Bool("version", false, "print version of this build")
)

func main() {
	flag.Parse()
	if *printVersion {
		version.PrintFullVersionInfo()
		return
	}
	fmt.Println("{{Name}}")
}

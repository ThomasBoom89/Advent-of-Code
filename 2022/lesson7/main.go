package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

const (
	separator = "_"
)

var currentPath []string
var dirMap map[string]int64

func main() {
	lessonA()
	lessonB()
}

func lessonB() {
	file, err := os.Open("input.txt")
	if err != nil {
		panic(err)
	}
	defer file.Close()

	dirMap = make(map[string]int64)
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		if line == "" {
			break
		}
		lineSplitted := strings.Split(line, " ")
		if lineSplitted[0] == "$" {
			if lineSplitted[1] != "cd" {
				continue
			}
			handleCD(lineSplitted[2])
		} else if lineSplitted[0] == "dir" {
			continue
		} else {
			handleFile(lineSplitted[0])
		}
	}

	var toFree int64 = 30_000_000 - (70_000_000 - dirMap["/"])
	var smallest int64 = 0
	for _, value := range dirMap {
		if value >= toFree {
			if smallest == 0 {
				smallest = value
			} else if value < smallest {
				smallest = value
			}
		}
	}

	fmt.Println("Result: ", smallest)
}

func lessonA() {
	file, err := os.Open("input.txt")
	if err != nil {
		panic(err)
	}
	defer file.Close()

	dirMap = make(map[string]int64)
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		if line == "" {
			break
		}
		lineSplitted := strings.Split(line, " ")
		if lineSplitted[0] == "$" {
			if lineSplitted[1] != "cd" {
				continue
			}
			handleCD(lineSplitted[2])
		} else if lineSplitted[0] == "dir" {
			continue
		} else {
			handleFile(lineSplitted[0])
		}
	}

	var sum int64 = 0
	for _, value := range dirMap {
		if value <= 100000 {
			sum += value
		}
	}

	fmt.Println("Result: ", sum)
}

func handleFile(size string) {
	sizeInt, err := strconv.ParseInt(size, 10, 32)
	if err != nil {
		println("junge parse mal richtig den int")
		panic(err)
	}
	length := len(currentPath)
	for i := length; i > 0; i-- {
		key := strings.Join(currentPath[:i], separator)
		dirMap[key] = dirMap[key] + sizeInt
	}
}

func handleCD(param string) {
	if param == ".." {
		currentPath = currentPath[:len(currentPath)-1]
	} else {
		currentPath = append(currentPath, param)
	}

}

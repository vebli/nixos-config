package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

var luhnBase32 = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567"

func codepoint32(b byte) int {
	switch {
	case 'A' <= b && b <= 'Z':
		return int(b - 'A')
	case '2' <= b && b <= '7':
		return int(b + 26 - '2')
	default:
		return -1
	}
}

func luhn32(s string) (rune, error) {
	factor := 1
	sum := 0
	const n = 32

	for i := range s {
		codepoint := codepoint32(s[i])
		if codepoint == -1 {
			return 0, fmt.Errorf("invalid character %q", s[i])
		}
		addend := factor * codepoint
		if factor == 2 {
			factor = 1
		} else {
			factor = 2
		}
		addend = (addend / n) + (addend % n)
		sum += addend
	}
	remainder := sum % n
	checkCodepoint := (n - remainder) % n
	return rune(luhnBase32[checkCodepoint]), nil
}

func formatDeviceID(input string) (string, error) {
	// Remove padding (if any)
	input = strings.TrimRight(input, "=")

	if len(input) != 52 {
		return "", fmt.Errorf("input must be exactly 52 base32 characters")
	}

	var groups []string
	for i := 0; i < 52; i += 13 {
		group := input[i : i+13]
		checkDigit, err := luhn32(group)
		if err != nil {
			return "", err
		}
		groups = append(groups, group+string(checkDigit))
	}

	// Join groups and insert dashes every 7 characters
	rawID := strings.Join(groups, "")
	var formattedID strings.Builder
	for i, char := range rawID {
		if i > 0 && i%7 == 0 {
			formattedID.WriteRune('-')
		}
		formattedID.WriteRune(char)
	}

	return formattedID.String(), nil
}

func main() {
	reader := bufio.NewReader(os.Stdin)
	input, _ := reader.ReadString('\n')
	input = strings.TrimSpace(input)

	if input == "" {
		fmt.Println("Error: No input provided")
		os.Exit(1)
	}

	deviceID, err := formatDeviceID(input)
	if err != nil {
		fmt.Println("Error:", err)
		os.Exit(1)
	}

	fmt.Println(deviceID)
}

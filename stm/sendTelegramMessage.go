package main

import (
  "fmt"
  "flag"
  "os"
  "net/http"
  "log"
)

const firstUrlPart string = "https://api.telegram.org/bot"
const secondUrlPart string = "/sendMessage?chat_id="
const finalUrlPart string = "&text="

const defaultBotApiKey string = "424848481:AAE0E8-1QX8Wf8LBhoChYLbLWiJjNvh_OqA"
const defaultChatId string = "157875449"

func main() {
  botApiKey, chatId, textMessage := getParameters()
  sendMessage(botApiKey, chatId, textMessage)
}

// Gets the required botApiKey, chatId and text message to send from the CLI args.
func getParameters() (string, string, string) {
  checkForNoArgs()
  botApiKey, chatId := parseFlags()
  var textMessage string = flag.Args()[0]
  return botApiKey, chatId, textMessage
}

// Parses CLI flags and gives them a default value.
func parseFlags() (string, string) {
	var botApiKeyPtr = flag.String("bot", defaultBotApiKey, "Telegram bot API key")
	var chatIdPtr = flag.String("chat", defaultChatId, "Telegram chat identifier")
	flag.Parse()
	return *botApiKeyPtr, *chatIdPtr
}

// Builds the URL to which send the GET request.
func buildURL(botApiKey string, chatId string, textMessage string) string {
	return firstUrlPart + botApiKey + secondUrlPart + chatId + finalUrlPart + textMessage
}

// Checks the number of CLI arguments. If there's only one (so no arguments since 1 is the prog), prints
// the help message and stops execution.
func checkForNoArgs() {
  if len(os.Args) == 1 {
    printHelp()
    os.Exit(0)
  }
}

// Prints a usage message for the user.
func printHelp() {
  fmt.Println("Usage: stm [options] message")
  fmt.Println("  options: check the man page.")
  fmt.Println("  message: the text message to be sent over Telegram. Remember to surround it in double quotes if it contains spaces.")
  fmt.Println("\nExample: stm -bot=82AB71 -chat=193712 \"Hello, world!\"")
}

// Sends the message through Telegram using the specified bot (botApiKey) to the specified user (chatId).
func sendMessage(botApiKey string, chatId string, textMessage string) {
  var url = buildURL(botApiKey, chatId, textMessage)
  sendGetRequest(url)
}

// Makes a GET request to the telegram endpoint, sending the message through the REST API.
func sendGetRequest(url string) {
  resp, err := http.Get(url)
  if err != nil {
  	log.Fatal(err)
  }
  defer resp.Body.Close()
}

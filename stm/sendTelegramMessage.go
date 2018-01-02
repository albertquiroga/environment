package main

import "os"
import "fmt"

func main() {

  var firstUrlPart string = "https://api.telegram.org/bot"
  var botApiKey string = "424848481:AAE0E8-1QX8Wf8LBhoChYLbLWiJjNvh_OqA"
  var secondUrlPart string = "/sendMessage?chat_id="
  var chatId string = "157875449"
  var finalUrlPart string = "&text="
  var textMessage string = os.Args[1]

  fmt.Println(firstUrlPart + botApiKey + secondUrlPart + chatId + finalUrlPart + textMessage)

}

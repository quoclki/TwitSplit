# TwitSplitDemo
TwitSplit Project for ZALORA's pre-interview assignment

# Environment
- Xcode 9.4.1
- Swift 4.1

# What I've done
- iOS application that serves the Tweeter interface.
- Split Message funtion
- Unit Test for Split Message funtion
- Documentation.

# Workflow of Split Message
- **Step 1:** Trim input message.
- **Step 2:** Check if message length is valid then return message.
- **Step 3:** Split message with space character into array.
- **Step 4:** Check if message is a span of non-whitespace characters longer than the limit characters then return error.
- **Step 5:** Split message.
  - **Step 5.1:** Begin total page splited by 1.
  - **Step 5.2:** Calculate the long of message with the part indicators.
  - **Step 5.3:** Check if total of message return more 10 power total page splited, increase total page + 1, go to 5.1.
- **Step 6:** Return the chunks splited from the input message.

# What I want to improve
- Improving the UI:
- Hide navigation bar when scroll tableView to extend the content of tableView
- Action on display message (edit, delete, show length of message...)
- Setting to change the limit character

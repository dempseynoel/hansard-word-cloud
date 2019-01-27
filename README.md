# hansard-word-cloud
This is a simple Twitter bot which posts a daily word cloud summary of what was said in the House of Commons Chamber during the previous day. The bot posts to the following account: [Echoing the Chamber](https://twitter.com/EchoingChamber).

### How it works
Each morning, at around 7am, the Hansard record for the previous day is downloaded and 100 of the most frequently recorded words are extracted. These words are then plotted into a word cloud which is automatically posted to Twitter through its API.

Not all words contained within the Hansard record will be considered for the word cloud. Common stop words, such as 'the', 'or', and 'if' have been removed as well as parliamentary based stop words such as 'speaker', 'honourable' and 'intervention'.

In some cases the word cloud will not contain 100 words; if a word cannot be fitted within the area of the chart it will be dropped.

Currently, the automatic scheduling of the bot is through an AppleScript in conjuction with Power Manager. Advice on how to move to an alternative method is welcome.  

### Credit
This project was inspired by a similar [Twitter bot](https://twitter.com/wmbubble) created by my colleague, [Oli Hawkins](https://github.com/olihawkins).

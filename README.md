# README

## Abstract
CREATE and READ memos through LINE app.
## Usage
### For Developers
1. Sign up LINE Developers.
2. Create a new channel.
3. Get environmental variables, which are "channel secret" and "access token".
4. Set those in your environment.
### For Users
1. Add friends memoture in your LINE account.
2. Send "text" if you want to create memo.
3. Send "一覧" if you want to get index of your memos.
4. Type "検索 (start new line) query_words" and send them if you want to get memos you want to see.
### Twitter memo
if you send tweet url, Rails detect it and get tweet's full_text through Twitter API.
And then, Rails will save tweet's full_text instead of saving tweet url user sent.
## Diagram
![memoture_diagram](https://user-images.githubusercontent.com/58697518/101764086-fdec9800-3b22-11eb-9b8b-38fdf1fe77bc.png)

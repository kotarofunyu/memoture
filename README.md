# README
※ kotarofunyuの個人用アプリです。kotarofunyu以外の利用を目的にはしていません
## 概要
メモしておきたいツイートを保存できるアプリです。
ツイートのURLをmemotureのLINEbotのトークに投稿するだけでメモできます。

## 使い方

### 保存

ツイートのURLを投稿します。

## 仕組み

ツイートのURLを送ると、Railsアプリケーション内部で Twitter APIを叩いてツイートの内容を取得して DBに保存します。

![memoture_diagram](https://user-images.githubusercontent.com/58697518/101764086-fdec9800-3b22-11eb-9b8b-38fdf1fe77bc.png)

# README

## 概要
CREATE and READ memos through LINE app.
メモしておきたいツイートを保存できるアプリです。
ツイートのURLをmemotureのLINEbotのトークに投稿するだけでメモできます。

## 使い方

### 保存

### 参照

#### 検索

一行目に検索という文字列を入力、
二行目に検索したい文字列を入力して投稿します。

指定された文字列を含むツイートの一覧が返ります。

以下を投稿すると、「オブジェクト指向」を含むツイートの一覧が返ります。

```text
検索
オブジェクト指向
```

#### 一覧

一覧という文字列を入力して投稿します。
全件が返ります。

## 仕組み

ツイートのURLを送ると、Railsアプリケーション内部で Twitter APIを叩いてツイートの内容を取得して DBに保存します。

![memoture_diagram](https://user-images.githubusercontent.com/58697518/101764086-fdec9800-3b22-11eb-9b8b-38fdf1fe77bc.png)

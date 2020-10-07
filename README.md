## AiBC (Aiming for the Best Contents)
Qiita記事からAPI通信で記事を取得して閲覧するアプリです。

## 概要

[Qiita API](https://qiita.com/api/v2/docs#%E6%A6%82%E8%A6%81) を使用して記事一覧を取得します。

| 一覧画面 | 検索画面 | 記事の保存画面 |
| :-----: | :-----: |
| !
[AiBC_getArticle.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/192876/fdd4d264-b78c-baa4-4456-f67a1f5da553.gif) | ![AiBC_searchArticle.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/192876/1ce27ce6-bc43-3d4f-7cf9-b9505429cf77.gif) | ![AiBC_stockArticle.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/192876/41a21bca-d860-44f3-dbf7-acdbcf8a59c2.gif) |

## 機能一覧

「大まかな機能」
・記事取得
・記事検索（タグ名で検索）
・記事をお気に入りし、保存する機能

「その他」
・ページネーション
・簡易的なAPIClient
・Cloudfirestoreを利用したデータの保存と取得

## 環境

・Xcode 12.0.1
・Swift 5.3

## 導入したライブラリ
※cocoapodを利用してライブラリの管理を行なっております。

・Firebase
・Firebase/Firestore
・Kingfisher
・Alamofire
・lottie-ios

## 注意
Cloudfirestoreを使用しております。GoogleService-Info.plistにセキュアな情報があると思ったので、GitHub上には載せておりません。



## 工夫したところ

・再利用性
簡易的ではありますがAPIClientを利用したアプリケーションを作成したため、今後API通信を行う際にbaseURL等を変更することで、APIClientを再利用することを可能にしました。

・設計
できる限り正しい設計を心がけました。MVCで設計しました。ModelはAPI通信やDBからデータを取得するなど、ネットワークの通信を行う役割を担っております。ViewControllerではViewのレイアウトの規定やネットワーク通信を行うようModelに指示をするようにしました。よって、ModelとViewControllerで役割をきっちり分けました。

## 苦労したところ

・設計パターンの理解
MVCで設計を行いました。Modelの役割であるビジネスロジックというものがいまいち理解できませんでした。そこで、MVCで設計されているソースコードを読んだりしました。これからMVVMやMVP、クリーンアーキテクチャなどの設計パターンに挑みたいです。

・APIClinetの作成
ItemsModelの単体でテストを書けるようにするため、QiitaAPIClient本体ではなく、Protocolを受け取るようにしました。

## 今後

以下の機能や実装を取り入れていこうと思っております。

・お気に入りに入れた記事を3日後に削除する機能
・アクセス解析ツール等を使ってユーザーの行動を分析し、記事をレコメンドできる機能
・単体とUIのテストコード
・エラーハンドリング 

モバイルアプリを作成するエンジニアになりたいので、Androidアプリも作成していきたいです。
※クロスプラットフォームを使用するか、Kotlin（もしくはJava）を使用するかは未定です。



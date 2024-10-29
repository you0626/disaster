# アプリケーション名	
  Shelter Sense  
 「避難所の感覚」という意味で、避難所情報や災害対応のセンスを強調しています。
# アプリケーション概要
  災害時に必要となる情報を取得できる。また、事前に登録しておく事で災害に備えた準備ができる。
# URL
  http://35.74.169.21/users
# テスト用アカウント
  メールアドレス：test@test.com  
  パスワード：test1234
# 利用方法
  1.登録してなくても、地震情報・気象情報・災害時の各マニュアルが使用可能。  
  2.近場の避難所を直ぐに検索できる。  
  3.オフラインでも避難所を検索できる。  
  4.フレンド登録でフレンドの最終ログイン時間が確認でき、メッセージのやり取りもできる。  
  5.必要な物を事前に登録しておき、購入後は期限を記入して管理できる。
# アプリケーションを作成した背景
  昨今の日本では地震が増加しており、いつ大地震が来てもおかしくないと言われている。  
  その中、不安を抱えている人も多いと思う。  
  その不安を少しでも取り除けるアプリケーションを作りたいと思った。
# 実装した機能についての画像やGIFおよびその説明※
  1.現在地から近い避難所をクリック一回で検索できる。オフラインでも使用できる。(ACMにて証明書申請中の為、使用不可。ローカルでは使える。)  
  [![Image from Gyazo](https://i.gyazo.com/ebd47e73d2227047f2b20336e4bc8e63.gif)](https://gyazo.com/ebd47e73d2227047f2b20336e4bc8e63)  
  [![Image from Gyazo](https://i.gyazo.com/9674a0d76f5a6133c18de8d219ad57b3.gif)](https://gyazo.com/9674a0d76f5a6133c18de8d219ad57b3)  
  [![Image from Gyazo](https://i.gyazo.com/56415dc8abd55526f7536e6c7ec07880.gif)](https://gyazo.com/56415dc8abd55526f7536e6c7ec07880)  
  2.気象庁の地震情報と気象情報が表示される。  
  地震情報（リアルタイム更新）[![Image from Gyazo](https://i.gyazo.com/3276431233bb077b261e02257627c578.png)](https://gyazo.com/3276431233bb077b261e02257627c578)  
  気象情報（データ量が多い為、手動更新）[![Image from Gyazo](https://i.gyazo.com/db449df28f974719c036249badf59944.png)](https://gyazo.com/db449df28f974719c036249badf59944)  
  3.フレンド登録した相手の最終ログイン時間が分かる。メッセージの送信もできる。 
  [![Image from Gyazo](https://i.gyazo.com/04df5e6c9fc8429e540b9e96b0d8dbe3.png)](https://gyazo.com/04df5e6c9fc8429e540b9e96b0d8dbe3)   
  [![Image from Gyazo](https://i.gyazo.com/804a5839d304d1def94c182afb33a9c9.png)](https://gyazo.com/804a5839d304d1def94c182afb33a9c9)  
  4.必要な物を入力しておける。購入した物の期限を入力しておけば期限の近い順から表示してくれる。  
  [![Image from Gyazo](https://i.gyazo.com/bf73f558c64bb957e15326eadd21fb9e.png)](https://gyazo.com/bf73f558c64bb957e15326eadd21fb9e)  
  5.災害時に役立つ各マニュアルを確認できる。  
  [![Image from Gyazo](https://i.gyazo.com/b5c3415defc0dfdcb289be1f3112616d.png)](https://gyazo.com/b5c3415defc0dfdcb289be1f3112616d)  
  [![Image from Gyazo](https://i.gyazo.com/da09b178e7f744a3d850cca1a53a6a0f.png)](https://gyazo.com/da09b178e7f744a3d850cca1a53a6a0f)  
# 実装予定の機能
  1.登録してなくても避難所を検索できる。  
  2.メッセージに画像を載せる事ができる。  
  3.他のマニュアルを追加する。
# データベース設計
  [![Image from Gyazo](https://i.gyazo.com/b774f14d12c285c1864a84982bb4c59a.png)](https://gyazo.com/b774f14d12c285c1864a84982bb4c59a)
# 画面遷移図
  [![Image from Gyazo](https://i.gyazo.com/4503fdb3da9de370cf74744ea50a4aa7.png)](https://gyazo.com/4503fdb3da9de370cf74744ea50a4aa7)
# 開発環境
  ・HTML  
  ・JavaScript  
  ・Ruby  
  ・API
# ローカルでの動作方法
  % git clone https://github.com/you0626/disaster.git  
  % cd ajax_app_rails7  
  % bundle install  
  % rails db:create  
  % rails db:migrate  
  GoogleCloudに会員登録し、GoogleMAP使用の為のAPIキーを取得し、コードの中のAPIを置き換える。（利用には料金が発生する。）
# 工夫したポイント
  もし自分が災害用アプリを必要とした時に、一つのアプリで済む様に機能を入れた。  
  また電波が繋がりにくくなっても避難所を検索できる様に、避難所のデータをダウンロードしてオフラインでも使用できるようにした。
# 改善点
  制作しているうちに、もっと機能を入れたいって思った機能を追加で実装したい。  
# 制作時間
  約三週間
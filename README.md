# POST markdown to esa

## これはなに？
[qiita-to-md](https://github.com/kawahara/qiita-to-md)でQiita::Teamから落としてきたmdファイルをesaにアップロードするプログラムです。
[qiita-to-md](https://github.com/kawahara/qiita-to-md)で、esaのアップロードをしようとしたらエラーでできなかったので、作成しました。

## 使い方
1. [qiita-to-md](https://github.com/kawahara/qiita-to-md)でmd化
2. 上記で作成した`./qiita/*`を本`./markdowns/`にコピー
3. 本プログラムを実行

## 実行方法
### セットアップ
```bash
$ bundle install
# or
$ gem install esa
```

### 実行
```bash
$ ruby main.rb --team [ESA_TEAM_NAME] --token [ESA_ACCESS_TOKEN]
```

※ 2017.05.25現在、ユーザ毎に15分間に75リクエストまでという利用制限があるため、アップロードに結構な時間を要します。
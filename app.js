const express = require('express');
const path = require('path'); // パスモジュールをインポート
const app = express();
const port = 3000;

// ミドルウェアの設定
app.use(express.json());
app.use(express.urlencoded({
  extended: false
}));

// EJSの設定
app.set('views', path.join(__dirname, 'views')); // ビューのディレクトリを設定
app.set('view engine', 'ejs'); // ビューエンジンをEJSに設定

// ルーティング設定
const testRouter = require('./routes/test'); // test.jsをインポート
app.use('/test', testRouter); // '/test' パスに対するルートを設定

// ホームルート
app.get('/', (req, res) => {
  res.render('index', {
    message: 'ホームファイル'
  });
});

// サーバー起動
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});

const express = require('express');
const router = express.Router();


const nowDate = new Date();

let year = nowDate.getFullYear();




router.get('/', (req, res) => {
  res.render('test', {
    pageTitle: 'expressルーティングtest',
    message:   'This is a test route!',
    bodyText:  'ルーティングのabc',
  });
});

module.exports = router;

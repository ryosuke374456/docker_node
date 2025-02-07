# ベースイメージとして公式Node.jsイメージを使用
FROM node:latest

# 作業ディレクトリを設定
WORKDIR /usr/src/app

# package.jsonとpackage-lock.jsonをコピー
COPY package*.json ./

# npmを使って依存関係をインストール
RUN npm install --only=development
RUN npm install typescript

# MySQLをインストール
RUN apt-get update && apt-get install -y mariadb-server
# MySQLの初期化用設定
RUN mkdir -p /etc/mysql/conf.d
COPY my.cnf /etc/mysql/conf.d/my.cnf
RUN chmod 644 /etc/mysql/conf.d/my.cnf

RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld
RUN chown -R mysql:mysql /var/lib/mysql

# MySQLを起動するためのディレクトリの権限を修正
RUN chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

# アプリケーションのソースコードをコピー
COPY . .

# アプリケーションのポートを開放
EXPOSE 3000

# MySQLのポートを開放
EXPOSE 3306

# MySQLとアプリケーションを起動
CMD service mysql start && node app.js

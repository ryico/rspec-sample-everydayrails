# rubyイメージを取得
FROM ruby:2.5.3

# 必要パッケージのinstall
RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs

# 作業ディレクトリの作成と設定
RUN mkdir /app_name
ENV APP_ROOT /app_name
WORKDIR $APP_ROOT

ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

RUN bundle install
ADD . $APP_ROOT

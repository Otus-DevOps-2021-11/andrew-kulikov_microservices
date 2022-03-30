FROM ruby:2.2-alpine

ENV APP_HOME /app
WORKDIR $APP_HOME
COPY Gemfile* $APP_HOME/

# hadolint ignore=DL3018
RUN apk update \
    && apk add --no-cache ruby-dev build-base \
    && gem install bundler -v 1.17.2 --no-document \
    && bundle install \
    && apk del ruby-dev build-base

COPY . $APP_HOME

CMD ["puma"]

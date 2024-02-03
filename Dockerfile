FROM ruby:3.1.4-alpine3.19

RUN apk update \
  && apk upgrade \
  && apk add --no-cache gcompat \
  && apk add --virtual \
  postgresql-client \
  build-base \
  libxml2-dev \
  libxslt-dev \
  nodejs \
  yarn \
  libffi-dev \
  readline \
  build-base \
  postgresql-dev \
  libc-dev \
  linux-headers \
  readline-dev \
  file \
  imagemagick \
  git \
  tzdata \
  && rm -rf /var/cache/apk/*

WORKDIR   /app

COPY . /app/

ENV BUNDLE_PATH /gems

RUN yarn install
RUN bundle install

ENTRYPOINT ["bin/rails"]

CMD ["s", "-b", "0.0.0.0"]

EXPOSE 3000
FROM ruby:3.3.0-alpine3.19

RUN apk add --update --virtual \
&& apk add --no-cache gcompat \
runtime-deps \
postgresql-clinet \
build-base \
libxml2-dev \
libxsl2-dev \
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
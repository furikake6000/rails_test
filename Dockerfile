# ref: https://qiita.com/kodai_0122/items/795438d738386c2c1966

FROM ruby:2.6.5
RUN apt-get update -qq && \
    apt-get install -y \
        wget \
        curl \
        git \
        build-essential \
        nodejs \
        npm \
        postgresql-client \
        libpq-dev \
        libsodium-dev \
        imagemagick \
        cron \
        vim
WORKDIR /rails_test

# entrykit
ENV ENTRYKIT_VERSION 0.4.0
RUN wget https://github.com/progrium/entrykit/releases/download/v${ENTRYKIT_VERSION}/entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz && \
    tar -xvzf entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz && \
    rm entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz && \
    mv entrykit /bin/entrykit && \
    chmod +x /bin/entrykit && \
    entrykit --symlink

ENTRYPOINT [ \
    "prehook", "bundle install -j4 --clean --path vendor/bundle", "--", \
    "prehook", "bundle exec rails assets:precompile", "--", \
    "prehook", "rm -f tmp/pids/server.pid", "--"]

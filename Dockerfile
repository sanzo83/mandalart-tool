# syntax=docker/dockerfile:1
ARG RUBY_VERSION=3.2.11

FROM ruby:${RUBY_VERSION}-slim AS base
WORKDIR /rails

ENV RAILS_ENV=production \
    RAILS_LOG_TO_STDOUT=true \
    RAILS_SERVE_STATIC_FILES=true \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_WITHOUT=development:test

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y libsqlite3-0 && \
    rm -rf /var/lib/apt/lists/*

FROM base AS build
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libsqlite3-dev pkg-config && \
    rm -rf /var/lib/apt/lists/*
COPY Gemfile Gemfile.lock ./
RUN bundle install && rm -rf /usr/local/bundle/cache /root/.bundle/cache
COPY . .
RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile && \
    bundle exec bootsnap precompile --gemfile app/ lib/

FROM base AS development
ENV RAILS_ENV=development BUNDLE_DEPLOYMENT=0 BUNDLE_WITHOUT=""
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libsqlite3-dev pkg-config && \
    rm -rf /var/lib/apt/lists/*
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .

FROM base AS production
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails
RUN groupadd --system --gid 1000 rails && \
    useradd --system --uid 1000 --gid 1000 --create-home rails && \
    chown -R rails:rails db log storage tmp
USER rails
EXPOSE 8080
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]

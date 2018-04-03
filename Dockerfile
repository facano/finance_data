FROM ruby:2.3.1

# Install essential Linux packages
RUN apt-get update -qq && apt-get install -y build-essential \
  libpq-dev \
  nodejs \
  mysql-client \
  git

# Set local timezone
RUN cp /usr/share/zoneinfo/America/Santiago /etc/localtime && \
    echo "America/Santiago" > /etc/timezone


# Point Bundler at /gems. This will cause Bundler to re-use gems that have already been installed on the gems volume
ENV BUNDLE_PATH /gems
ENV BUNDLE_HOME /gems

# Increase how many threads Bundler uses when installing. Optional!
ENV BUNDLE_JOBS 4

# How many times Bundler will retry a gem download. Optional!
ENV BUNDLE_RETRY 3

# Where Rubygems will look for gems, similar to BUNDLE_ equivalents.
ENV GEM_HOME /gems
ENV GEM_PATH /gems

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install

COPY . .

CMD puma -C config/puma.rb

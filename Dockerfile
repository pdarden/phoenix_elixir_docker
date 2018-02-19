FROM elixir:1.6.1

MAINTAINER Parinda Darden <parinda.darden@gmail.com>

# update and install software
RUN apt-get update && apt-get upgrade -y && apt-get install -y curl wget vim git make sudo && apt-get clean
ENV EDITOR vim

ENV PHOENIX_VERSION 1.3.0

# install the Phoenix Mix archive
RUN mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phx_new-$PHOENIX_VERSION.ez
RUN mix local.hex --force \
    && mix local.rebar --force

# install Node.js (>= 8.0.0) and NPM in order to satisfy brunch.io dependencies
RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - \
    && sudo apt-get install -y nodejs inotify-tools

# install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list \
    && sudo apt-get update && sudo apt-get install yarn

ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

COPY . $APP_HOME

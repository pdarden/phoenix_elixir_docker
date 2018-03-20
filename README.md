# Phoenix Elixir Docker
Develop Phoenix Elixir with Docker!

* Elixir 1.6.1
* Phoenix 1.3.0
* Yarn

# Prerequisite
Install Docker for your machine [here](https://www.docker.com/community-edition#/download).

# Steps
1. [Setup Docker](#setup-docker)
1. [Connecting the Database](#connecting-the-database)
1. [Up and Running](#up-and-running)

## Setup Docker
* [Building a new project](#building-a-new-project)
* [Existing Project](#existing-project)
#### Building a new project

Clone this repo:
```
$ git clone git@github.com:pdarden/phoenix_elixir_docker.git
```

Create your project directory:
* Remove git remote
```
$ git remote remove origin
```
* Change directory name
```
$ cd .. && mv phoenix_elixir_docker <<new_project_name>> && cd <<new_project_name>>
```

Build new project:
```
$ docker-compose run web mix phx.new .
```

Build image again:
```
$ docker-compose build
```

#### Existing Project
Just add `Dockerfile`, `docker-compose.yml`, and `run.sh` to your project and run

```
$ docker-compose build
```

## Connecting the Database
In `config/dev.exs` configure your database with this content (rename the database, see `<<my_app_name>>`):

```
# Configure your database
config :<<my_app_name>>, <<MyAppName>>.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("POSTGRES_USER"),
  password: System.get_env("POSTGRES_PASSWORD"),
  database: "<<my_app_name>>_dev",
  hostname: System.get_env("POSTGRES_HOST"),
  pool_size: 10
```
In `config/config.exs`:
```
# change this
# url: [host: "localhost"],
# to
url: [host: System.get_env("POSTGRES_HOST")],
```


## Up and Running
```
$ mix deps.get
$ cd assets && yarn install && node node_modules/brunch/bin/brunch build
```
* Setup the database for your project:
```
$ mix ecto.create
```
* Spinning up the rails server:
```
$ docker-compose up
```
**Note:** This will excute the commands in `run.sh`
* Visit http://localhost:4000  :rocket:

# Useful commands
* `docker-compose run web <<commands>>`, runs commands in web service container
E.g.,
```
$ docker-compose run web ecto.migrate
```
* `docker-compose run web bash`, runs bash to interact with the directory inside the web service container
* `docker-compose build`, build image when `Dockerfile` changes or when you want
  to update or add gems.
* `docker-compose up`, starts up containers.
* `docker-compose up -d`, starts up containers **in the background**.
* `docker-compose down`, stops containers.
* `docker-compose ps`, view container processes, container name, container id.
* `docker attach <<contianer_name>>`, attach container to interact with
  `IEx.pry`. `Control + p` `Control + q `, detach from container.

# Guides
* [https://docs.docker.com/compose](https://docs.docker.com/compose)
* [https://hexdocs.pm/phoenix](https://hexdocs.pm/phoenix)

# URL Shortener

This small project offers the minimal functionality of a URL shortener, as a Rails 6 project with
a PostgreSQL database and bootstrap for styling only.

It lacks prevention measures against abuse and spamming, does not scale well, is not adapt the
language used, has a hard limit on number of short links because of the size of the short link code,
and probably many other issues. It was kept this short for brevity and lack of other dependencies
like a Redis instance.

## Installation

I recommend installing rbenv or rvm, bundler, a modern version of ruby, like 2.5, and PostgreSQL.

Make sure the PostgreSQL server is running on the default port 5432 and the default user has access.

Then, execute

```sh
bundle
bundle exec rake db:create
bundle exec rake db:migrate
```

## Use

Launch the server using

```sh
bundle exec rails s
```

And visit the website at [http://localhost:3000](http://localhost:3000)

# Tests

To run the unit tests run

```sh
bundle exec rake test
```

And code linter

```sh
bundle exec rubocop
```

# RSpec Learning Project README

## System dependencies

- Docker

### Ruby version

```
2.5.3
```

### Rails version

```
5.2.4.3
```

## Set Up

### Build and Launch Containers

```sh
$ docker-compose up -d
```

### Database initialization

```sh
$ docker-compose run --rm web bin/setup
```

### How to run the test suite

```sh
$ docker-compose run --rm web bin/rspec
```

## 参照

[Everyday Rails - RSpecによるRailsテスト入門](https://leanpub.com/everydayrailsrspec-jp/read)

[Rails5+Mysql on Docker: Qiita](https://qiita.com/azul915/items/5b7063cbc80192343fc0)

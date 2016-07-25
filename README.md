## Bank

[![CircleCI](https://circleci.com/gh/rafaeljesus/bank.svg?style=svg)](https://circleci.com/gh/rafaeljesus/bank)
[![Code Climate](https://codeclimate.com/github/rafaeljesus/bank/badges/gpa.svg)](https://codeclimate.com/github/rafaeljesus/bank)
[![Issue Count](https://codeclimate.com/github/rafaeljesus/bank/badges/issue_count.svg)](https://codeclimate.com/github/rafaeljesus/bank)

* A minimal docker alpine container
* Automatically pushes it to dockerhub if tests pass

## Installation
```bash
git clone https://github.com/rafaeljesus/bank.git
cd bank
bundle
```

## Running server
To start the serve execute:
```bash
JWT_SECRET=foo bundle exec rackup
```

## API
### create user
```bash
curl -H 'Content-Type: application/json' -d '{"email": "test@mail.com", "password": "123456"}' -X POST 'http://localhost:9292/v1/users'
```

### generate token
```bash
curl -H 'Content-Type: application/json' -d '{"email": "test@mail.com", "password": "123456"}' -X POST 'http://localhost:9292/v1/token'
```

### open a new account
```bash
curl -H 'Content-Type: application/json' -d '{"email": "test@mail.com", "password": "123456"}' -H "Authorization: Bearer <ACCESS_TOKEN>" -X POST 'http://localhost:9292/v1/accounts'
```

### deposit into account
```bash
curl -H 'Content-Type: application/json' -d '{"amount": 9.99}' -H "Authorization: Bearer <ACCESS_TOKEN>" -X POST 'http://localhost:9292/v1/accounts/123456/deposit'
```

### withdraw from account
```bash
curl -H 'Content-Type: application/json' -d '{"amount": 9.99}' -H "Authorization: Bearer <ACCESS_TOKEN>" -X POST 'http://localhost:9292/v1/accounts/123456/withdraw'
```

### transfer from one account to another account
```bash
curl -H 'Content-Type: application/json' -d '{"from": "123456", "to": "654321", "amount": 9.99}' -H "Authorization: Bearer <ACCESS_TOKEN>" -X POST 'http://localhost:9292/v1/accounts/123456/transfer'
```

## Docker
This repository has automated image builds on hub.docker.com after successfully building and testing. See the `deployment` section of [circle.yml](circle.yml) for details on how this is done. Note that three environment variables need to be set on CircleCI for the deployment to work:

  * DOCKER_EMAIL - The email address associated with the user with push access to the Docker Hub repository
  * DOCKER_USER - Docker Hub username
  * DOCKER_PASS - Docker Hub password (these are all stored encrypted on CircleCI, and you can create a deployment user with limited permission on Docker Hub if you like)

run:
```
$ docker-machine start default
$ eval $(docker-machine env default)
$ docker-compose up
```

## Contributing
- Fork it
- Create your feature branch (`git checkout -b my-new-feature`)
- Commit your changes (`git commit -am 'Add some feature'`)
- Push to the branch (`git push origin my-new-feature`)
- Create new Pull Request

### Maintaners

* [Rafael Jesus](https://github.com/rafaeljesus)

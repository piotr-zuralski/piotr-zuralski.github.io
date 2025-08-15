SHELL := /bin/bash
.DEFAULT_GOAL := lint-build-test
.PHONY: lint-build-test
default: lint-build-test

h help:
	@egrep '^\S|^$$' Makefile

clean:
	rm -rf _site/ src/_site/ output/ .tmp/

build-dependencies: clean
# sudo apt-get install ruby ruby-all-dev gem yarn wget -yq >/dev/null 2>&1
	brew bundle
	rbenv init || true
	rbenv install $$(cat .ruby-version) --skip-existing
	rbenv local $$(cat .ruby-version)
	rbenv rehash
	gem install bundler >/dev/null
	bundle config --global github.https true
	bundle config --local path vendor/bundle
	bundle install >/dev/null
	gem update >/dev/null
	pre-commit install && pre-commit autoupdate
	yarn install || true
	echo "Build dependencies installed\n"
	wget "https://gist.github.com/piotr-zuralski/757f25c60197178bb5f9688bf0603276/raw/5e59c115b5f5db0d39ceac9b0d6755eba1db66ed/resume.json" -O _includes/resume.json
	yarn run resume export --theme stackoverflow --resume _includes/resume.json "_includes/resume.html"
	gsed -i 's|<!doctype html>||g' "_includes/resume.html"
	gsed -i 's|<html>||g' "_includes/resume.html"
	gsed -i 's|<head>||g' "_includes/resume.html"
	gsed -i 's|<meta charset="utf-8">||g' "_includes/resume.html"
	gsed -i 's|<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />||g' "_includes/resume.html"
	gsed -i 's|<title>Piotr Żuralski</title>||g' "_includes/resume.html"
	gsed -i 's|</head>||g' "_includes/resume.html"
	gsed -i 's|<body>||g' "_includes/resume.html"
	gsed -i 's|</body>||g' "_includes/resume.html"
	gsed -i 's|</html>||g' "_includes/resume.html"
	gsed -i '/\S/!d' "_includes/resume.html"

lint: build-dependencies
# act -P ubuntu-latest=nektos/act-environments-ubuntu:18.04 -j lint
	bundle exec jekyll doctor
	pre-commit run --all-files || true
	act --container-architecture linux/amd64 -P ubuntu-latest=shivammathur/node:latest -j build

build: lint
# act -P ubuntu-latest=nektos/act-environments-ubuntu:18.04 -s GITHUB_TOKEN="foobar"
	bundle exec jekyll serve --incremental --verbose
	bundle exec jekyll serve --incremental --verbose --trace

test build-prod: lint
	JEKYLL_ENV=production bundle exec jekyll build --incremental --verbose

lint-build-test: lint build test

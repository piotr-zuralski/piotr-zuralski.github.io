SHELL := /bin/bash
.PHONY: lint-build-test
default: lint-build-test

h help:
	@egrep '^\S|^$$' Makefile

clean:
	rm -rf _site/ src/_site/ output/

lint: build-dependencies
	bundle exec jekyll doctor
# act -P ubuntu-latest=nektos/act-environments-ubuntu:18.04 -j lint
	pipenv shell || true
#	pre-commit run --all-files || true

build-dependencies: clean
# sudo apt-get install ruby ruby-all-dev gem yarn wget -yq >/dev/null 2>&1
# sudo gem install bundler >/dev/null
# sudo gem update >/dev/null
	pipenv shell || true
	pipenv install
	pre-commit install
	yarn install
	wget "https://gist.github.com/piotr-zuralski/757f25c60197178bb5f9688bf0603276/raw/5e59c115b5f5db0d39ceac9b0d6755eba1db66ed/resume.json" -O _includes/resume.json
	yarn run resume export --theme stackoverflow --resume _includes/resume.json _includes/resume.html
	sed -i 's|<!doctype html>||g' _includes/resume.html
	sed -i 's|<html>||g' _includes/resume.html
	sed -i 's|<head>||g' _includes/resume.html
	sed -i 's|<meta charset="utf-8">||g' _includes/resume.html
	sed -i 's|<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />||g' _includes/resume.html
	sed -i 's|<title>Piotr Żuralski</title>||g' _includes/resume.html
	sed -i 's|</head>||g' _includes/resume.html
	sed -i 's|<body>||g' _includes/resume.html
	sed -i 's|</body>||g' _includes/resume.html
	sed -i 's|</html>||g' _includes/resume.html
	sed -i '/\S/!d' _includes/resume.html
	bundle config set --local path vendor/bundle
	bundle install >/dev/null

build: lint
# act -P ubuntu-latest=nektos/act-environments-ubuntu:18.04 -s GITHUB_TOKEN="foobar"
	bundle exec jekyll serve --incremental --verbose
	bundle exec jekyll serve --incremental --verbose --trace

test build-prod: lint
	JEKYLL_ENV=production bundle exec jekyll build --incremental --verbose

lint-build-test: lint build test

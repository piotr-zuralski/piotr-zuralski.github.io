# .PHONY: install install-and-serve
default: install-and-serve

h help:
	@egrep '^\S|^$$' Makefile

install:
	sudo apt install ruby ruby-dev gem -yq >/dev/null 2>&1
	sudo gem install bundler >/dev/null 2>&1
	bundle config
	# bundle config set --local path vendor/bundle
	bundle install >/dev/null 2>&1
	# bundle exec jekyll help
	bundle exec jekyll serve

install-and-serve: install serve

s serve:
	JEKYLL_ENV=development bundle exec jekyll serve

build:
	JEKYLL_ENV=production bundle exec jekyll build --trace

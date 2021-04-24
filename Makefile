SHELL := /bin/bash
# .PHONY: install install-and-serve
default: install-and-serve

h help:
	@egrep '^\S|^$$' Makefile

clean:
	rm -rf _site/ src/_site/ output/

install: clean
	sudo apt-get install ruby ruby-all-dev gem -yq >/dev/null 
	sudo gem install bundler >/dev/null
	sudo gem update >/dev/null
	bundle config
	# bundle config set --local path vendor/bundle
	bundle install >/dev/null 
	# bundle exec jekyll help
	# bundle exec jekyll serve --incremental --verbose --trace

install-and-serve: install serve

test:
	# act -P ubuntu-latest=nektos/act-environments-ubuntu:18.04
	# act -j lint -P ubuntu-latest=shivammathur/node:latest
	# act -P ubuntu-latest=shivammathur/node:latest
	# ACTIONS_RUNNER_DEBUG=true
	act -P ubuntu-latest=nektos/act-environments-ubuntu:18.04 

test-local:
# 	check-links ./_site/ --max-threads 1
# 	build-dev
	bundle exec htmlproofer --log-level :debug ./_site/ --check-favicon --check-html --check-opengraph --check-sri \
		--empty-alt-ignore false --enforce-https --report-invalid-tags --report-missing-names --report-missing-doctype \ 
	 	--report-mismatched-tags &> ./.tmp/log.log 2&>1

s serve:
	# JEKYLL_ENV=development
#	python -mwebbrowser "http://localhost:4000/"
	xdg-open "http://localhost:4000/" || gnome-open "http://localhost:4000/"
	bundle exec jekyll serve --incremental --verbose --trace
	

build: build-prod

build-dev: install
	# JEKYLL_ENV=development 
	bundle exec jekyll build --incremental --verbose --trace

build-prod: install
	# JEKYLL_ENV=production 
	bundle exec jekyll build --incremental --verbose --trace

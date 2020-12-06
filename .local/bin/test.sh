#!/usr/bin/env bash

set -e

# if [[ ! "$(command -v bundle &> /dev/null)" ]]; then
    sudo apt install ruby ruby-dev gem -yq &> /dev/null
    sudo gem install bundler &> /dev/null
# fi

bundle install &> /dev/null
# bundle exec jekyll help
bundle exec jekyll serve

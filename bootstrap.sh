#!/usr/bin/env bash

# Create projects directory
mkdir ~/projects

# Create .extra file
touch ~/.extra
touch ~/.gituser

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function copyDotfiles() {
	rsync --exclude ".git/" \
        --exclude ".macos" \
		--exclude ".DS_Store" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "LICENSE" \
		-avh --no-perms . ~;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	copyDotfiles;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		copyDotfiles;
	fi;
fi;
unset copyDotfiles;

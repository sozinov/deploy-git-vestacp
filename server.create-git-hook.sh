#!/bin/bash
# modified on base
# source: https://gist.github.com/francoisromain/58cabf43c2977e48ef0804848dee46c3
# and another script to delete the directories created by this script
# project-delete.sh: https://gist.github.com/francoisromain/e28069c18ebe8f3244f8e4bf2af6b2cb

# Call this file with `bash ./project-create.sh project-name`
# - project-name is mandatory

# This will creates 4 directories and a git `post-receive` hook.
# The 4 directories are:
# - $GIT: a git repo
# - $TMP: a temporary directory for deployment
# - $WWW: a directory for the actual production files
# - $ENV: a directory for the env variables

# When you push your code to the git repo,
# the `post-receive` hook will deploy the code
# in the $TMP directory, then copy it to $WWW.


DIR_TMP="/home/admin/web/" 
DIR_WWW="/home/admin/web/"
DIR_GIT="/home/admin/git/"
DIR_ENV="/home/admin/web/"

if [ $# -eq 0 ]; then
	echo 'No project name provided (mandatory)'
	exit 1
else
	echo "- Project name:" "$1"
fi

GIT=$DIR_GIT$1.git
TMP=$DIR_TMP$1'/tmp'
WWW=$DIR_WWW$1'/public_html'
ENV=$DIR_ENV$1'/public_html'

echo "- git:" "$GIT"
echo "- tmp:" "$TMP"
echo "- www:" "$WWW"
echo "- env:" "$ENV"

export GIT
export TMP
export WWW
export ENV

# Create a directory for the env repository
 mkdir -p "$ENV"
cd "$ENV" || exit
 touch .env

# Create a directory for the git repository
 mkdir -p "$GIT"
cd "$GIT" || exit

# Init the repo as an empty git repository
 git init --bare

cd hooks || exit

touch post-receive

# create a post-receive file
 tee post-receive <<EOF
#!/bin/sh
# The production directory
TARGET="${WWW}"
# The Git repo
REPO="${GIT}"
# Deploy the content to the TARGET directory
git --work-tree=\$TARGET --git-dir=\$REPO checkout -f
EOF

# make it executable
 chmod +x post-receive

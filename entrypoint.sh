#! /usr/bin/env bash

set -e
set -x

BASE=$1
BRANCH=$2
TOKEN=$3

if [[ -z "${BASE}" ]]; then
  echo "Missing \$BASE"
  exit 1
fi

if [[ -z "${BRANCH}" ]]; then
  echo "Missing \$BRANCH"
  exit 1
fi

if ! git check-ref-format --allow-onelevel --normalize "${BASE}"; then
  echo "BASE is invalid: ${BASE}"
else
  BASE=$(git check-ref-format --allow-onelevel --normalize "${BASE}")
fi

echo "BASE=${BASE}"
echo "BRANCH=${BRANCH}"

mkdir _tmp && cd _tmp
git init

git config user.name "${GITHUB_ACTOR}"
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"

git remote add origin "https://${GITHUB_ACTOR}:${TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
git remote set-url origin "https://${GITHUB_ACTOR}:${TOKEN}@github.com/${GITHUB_REPOSITORY}.git"

git remote -v
git remote update

# checkout branches to make sure they exists
git checkout "${BASE}" --
git checkout "${BRANCH}" --

git rebase --autosquash --autostash --onto "${BASE}" "${BASE}" "${BRANCH}"
git push --force origin "${BRANCH}"

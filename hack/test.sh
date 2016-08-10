#!/bin/bash
set -e

if [ -z "$VALIDATE_UPSTREAM" ]; then
	# this is kind of an expensive check, so let's not do this twice if we
	# are running more than one validate bundlescript

	VALIDATE_REPO='https://github.com/maintainerati/wontfix-cabal-site.git'
	VALIDATE_BRANCH='master'

	if [ "$TRAVIS" = 'true' -a "$TRAVIS_PULL_REQUEST" != 'false' ]; then
		VALIDATE_REPO="https://github.com/${TRAVIS_REPO_SLUG}.git"
		VALIDATE_BRANCH="${TRAVIS_BRANCH}"
	fi

	VALIDATE_HEAD="$(git rev-parse --verify HEAD)"

	git fetch -q "$VALIDATE_REPO" "refs/heads/$VALIDATE_BRANCH"
	VALIDATE_UPSTREAM="$(git rev-parse --verify FETCH_HEAD)"

	VALIDATE_COMMIT_LOG="$VALIDATE_UPSTREAM..$VALIDATE_HEAD"
	VALIDATE_COMMIT_DIFF="$VALIDATE_UPSTREAM...$VALIDATE_HEAD"

	validate_diff() {
		if [ "$VALIDATE_UPSTREAM" != "$VALIDATE_HEAD" ]; then
			git diff "$VALIDATE_COMMIT_DIFF" "$@"
		fi
	}
	validate_log() {
		if [ "$VALIDATE_UPSTREAM" != "$VALIDATE_HEAD" ]; then
			git log "$VALIDATE_COMMIT_LOG" "$@"
		fi
	}
fi

IFS=$'\n'
files=( $(validate_diff --diff-filter=ACMR --name-only -- 'static/css/' 'static/less/' || true) )
unset IFS

if [ ${#files[@]} -gt 0 ]; then
	# We run `make less` to and see if we have a diff afterwards
	make less >/dev/null
	# Let see if the working directory is clean
	diffs="$(git status --porcelain -- static 2>/dev/null)"
	if [ "$diffs" ]; then
		{
			echo 'The result of `make less` differs'
			echo
			echo "$diffs"
			echo
			echo 'Please re-run `make less` and be sure you do NOT edit any css files directly.'
			echo
		} >&2
		false
	else
		echo 'Congratulations! All LESS changes have been done the right way.'
	fi
fi

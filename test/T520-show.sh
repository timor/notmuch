#!/usr/bin/env bash
test_description='"notmuch show"'

. $(dirname "$0")/test-lib.sh || exit 1

add_email_corpus

test_begin_subtest "exit code for show invalid query"
notmuch show foo..
exit_code=$?
test_expect_equal 1 $exit_code

backup_database
test_begin_subtest "show with alternate config"
cp notmuch-config alt-config
notmuch --config=alt-config config set search.exclude_tags foobar17
notmuch tag -- +foobar17 '*'
output=$(notmuch --config=alt-config show '*')
test_expect_equal "$output" ""
restore_database

test_done

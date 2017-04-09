#!/bin/sh

docker run --rm\
 -v collabotoolsdocker_redmine_filevolume:/target/redmine_file/ \
 -v collabotoolsdocker_redmine_dbvolume:/target/redmine_db/ \
 -v collabotoolsdocker_rocketchat_dbvolume:/target/rocketchat_db/ \
 -v collabotoolsdocker_gitbucket_repovolume:/target/gitbucket_repo/ \
 -v collabotoolsdocker_gitbucket_dbvolume:/target/gitbucket_db/ \
 -v /$(pwd):/backup/ \
 -i \
 ubuntu bash -c "cd /target && tar xvfz /backup/backup.tar.gz --strip 1"


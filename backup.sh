#!/bin/sh

docker-compose stop

docker run --rm \
 -v collabotoolsdocker_redmine_filevolume:/target/redmine_file/ \
 -v collabotoolsdocker_redmine_pluginvolume:/target/redmine_plugin/ \
 -v collabotoolsdocker_redmine_dbvolume:/target/redmine_db/ \
 -v collabotoolsdocker_rocketchat_dbvolume:/target/rocketchat_db/ \
 -v collabotoolsdocker_gitbucket_repovolume:/target/gitbucket_repo/ \
 -v collabotoolsdocker_gitbucket_dbvolume:/target/gitbucket_db/ \
 -v /$(pwd):/backup/ \
 -i \
 ubuntu tar cvfz //backup/backup.tar.gz //target 1> backup.log 2> backup_error.log

docker-compose start

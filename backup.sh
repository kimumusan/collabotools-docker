#!/bin/sh

echo "Backup is started."
date +"Backup is started in %Y/%m/%d %p at %I:%M:%S" 1> logs/backup.log 2> logs/backup_error.log

echo "Stopping the containers..."
docker-compose stop 1>> logs/backup.log 2>> logs/backup_error.log

echo "Archiving data volumes..."
docker run --rm \
 -v collabotoolsdocker_redmine_filevolume:/target/redmine_file/ \
 -v collabotoolsdocker_redmine_pluginvolume:/target/redmine_plugin/ \
 -v collabotoolsdocker_redmine_dbvolume:/target/redmine_db/ \
 -v collabotoolsdocker_rocketchat_dbvolume:/target/rocketchat_db/ \
 -v collabotoolsdocker_gitbucket_repovolume:/target/gitbucket_repo/ \
 -v collabotoolsdocker_gitbucket_dbvolume:/target/gitbucket_db/ \
 -v /$(pwd):/backup/ \
 -i \
 ubuntu tar cvfz //backup/backup.tar.gz //target 1>> logs/backup.log 2>> logs/backup_error.log

echo "Starting data the containers..."
docker-compose start 1>> logs/backup.log 2>> logs/backup_error.log

date +"Backup is finished in %Y/%m/%d %p at %I:%M:%S" 1>> logs/backup.log 2>> logs/backup_error.log

echo "Backup is finished!"

sleep 1s

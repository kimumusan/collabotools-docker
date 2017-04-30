#!/bin/sh

echo "To restore, the containers will be recreated. Your changes to the containers can be disappeared. Do you want to continue? [Y/n]"
read answer

case $answer in 
    "Y" | "y" | "yes" | "Yes" | "YES" )
	;;
    * )
        echo "Restore is canceled."
	exit
	;;
esac

echo "Restore is started."
date +"restore started in %Y/%m/%d %p  at %I:%M:%S" 1> logs/restore.log 2> logs/restore_error.log

echo "Stopping and removing containers..."
docker-compose down 1>> logs/restore.log 2>> logs/restore_error.log

echo "Removing unused volumes..."
docker volume prune --force 1>> logs/restore.log 2>> logs/restore_error.log

echo "Creating new volumes and restoring data..."
docker run --rm\
 -v collabotoolsdocker_redmine_filevolume:/target/redmine_file/ \
 -v collabotoolsdocker_redmine_pluginvolume:/target/redmine_plugin/ \
 -v collabotoolsdocker_redmine_dbvolume:/target/redmine_db/ \
 -v collabotoolsdocker_rocketchat_dbvolume:/target/rocketchat_db/ \
 -v collabotoolsdocker_gitbucket_repovolume:/target/gitbucket_repo/ \
 -v collabotoolsdocker_gitbucket_dbvolume:/target/gitbucket_db/ \
 -v /$(pwd):/backup/ \
 -i \
 ubuntu bash -c "cd /target && tar xvfz /backup/backup.tar.gz --strip 1" 1>> logs/restore.log 2>> logs/restore_error.log

echo "Creating and starting containers"
docker-compose up -d 1>> logs/restore.log 2>> logs/restore_error.log

date +"Restore is finished in %Y/%m/%d %p at %I:%M:%S"  1>> logs/restore.log 2>> logs/restore_error.log

echo "Restore is finished!"

sleep 1s

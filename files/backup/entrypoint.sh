#!/bin/sh

BACKUP_FILE="rancher-backup-$(date +"%d-%m-%Y").tar.gz"

tar czf $BACKUP_FILE /opt/rancher/data
mc cp $BACKUP_FILE backup/${minio_bucket}/

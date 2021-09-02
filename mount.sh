#!/usr/bin/bash


mountpoint /backup-snap

retVal=$?
if [ $retVal -ne 0 ]; then
            echo "Mounting file system."
            mount /dev/mapper/mpatha /backup-snap
    else
            echo "It appears that the file system is already mounted. Please check."
fi

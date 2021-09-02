#!/usr/bin/bash


mountpoint /backup-snap

retVal=$?
if [ $retVal -eq 0 ]; then
            echo "Unmounting file system."
            umount /backup-snap
    else
            echo "The file system doesn't look like it was mounted. Please check."
fi

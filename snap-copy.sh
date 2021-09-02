         b                                                                                                                                                               n  |#!/bin/bash
# This is only to be used as a prep for the Pure Test Drive Environment
# Brian Kuebler 9/1/2021

#SRC="lpar1"
#TGT="lpar2"


### Make sure that we're running as root.

checkId () {
           myid=$(id -u)

              if (( $myid != 0 )); then
                      echo "This script must be run as root."
                      exit
              else
                 echo "Running as priveleged user..."
                 fi
                                   }

checkId

### Let's unmount the filesystem for consistency. Since we can in this instance, we'll do it on both instances.

unmountFs () {
              echo "Unmounting file system..."
              umount /source-data

              ssh -T lpar2 << 'EOF'
              ~/Scripts/unmount-backup.sh
EOF

}

### Create the snapshop on Flasharray. This will overwrite all existing data on the target.

createSnap () {
        echo "Now copying contents of lpar1-vol1 to lpar2-target..."

        sleep 3

        ssh -T snap-admin@pure02 << 'EOF'
        purevol copy --overwrite lpar1-vol1 lpar2-target

EOF

sleep 3

}

### Mount the filesystem for backup.

mountFs () {
          echo "Mounting file system..."
          mount /dev/mapper/mpatha /source-data
          ssh -T lpar2 << 'EOF'
          ~/Scripts/mount-backup.sh
EOF
}

### Run our functions

unmountFs
sleep 3
createSnap
sleep 3
mountFs

echo "Snapshot complete"

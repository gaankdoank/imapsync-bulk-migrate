#!/bin/bash
# Simple script to sync imap accounts with imapsync
# Author: Carlos Egüez <speedlight>
# Version: 1.0

# The USERLIST file use the user1;pass1;user2;pass2 format, change the IFS=";" variable if needed.
# The USERLIST file is suposed to be in the same location of this script.


imapsyncpath=
origin=117.102.107.35
destination=mail.finlogistics.co.id
options="--usecache --noerrorsdump --nofoldersizes --no-modules_version --addheader --subscribeall"

while IFS=";" read u1 p1 u2 p2; do
    { echo "$u1" |egrep "^#" ; } > /dev/null && continue # skip comment lines in USERLIST
    echo "============== Migrating mail from user $u1 to $u2 =============="
    bash $imapsyncpath/imapsync --host1 $origin --host2 $destination --user1 $u1 --password1 $p1 --user2 $u2 --password2 $p2 $options
    echo
    echo "============== Ended migration for user $u1 in $u2 =============="
done < USERLIST
echo "Migration Complete."
exit 0

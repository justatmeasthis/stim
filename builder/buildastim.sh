#!/usr/bin/env bash

if [ "$2" = "-nosuppress" ]; then
	nosuppress="nosuppress"
else
	nosuppress="false"
fi

SCRIPT_DIR=$(dirname "$0")
VERSION=1.0.5
HOST_ARCH=$(uname -m)

if [ $HOST_ARCH == "x86_64" ]; then
	CGPT="$SCRIPT_DIR/bins/cgpt.x86-64"
	SFDISK="$SCRIPT_DIR/bins/sfdisk.x86-64"
else
	echo "Building on an ARM system is not supported currently"
	exit
	# CGPT="$SCRIPT_DIR/bins/cgpt.aarch64"
	# SFDISK="$SCRIPT_DIR/bins/sfdisk.aarch64"
fi

source $SCRIPT_DIR/functions4buildastim.sh

echo "build a stim v$VERSION"
echo "gdisk, e2fsprogs required. must be ran as root"
[ "$EUID" -ne 0 ] && error "Please run as root"
[ "$1" == "" ] && error "No bin specified."

# Stateful is REALLY small, only about 45K with a full one.
STATE_SIZE=$((1 * 1024 * 1024)) # 1MiB
STATE_MNT="$(mktemp -d)"
ROOT_MNT="$(mktemp -d)"
LOOPDEV="$(losetup -f)"
IMG="$1"

echo "creds 2 olyb & kxtz for this builder script. im highkey too lazy to code this on my own so i took it for my self, ty!!"
if [ $nosuppress = "nosuppress" ]; then
	echo "no suppress flag activated :D" 
else
	echo 'Want more info on whats going on? add the -nosuppress flag like this "sudo bash /path/to/buildastim.sh/ /path/to/bin/ -nosuppress" when executing this script!'
fi
sleep 3
clear
# Since the bin files arent writable unless you do "make kvs" (which if you cant tell we're in stim not kvs) we have to give execute perms to these bins
log "giving write perms lol"
chmod +x $SCRIPT_DIR/bins/cgpt.x86-64
chmod +x $SCRIPT_DIR/bins/sfdisk.x86-64
# we need this before we re-create stateful
STATE_START=$("$CGPT" show "$IMG" | grep "STATE" | awk '{print $1}')
suppress srnk_part "$IMG"
losetup -P "$LOOPDEV" "$IMG"
enable_rw_mount "${LOOPDEV}p3"

log "Correcting GPT errors.."
suppress fdisk "$LOOPDEV" <<EOF
w
EOF

injcrt
ss

srnk_rt
ss

crte_steful
ss

inject_stateful
ss

uma
ss

sqsh_part "$LOOPDEV"
ss

enable_rw_mount "${LOOPDEV}p3"

clean
ss

trnk_img "$IMG"
ss

log "Done stimming bin"
trap - EXIT

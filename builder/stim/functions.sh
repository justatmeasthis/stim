#!/bin/bash
# PAYLOADSSSSSSS THE ONLY IMPORTANT THING HERE

# This is the enrollment manager, this will also be a gui but for right now, its tui D:

enrollman() {
    clear
    echo "placeholdering"
}

# Depthcharge auto update blocker, basically removes backup recovery iirc
daub() {
    while true; do
    daubascii
    echo "Creds to Crosbreaker & TN"
    echo
    if [ "$test" = "1" ]; then
    echo -e "${BRIGHT_BLUE}TEST MODE${RESET}"
    echo
    fi
        echo "1) Block updates"
        echo -e "2) Go back to ${BLUE}STIM${RESET}"
        echo "3) Reboot"
        read -n 1 -rp "Enter: " choice

        case $choice in
            1)
            if [ "$test" = "1" ]; then
    echo "You are currently in test mode, this exploit wont work."
    echo
    read -ep "Press enter to return to main menu"
    else
                
                # get_internal take from https://github.com/applefritter-inc/BadApple-icarus
                get_internal() {
                    # get_largest_cros_blockdev does not work in BadApple.
                    local ROOTDEV_LIST=$(cgpt find -t rootfs) # thanks stella
                    if [ -z "$ROOTDEV_LIST" ]; then
                        echo "Could not find root devices."
                        read -ep "Press Enter to return to menu..."
                        return 1
                    fi
                    local device_type=$(echo "$ROOTDEV_LIST" | grep -oE 'blk0|blk1|nvme|sda' | head -n 1)
                    case $device_type in
                    "blk0")
                        intdis=/dev/mmcblk0
                        intdis_prefix="p"
                        ;;
                    "blk1")
                        intdis=/dev/mmcblk1
                        intdis_prefix="p"
                        ;;
                    "nvme")
                        intdis=/dev/nvme0
                        intdis_prefix="n"
                        ;;
                    "sda")
                        intdis=/dev/sda
                        intdis_prefix=""
                        ;;
                    *)
                        echo "an unknown error occured. this should not have happened."
                        read -ep "Press Enter to return to menu..."
                        return 1
                        ;;
                    esac
                }
                
                get_internal || continue

                get_booted_kernnum() {
                    # This assumes intdis is set, which get_internal() handles later.
                    if $(expr $(cgpt show -n "$intdis" -i 2 -P) > $(cgpt show -n "$intdis" -i 4 -P)); then
                        echo -n 2
                    else
                        echo -n 4
                    fi
                }

                get_booted_rootnum() {
                    expr $(get_booted_kernnum) + 1
                }
                
                echo "Detected internal disk: $intdis"
                
                # Create necessary directories
                mkdir -p /localroot /stateful
                
                # Mount and prepare chroot environment
                mount "${intdis}${intdis_prefix}$(get_booted_rootnum)" /localroot -o ro 2>/dev/null
                if [ $? -ne 0 ]; then
                    echo "Failed to mount root partition"
                    read -ep "Press Enter to return to menu..."
                    continue
                fi
                
                mount --bind /dev /localroot/dev 2>/dev/null
                if [ $? -ne 0 ]; then
                    echo "Failed to bind mount /dev"
                    umount /localroot
                    read -ep "Press Enter to return to menu..."
                    continue
                fi
                
                # Modify partition attributes
                chroot /localroot cgpt add "$intdis" -i 2 -P 10 -T 5 -S 1 2>/dev/null
                if [ $? -ne 0 ]; then
                    echo "Failed to modify partition attributes"
                    umount /localroot/dev
                    umount /localroot
                    read -ep "Press Enter to return to menu..."
                    continue
                fi
                
                # Use fdisk to delete partitions
                echo -e "d\n4\nd\n5\nw" | chroot /localroot fdisk "$intdis" >/dev/null 2>&1
                
                # Cleanup
                umount /localroot/dev
                umount /localroot
                rmdir /localroot
                
                crossystem disable_dev_request=1 2>/dev/null
                
                # Try to mount stateful partition
                if ! mount "${intdis}${intdis_prefix}1" /stateful 2>/dev/null; then
                    mountlvm
                    if [ $? -ne 0 ]; then
                        read -ep "Press Enter to return to menu..."
                        continue
                    fi
                fi
                
                # Clear stateful partition
                rm -rf /stateful/*
                umount /stateful
                echo "Daub completed successfully!"
                echo "DO NOT POWERWASH IN CHROMEOS! YOUR DEVICE WILL BOOTLOOP!"
                echo "(bootloop is fixable by recovering)"
                read -ep "Press Enter to return to menu..."
                fi
                ;;
            2)
            clear
                echo -e "Heading to ${BLUE}STIM,${RESET} please wait..."
                sleep 3
                infmn=0
                break
                ;;
            3)
            if [ "$test" = "1" ]; then
    echo -e "Since your in test mode, this wont do anything but in the real ${BLUE}STIM${RESET} it will reboot your computer."
    echo
    read -ep "Press enter to return to main menu"
    else
                reboot -f
                echo "For some reason you didnt reboot, weird, lets try it 10 more times!"
                reboot -f
                reboot -f
                reboot -f
                reboot -f
                reboot -f
                reboot -f
                reboot -f
                reboot -f
                reboot -f
                reboot -f
                fi
                ;;
            *)
                echo "Invalid option, please try again..."
                read -ep "Press Enter to return to menu..."
                ;;
        esac
    done

    mountlvm(){
        vgchange -ay #active all volume groups
        volgroup=$(vgscan | grep "Found volume group" | awk '{print $4}' | tr -d '"')
        echo "found volume group:  $volgroup"
        mount "/dev/$volgroup/unencrypted" /stateful || {
            echo "couldnt mount p1 or lvm group.  Please recover"
            return 1
        }
    }
}

# unkeyroll payload, literally just uses the futility command to roll the keys back to what it used to be
unkeyroll() {
    trap 'clear; echo "Skipped keyrolling"; skipunkeyroll=1' INT
    echo "Hey twin, unkeyrolling is kinda a waste of time if your running this in the first place. I'll still run the script in 6 seconds. But in the meantime Press CTRL + C if you'd like to cancel."
    sleep 8
    trap '' INT
    if [ -z $skipunkeyroll ]; then
        echo -e "${RED}Flashing key${RESET} DO NOT POWER OFF OR YOU MAY RISK BRICKING (temporarily disabling ctrl + c)"
        image_file="${FLAGS_file}"
        if [ -z "${image_file}" ]; then
            image_file="$(make_temp_file)"
            flashrom_read "${image_file}">/dev/null 2>&1
        fi
        futility gbb -s --recoverykey=$fullpath/dedede_recovery_v1.vbpubk" "${image_file}>/dev/null 2>&1
        flashrom_write "${image_file}">/dev/null 2>&1
    fi
    if [ "$skipunkeyroll" = "1" ]; then
        sleep 1
        trap - INT
    else
        clear
        echo "Done!"
        sleep 1
        trap - INT
        break
    fi
}
make_temp_file() {
  mktemp
}

flashrom_read() {
  flashrom -p host -i GBB -r "$1"
}

flashrom_write() {
  flashrom -p host -i GBB -w "$1"
}

# wpdisloop payload, all it does is count how many times it tried disabling wp (really only useful for pencil method)
wpdisloop() {
    if [ -z $failedwp ]; then
    failedwp=0
    fi
    trap 'clear; echo "Cancelling loop after $failedwp tries :("; sleep 1; break;' INT
    while true; do
        clear
        echo -e "Press CTRL + C to cancel"
        if flashrom --wp-disable>/dev/null 2>&1; then
            clear
            echo -e "${GREEN}SUCCESSSSSSSSSS YAYYYYYYYYY${RESET} (It took ${BRIGHT_BLUE}$failedwp${RESET} tries, cool!)"
            sleep 3
            break
        else
            echo -e ${RED}Failed.${RESET} Attempt ${RED}$failedwp${RESET}
            let "failedwp+=1"
            sleep 0.25
        fi
    done
    trap - INT
}


# gbbflagger, a bash port of olybs gbb flaginator
draw4gbb() {
  clear
  echo "Use ↑ ↓ to move, Enter to toggle, q to write flags, b to exit"
  echo "GBB mask: $(calculate_gbb_mask)"
  echo

  for i in "${!items[@]}"; do
    [[ $i -eq $current ]] && printf "> " || printf "  "
    [[ ${selected[$i]} -eq 1 ]] && printf "[x] " || printf "[ ] "
    echo "${items[$i]}"
  done
}
gbbflagger() {
items=(
    "Shorten dev screen timeout to 2 seconds"
    "[Unsupported] BIOS loads option ROMs from arbitrary PCI devices"
    "[Unsupported] Boot a non-ChromeOS kernel"
    "Force devmode"
    "Allow booting from external disk (USB) even if dev_boot_usb=0"
    "Disable firmware rollback protection"
    "Allow Enter key to trigger dev->tonorm screen"
    "Allow booting altfw OSes even if dev_boot_altfw=0"
    "[Unsupported] Running FAFT tests. May enable workarounds"
    "Disable EC software sync"
    "Default to booting altfw OS when dev screen times out"
    "Disable auxiliary firmware (auxfw) software sync"
    "Disable shutdown on lid closed"
    "[Unsupported] Allow full fastboot capability"
    "Recovery mode always assumes manual recovery"
    "Ignore FWMP"
    "Enable USB Device Controller"
    "Always sync CSE, even if it is same as CBFS CSE"
)

# Selection state (0 = off, 1 = on)
selected=(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
if [ "$test" = "0"]; then
    image_file="${FLAGS_file}"
    if [ -z "${image_file}" ]; then
        image_file="$(make_temp_file)"
        flashrom_read "${image_file}">/dev/null 2>&1
    fi
    current_flags=$(futility gbb -g --flags "${image_file}" 2>/dev/null \
        | tail -n 1 \
        | grep -oE '0x[0-9a-fA-F]+')
else
    current_flags=$(futility gbb -g --flash --flags 2>/dev/null \
        | tail -n 1 \
        | grep -oE '0x[0-9a-fA-F]+')
fi
init_selected_from_mask "$current_flags"

current=0



trap clean RETURN


# Terminal setup
tput civis
stty -echo -icanon time 0 min 0

while true; do
  draw4gbb

    if ! read -rsn1 key; then
        clean
        return 1
    fi


  case "$key" in
    q)
      break
    ;;
    b)
        donotwrite=1
        break
    ;;
    "") # Enter
      selected[$current]=$((1 - selected[$current]))
      ;;
    $'\x1b')
      read -rsn2 key
      case "$key" in
        '[A') # Up
          ((current--))
          ;;
        '[B') # Down
          ((current++))
          ;;
      esac
      ;;
  esac

  # Wrap cursor
  (( current < 0 )) && current=$((${#items[@]} - 1))
  (( current >= ${#items[@]} )) && current=0
done

# Show results after exit
clear
echo "Selected options:"
calculate_gbb_mask
clear
flags=$(calculate_gbb_mask)
    while true; do
        if [ "$donotwrite" = "1" ] || [ "$chromeos" = "0" ] || [ "$wp" = "on" ]; then
            echo "The selected flags were, $flags, exiting now. (Not writing gbb flags)"
            flags=$current_flags
            mask=$flags
            donotwrite=0
            sleep 3
            break
        fi
        clear
        clean
        echo -e "Write flags $flags? (Y/N)"
        read -n 1 -rp "Enter: " gbbask
        if [ "$gbbask" = "Y" ] || [ "$gbbask" = "y" ]; then
            clear
            ic
            trap 'clear; echo "Cancelled writing GBB flags, no changes have been made"; cancelgbbflag=1' INT
            echo "Writing gbb flags $flags in 3 seconds, last chance!!!!!! PRESS CTRL + C TO CANCEL"
            sleep 3
            if [ -z "$cancelgbbflag" ]; then    
            clear
            trap '' INT
            echo "Writing $flags, if in mini os itll take ~30 seconds at most. If your in chrome os then you shouldnt be able to see this unless you have REALLY good eye sight. (temporily disabling ctrl + c)"
            if [ "$test" = "0" ]; then
                image_file="${FLAGS_file}"
                if [ -z "${image_file}" ]; then
                    image_file="$(make_temp_file)"
                    flashrom_read "${image_file}">/dev/null 2>&1
                fi
                futility gbb -s --flags=$flags "${image_file}">/dev/null 2>&1
                flashrom_write "${image_file}">/dev/null 2>&1
            else
                futility gbb -s --flash --flags=$flags>/dev/null 2>&1
            fi
            clear
            echo "Wrote flags $flags."
            flags=$current_flags
            mask=$flags
            trap - INT
            sleep 1
            clean
            break 2
        fi
        ic
        sleep 1
        flags=$current_flags
        mask=$flags
        trap - INT
        clean
        break 2
        elif [ "$gbbask" = "N" ] || [ "$gbbask" = "n" ]; then
            clear
            echo "Exiting script..."
            sleep 1
            break 2
        else
            clear
            echo "Invalid input, please try again."
            sleep 1
        fi
    done
}

init_selected_from_mask() {
  local mask=$1
  local i

  # Normalize hex → decimal if needed
  (( mask = mask ))

  for i in "${!selected[@]}"; do
    if (( mask & (1 << i) )); then
      selected[i]=1
    else
      selected[i]=0
    fi
  done
}

calculate_gbb_mask() {
  local mask=0

  for i in "${!selected[@]}"; do
    if (( selected[i] )); then
      (( mask |= (1 << i) ))
    fi
  done

  printf '0x%x\n' "$mask"
}

read_current_flags() {
  local flags

  flags=$(futility gbb -g --flash --flags 2>/dev/null \
    | tail -n 1 \
    | grep -oE '0x[0-9a-fA-F]+')

  echo "${flags:-0}"
}

declare -A picked



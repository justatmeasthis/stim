#!/bin/bash
# STIM RECODED MAIN PAYLOAD

# make sure the shell is fully loaded
reset

# Colors i stole from a prev project
RED='\e[31m'
RESET='\e[0m'
GREEN='\e[32m'
YELLOW='\e[33m'
PURPLE='\033[35m'
BLUE='\e[34m'
BOLD='\e[1m'
RESET='\e[0m'
BRIGHT_BLUE='\e[96m'

# --------------MINI OS DETECTOR--------------

fullpath="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
amiinchromeos=$(crossystem minios_priority | head -n 2 | tail -n 1)
if [ "$amiinchromeos" = "Usage:" ]; then
    test='0'    
else
    test="1"
    while true; do
        clear
        echo -e "${RED}Warning:${RESET} you are currently running this in the wrong place, some features will be disabled and will be marked unusable via a red text mark, continue? (Y/N)"
        read -n 1 -rp "Enter: " testwarn
        if [ "$testwarn" = "Y" ] || [ "$testwarn" = "y" ]; then
            clear
            echo "Proceeding..."
            sleep 3
            break
        elif [ "$testwarn" = "N" ] || [ "$testwarn" = "n" ]; then
            clear
            echo "Exiting script, sorry twin"
            sleep 1
            exit
        else
            clear
            echo "Invalid input, please try again."
            sleep 1
        fi
    done
fi

# --------------GET FUNCTIONS--------------

source $fullpath/functions.sh

daubascii() {
    echo -e "${YELLOW} ▄▄▄▄▄▄▄▄▄▄   ▄▄▄▄▄▄▄▄▄▄▄  ▄         ▄  ▄▄▄▄▄▄▄▄▄▄"
    echo -e "▐░░░░░░░░░░▌ ▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░░░░░░░░░░▌ "
    echo -e "▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀█░▌▐░▌       ▐░▌▐░█▀▀▀▀▀▀▀█░▌"
    echo -e "▐░▌       ▐░▌▐░▌       ▐░▌▐░▌       ▐░▌▐░▌       ▐░▌"
    echo -e "▐░▌       ▐░▌▐░█▄▄▄▄▄▄▄█░▌▐░▌       ▐░▌▐░█▄▄▄▄▄▄▄█░▌"
    echo -e "▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░░░░░░░░░░▌ "
    echo -e "▐░▌       ▐░▌▐░█▀▀▀▀▀▀▀█░▌▐░▌       ▐░▌▐░█▀▀▀▀▀▀▀█░▌"
    echo -e "▐░▌       ▐░▌▐░▌       ▐░▌▐░▌       ▐░▌▐░▌       ▐░▌"
    echo -e "▐░█▄▄▄▄▄▄▄█░▌▐░▌       ▐░▌▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄█░▌"
    echo -e "▐░░░░░░░░░░▌ ▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░▌ "
    echo -e "▀▀▀▀▀▀▀▀▀▀   ▀         ▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀  ${RESET}"
                                                        
}

stimascii() {
    echo -e "${BLUE} ░▒▓███████▓▒░▒▓████████▓▒░▒▓█▓▒░▒▓██████████████▓▒░  ${RESET}"
    echo -e "${BLUE}░▒▓█▓▒░         ░▒▓█▓▒░   ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ${RESET}"
    echo -e "${BLUE}░▒▓█▓▒░         ░▒▓█▓▒░   ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ${RESET}"
    echo -e "${BLUE} ░▒▓██████▓▒░   ░▒▓█▓▒░   ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ${RESET}"
    echo -e "${BLUE}       ░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ${RESET}"
    echo -e "${BLUE}       ░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ${RESET}"
    echo -e "${BLUE}░▒▓███████▓▒░   ░▒▓█▓▒░   ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ${RESET}"
    echo
}

shellascii() {
    echo -e "${BLUE}   SSSSSSSSSSSSSSS hhhhhhh                                lllllll lllllll "
    echo -e "${BLUE} SS:::::::::::::::Sh:::::h                                l:::::l l:::::l "
    echo -e "${BLUE}S:::::SSSSSS::::::Sh:::::h                                l:::::l l:::::l "
    echo -e "${BLUE}S:::::S     SSSSSSSh:::::h                                l:::::l l:::::l "
    echo -e "${BLUE}S:::::S             h::::h hhhhh           eeeeeeeeeeee    l::::l  l::::l "
    echo -e "${BLUE}S:::::S             h::::hh:::::hhh      ee::::::::::::ee  l::::l  l::::l "
    echo -e "${BLUE} S::::SSSS          h::::::::::::::hh   e::::::eeeee:::::eel::::l  l::::l "
    echo -e "${BLUE}  SS::::::SSSSS     h:::::::hhh::::::h e::::::e     e:::::el::::l  l::::l "
    echo -e "${BLUE}    SSS::::::::SS   h::::::h   h::::::he:::::::eeeee::::::el::::l  l::::l "
    echo -e "${BLUE}       SSSSSS::::S  h:::::h     h:::::he:::::::::::::::::e l::::l  l::::l "
    echo -e "${BLUE}            S:::::S h:::::h     h:::::he::::::eeeeeeeeeee  l::::l  l::::l "
    echo -e "${BLUE}            S:::::S h:::::h     h:::::he:::::::e           l::::l  l::::l "
    echo -e "${BLUE}SSSSSSS     S:::::S h:::::h     h:::::he::::::::e         l::::::ll::::::l"
    echo -e "${BLUE}S::::::SSSSSS:::::S h:::::h     h:::::h e::::::::eeeeeeee l::::::ll::::::l"
    echo -e "${BLUE}S:::::::::::::::SS  h:::::h     h:::::h  ee:::::::::::::e l::::::ll::::::l"
    echo -e "${BLUE} SSSSSSSSSSSSSSS    hhhhhhh     hhhhhhh    eeeeeeeeeeeeee llllllllllllllll${RESET}"
    echo
}

eyeascii() {
    echo -e "                                                            %%%%%%%#######################%%%%%%%%%%"${RESET}
    echo -e "                                                     %%%###################*###########################%%%%"${RESET}
    echo -e "                                               %%%###########*****++=====----===========++++******###########%%%%"${RESET}
    echo -e "                                          %%%#########**++==--:::${BLUE}.............................${RESET}::::-==++***#########%%%"${RESET}
    echo -e "                                      %%%########*+==-::${BLUE}................................................${RESET}::-=+***#######%%%"
    echo -e "                                  %%%######**+=--::${BLUE}..........................................................${RESET}::-=++***#####%%%"
    echo -e "                            %%######*+=-::${BLUE}.............................................................................${RESET}:=+***####%%"
    echo -e "                         %%######*+=-:${BLUE}....................................................................................${RESET}:-+**#####%%"
    echo -e "                   %#####*+=::${BLUE}...................................${PURPLE}::---==+++**####****++==---:::${RESET}${BLUE}...................................${RESET}:=+*#####%%"
    echo -e "                 %#####*+-:${BLUE}...................................${PURPLE}::-%%%%%%#%@@@@@@@%#%%@@%%#*+==---::${RESET}${BLUE}...................................${RESET}-+*#####%%"
    echo -e "               %%####*+-:${BLUE}...................................${PURPLE}::-=+%###%%%%%%%%@@%#%#%%%%%%%%%#*+=---:${RESET}${BLUE}..................................${RESET}:-+*#####%"
    echo -e "             %%#####+=:${BLUE}...................................${PURPLE}::-=+%%%%#+%%%%%%%%@@%#%#@@@%%%%%%%%%#*=---:${RESET}${BLUE}..................................${RESET}:-+######%"
    echo -e "           %%#####*=:${BLUE}...................................${PURPLE}::-=+#####%%%%%%%%###%@%#%#@@@@@@%%%%#####+=---:${RESET}${BLUE}..................................${RESET}:=*#####%%"
    echo -e "          %#####*=:${BLUE}....................................${PURPLE}:--+%%%#+==%##%++%####%@%##%@@@@@@%#+=%%%=%%%+=--:${RESET}${BLUE}...................................${RESET}-=*#####%%"
    echo -e "        %%####*+-:${BLUE}....................................${PURPLE}:-=*%%%%%#%%%%%%%%%#%%%%@@%%@@@@@@#+-%%%%%%%%###+--:${RESET}${BLUE}...................................${RESET}:-+*#####%"
    echo -e "       %#####*=:${BLUE}.....................................${PURPLE}:-=*%@@%##%#%%%%%##%%%%##%@@@@@@@#=%%%%%%%%:%%%%#+--:${RESET}${BLUE}....................................${RESET}:=*#####%"
    echo -e "      %####*+-:${BLUE}.....................................${PURPLE}:-=#%@@@@%%####%%%%%%@@%%%%%%@@%%%%%-%%%%%%%%%+#%@@#+--:${RESET}${BLUE}....................................${RESET}:-+#####%%"
    echo -e "     %####*+-${BLUE}......................................${PURPLE}:-=*%@@%%%%%%%#%%#%%%#%@%%%%%%%%%%%%%%%%%%%%%%#%%@%%#=-::${RESET}${BLUE}....................................${RESET}$:-+*#####%"
    echo -e "   %%####*=:${BLUE}.......................................${PURPLE}:-+#@@@%%%%%%%%%%%%%#%#%%%%%%#%%%%%#%%%%%%%%#%#%%%%##+=-:${RESET}${BLUE}......................................${RESET}:=*#####%"
    echo -e "  %%####*=:${BLUE}.......................................${PURPLE}:-=*%@@%%#%%%@@%%%%%%%%##%%##%%%%%%%#%#####%%#%%%%%%%#%#+-::${RESET}${BLUE}......................................${RESET}:=*#####%"
    echo -e " %%####*+:${BLUE}........................................${PURPLE}:-+#%%#%%%%%%@@@%%%%%%%%%%%@@%%%%%%%#%%%##%%#%%%###%%%%#*=-:${RESET}${BLUE}.......................................${RESET}:=*#####%"
    echo -e "%%####*=:${BLUE}.........................................${PURPLE}:-+#%#%%%%%%%#%@%%%%%%%###%%%##%%%%%%%%%###%%#%%%%%%%%##*=-:${RESET}${BLUE}........................................${RESET}:+*#####%"
    echo -e "%####*+:${BLUE}..........................................${PURPLE}:-+#%##%%%####%@%%%%%%##%%%#######%%%%%%###%%%%%%%%%%%#%#+-:${RESET}${BLUE}.........................................${RESET}:+*####%"
    echo -e "%####*=:${BLUE}..........................................${PURPLE}:=+#%#%%%%%%%#%@@%%%%%%%%@%########%#%%%%%#%%%@@@@@@@%@@#+-:${RESET}${BLUE}.........................................${RESET}:=*#####"
    echo -e "%%###*+-${BLUE}..........................................${PURPLE}:-+#%##%%%%%%#%@@@%%%%##%@%%%###%%%###%%%%%%%%#%%%%%##%%#+-:${RESET}${BLUE}.........................................${RESET}-+*####%"
    echo -e " %%###*+-${BLUE}.........................................${PURPLE}:-+#%#%%%%%##%%@@@%%%%%#%%%@%%%%%%###%%%%%%%@%#%%%%%##%%*=-:${RESET}${BLUE}........................................${RESET}-+*####%"
    echo -e "  %%###*+-${BLUE}........................................${PURPLE}:-=#@@@%%%%%#%#%@@@%%%%%###########%%%%%%%@@%@@@%%%##%%#+-::${RESET}${BLUE}.......................................${RESET}:+*####%"
    echo -e "   %%####+-:${BLUE}.......................................${PURPLE}:-+%@%#%%%%%###%@@@%%%%%%%%#####%%%%%%%%@@%#%%%%##%%@%*=-:${RESET}${BLUE}......................................${RESET}:-+*####%"
    echo -e "    %%####+-:${BLUE}......................................${PURPLE}:-=*%%%%%##%%%#%@@@@@@%%%%%%%%%%%%%%%%%%%##%#%%%%##%%#+-::${RESET}${BLUE}.....................................${RESET}:-*#####%"
    echo -e "     %%####*=:${BLUE}......................................${PURPLE}:-+#%%#%%%%#%@%%%%@@@@%%%%%%%%%%%%%%%##%%%%%%%###%@%+=-:${RESET}${BLUE}.....................................${RESET}:=*####%%"
    echo -e "       %####*=:${BLUE}......................................${PURPLE}:-+#%###%%%%%#%%#%@@@@@@@@@@@@@@%%#%%%%%%%%%%%#%%%*=-:${RESET}${BLUE}.....................................${RESET}:=*####%%"
    echo -e "        %####*+-:${BLUE}.....................................${PURPLE}:-=#%@@@%%#%++#%%%%%%@%###%%###%%%%%%%%%%%%%#%%#+--:${RESET}${BLUE}....................................${RESET}:-+*####%"
    echo -e "         %%####*=:${BLUE}.....................................${PURPLE}:-=*%@@%#+=+%%#%%##%@%%%%%%%%%%%%%%%%%%%%%#%%#+-::${RESET}${BLUE}....................................${RESET}:=*####%%"
    echo -e "           %####*+-:${BLUE}.....................................${PURPLE}:-+#%%#%%%%%%%#%#@@%%%%%%%%%%%%%%%%%%##%%#*=-:${RESET}${BLUE}....................................${RESET}:-+*####%"
    echo -e "            %%####*=:${BLUE}.....................................${PURPLE}::=+#%%%%%#%#%%%@@%%+%##%++%%%%%#%@%%%#*=--:${RESET}${BLUE}...................................${RESET}:-+*####%%"
    echo -e "              %%###**=:${BLUE}.....................................${PURPLE}::-+%#%%@%###@@@@#%#%%#%%#%%%%%%%%#+=-::${RESET}${BLUE}...................................${RESET}:-=*####%%"
    echo -e "                %%###*+=:${BLUE}......................................${PURPLE}:--+*##%%@@@@@%%%@@%%%%%%%%#*+=--::${RESET}${BLUE}...................................${RESET}:-=+*####%"
    echo -e "                  %%###**=:${BLUE}.......................................${PURPLE}:--==+*##%%%%%%%%###*++=--::${RESET}${BLUE}......................................${RESET}:=**####%%"
    echo -e "                    %%####*=-:${BLUE}........................................${PURPLE}::----=======----:::${RESET}${BLUE}......................................${RESET}::-+*#####%%"
    echo -e "                      %%###**+=:${BLUE}..............................................................................................${RESET}:-=**####%%"
    echo -e "                         %%###**+=:${BLUE}........................................................................................${RESET}:-=+*#####%%"
    echo -e "                          %%####**+-:${BLUE}.................................................................................${RESET}::-=+*#####%%"
    echo -e "                             %%####**+=-:${BLUE}..........................................................................${RESET}::-+**#####%%"
    echo -e "                                 %%####***+=-:${BLUE}..................................................................${RESET}::-=+*#####%%%"
    echo -e "                                    %%####***+=-::${BLUE}.......................................................${RESET}:::-==+**#####%%%"
    echo -e "                                        %%######**++=-:::${BLUE}..........................................${RESET}:::-=++**#######%%%"
    echo -e "                                            %%%#######****++==--::::::::::::::::::::::::::::-===++*****#######%%%"${RESET}
    echo -e "                                                   %%%##########******************+++++++*****##########%%%%"${RESET}
    echo -e "                                                         %%%%%################################%%%%%"${RESET}
    echo -e ""
}

# --------------DEBUG INFO!!!--------------

snvpd=$(vpd -i RO_VPD -l  | head -n 6 | tail -n 1)
sdsdns=$(vpd -i RO_VPD -l  | tail -n 1)
kernver=$(crossystem tpm_kernver)
dbu=$(crossystem dev_boot_usb)
hwid=$(crossystem hwid)
fwid=$(crossystem fwid)
ro_fwid=$(crossystem ro_fwid)
fwver=$(crossystem tpm_fwver)

# is swwp disabled??
if flashrom --wp-disable>/dev/null 2>&1; then
    wp="off"
    clear
else
    wp="on"
    clear
fi

# is hwwp disabled? doesnt matter much anyways, only there for debug info lol
hwwpc=$(crossystem wpsw_cur)>/dev/null 2>&1
if [ "hwwpc" = "0" ]; then
    hwwp="off"
    clear
else
    hwwp="on"
    clear
fi

image_file="${FLAGS_file}"
if [ -z "${image_file}" ]; then
    image_file="$(make_temp_file)"
    flashrom_read "${image_file}">/dev/null 2>&1
fi
gbbfldbg=$(futility gbb -g --flags "${image_file}" 2>/dev/null \
    | tail -n 1 \
    | grep -oE '0x[0-9a-fA-F]+')

# -----------------------------------------


# hub tui WILL BE REPLACED ONCE NULL GETS THE GUI RIGHT
while true; do
    clear
    stimascii
    # comments next to a statement most likely is a reference for null so he can make a recreation of the keyrolled verison of the chrome os coreboot for this payload :D
    echo "Where would you like to go?"
    echo
    echo "1) Enrollment manager" # fyi this will look like the recover using external storage thing
    if [ "$test" = "1" ]; then
        echo -e "2) ${RED}DAUB${RESET} (not supported)" # this will be where it says launch diagnostics, and if test = 1, itll act like the page up button when your already at the top of fw log or debug info
    else
        echo -e "2) DAUB"
    fi
    echo "3) Advanced Options" # obviously this will represent advanced options
    echo "4) Power off" # obviously this will represent power off
    read -n 1 -rp "Enter: " options # This should NEVER be a thing in the gui, only here to serve as a place holder for tui
    

    case $options in
        1)
            clear
            ic
            echo "Entering enrollment manager..."
            sleep 1
            clear
            clean
            enrollman
        ;;

        2)
            clear
            ic
            echo "Entering daub..."
            sleep 1
            clear
            clean
            daub
        ;;

        3)
            clear
            while true; do
                clear
                if [ "$wp" = "off" ]; then
                    echo "WP IS OFF, MORE PAYLOADS ARE NOW SHOWN"
                    echo ""
                    echo "Which payload would you like to execute?"
                    echo
                    echo "1) Unkeyroll"
                    echo "2) GBBFlagger"
                    echo "3) Bash shell"
                    echo "4) FW manager"
                    echo "5) Debug info"
                    echo "6) Back"
                    read -n 1 -rp "Enter: " wpoffadvoptions
                    case $wpoffadvoptions in

                        1)
                            clear
                            ic
                            echo "Executing Unkeyroll payload..."
                            sleep 1
                            clear
                            clean
                            unkeyroll
                            clear
                        ;;
                        
                        2)
                            clear
                            ic
                            echo "Executing GBBFlagger payload..."
                            sleep 1
                            clear
                            clean
                            gbbflagger
                            clear
                        ;;

                        3)
                            clear
                            shellascii
                            echo "Use the exit command to exit out of bash"
                            bash
                            clear
                        ;;
                        
                        4)
                            clear
                            ic
                            echo "Executing FW manager Payload..."
                            sleep 1
                            clear
                            clean
                            fwmanager
                            clear
                        ;;

                        5)
                            ic
                            clear
                            echo "$snvpd"
                            echo "$sdsdns"
                            echo "kernver = $kernver"
                            echo "allow dev_boot_usb = $dbu"
                            echo "HWID = $hwid"
                            echo "FWID = $fwid"
                            echo "RO_FWID = $ro_fwid"
                            echo "curtpmfwver = $fwver"
                            echo "gbb flags = $gbbfldbg"
                            echo "SW WP = $wp"
                            echo "HW WP = $hwwp"
                            read -n 1 -rp "Press any key to exit :D"
                            clean
                            clear
                        ;;

                        6)
                            clear
                            ic
                            echo "Heading back to main menu.."
                            sleep 1
                            clean
                            break
                        ;;
                    esac


                else
                    echo "WP IS ON, CERTAIN PAYLOADS ARE HIDDEN"
                    echo
                    echo "Which payload would you like to execute?"
                    echo
                    echo "1) WP Disable loop"
                    echo "2) Debug info"
                    echo "3) FW manager (limited options)"
                    echo "4) Bash shell"
                    echo "5) Back"
                    read -n 1 -rp "Enter: " wponadvoptions
                    case $wponadvoptions in

                        1)
                            clear
                            echo "Executing wp disable loop..."
                            sleep 1
                            clear
                            wpdisloop
                            clear
                        ;;

                        2)
                            ic
                            clear
                            echo "$snvpd"
                            echo "$sdsdns"
                            echo "kernver = $kernver"
                            echo "allow dev_boot_usb = $dbu"
                            echo "HWID = $hwid"
                            echo "FWID = $fwid"
                            echo "RO_FWID = $ro_fwid"
                            echo "curtpmfwver = $fwver"
                            echo "gbb flags = $gbbfldbg"
                            echo "SW WP = $wp"
                            echo "HW WP = $hwwp"
                            read -n 1 -rp "Press any key to exit :D"
                            clean
                            clear
                        ;;

                        3)
                            clear
                            echo "Executing FW manager (limited options)"
                            sleep 1
                            fwnfrow
                            clear
                        ;;

                        4)
                            clear
                            shellascii
                            echo "Use the exit command to exit out of bash"
                            bash
                            clear
                        ;;

                        5)
                            clear
                            echo "Heading back to main menu.."
                            sleep 1
                            break
                        ;;
                    esac

                fi
            done

        ;;

        4)
            clear
            echo "If you say so :/"
            sleep 1
            reboot -f
            echo "For some reason u didnt reboot, weird, lets try it 10 more times!"
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
        ;;

        *)
            clear
            echo "Invalid input, please try again."
            sleep 1
        ;;
    esac
done

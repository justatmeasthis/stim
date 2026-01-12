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

# is wp disabled??
if flashrom --wp-disable; then
    wp="off"
    clear
else
    wp="off"
    clear
fi
# Check to see if where we at and warn if not in right place
fullpath="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
if [ "fullpath" = "/usr/sbin" ]; then
    test='0'
    
else
    test="1"
    while true; do
        clear
        echo -e "${RED}Warning:${RESET} you are currently running this in the wrong place, some features will be disabled and will be marked unusable via a red text mark, continue? (Y/N)"
        read -n 1 -rp "Enter: " testwarn
        if [ "$testwarn" = "Y" ] || [ "$testwarn" = "y" ]; then
            clear
            echo "test mode is on, certain scripts wont work."
            sleep 3
            break
        elif [ "$testwarn" = "N" ] || [ "$testwarn" = "n" ]; then
            clear
            echo "exiting script, sorry twin"
            sleep 1
            exit
        else
            clear
            echo "Invalid input, please try again."
            sleep 1
        fi
    done
fi
# GET FUNCTIONS 
source $fullpath/functions.sh
# ASCII ART FUNCTIONS
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

# hub placeholder

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
            echo "Entering enrollment manager..."
            sleep 1
            enrollman
        ;;

        2)
            clear
            echo "Entering daub..."
            sleep 1
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
                            echo "Executing Unkeyroll payload..."
                            sleep 1
                            clear
                            unkeyroll
                            clear
                        ;;
                        
                        2)
                            clear
                            echo "Executing GBBFlagger payload..."
                            sleep 1
                            clear
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
                            echo "Executing FW manager Payload..."
                            sleep 1
                            clear
                            fwmanager
                            clear
                        ;;

                        5)
                            clear
                            echo "This will show some debug info on chrome os like the milestone, kernver, fwmp setting, vpd, current fw, hwid, and more."
                            sleep 1
                            clear
                        ;;

                        6)
                            clear
                            echo "Heading back to main menu.."
                            sleep 1
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
                    echo "3) FW manager (No full rom overwrite)"
                    echo "4) Bash shell"
                    echo "5) back"
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
                            clear
                            echo "This will show some debug info on chrome os like the milestone, kernver, fwmp setting, vpd, current fw, hwid, and more."
                            sleep 1
                            clear
                        ;;

                        3)
                            clear
                            echo "Executing FW manager (No full rom overwrite)"
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

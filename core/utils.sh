#!/bin/bash

# Color codes for different log levels
BLACK='\033[0;30m'        # Black
RED='\033[0;31m'          # Red
GREEN='\033[0;32m'        # Green
YELLOW='\033[0;33m'       # Yellow
BLUW='\033[0;34m'         # Blue
MAGENTA='\033[0;35m'      # Magenta/Purple
CYAN='\033[0;36m'         # Cyan
WHITE='\033[0;37m'        # White/Light Gray
DARK_GREY='\033[0;90m'    # Dark Gray
LIGHT_RED='\033[0;91m'      # Light Red
LIGHT_GREEN='\033[0;92m'    # Light Green
LIGHT_YELLOW='\033[0;93m'   # Light Yellow
LIGHT_BLUE='\033[0;94m'     # Light Blue
LIGHT_MAGENTA='\033[0;95m'  # Light Purple
LIGHT_CYAN='\033[0;96m'     # Light Cyan
LIGHT_WHITE='\033[0;97m'    # Light White
NC='\033[0m'  # No Color/Reset

start_time=$SECONDS

# Function to calculate elapsed time
elapsed_time() {
  elapsed_time=$((SECONDS - start_time))
  printf "%02d:%02d:%02d" $((elapsed_time/3600)) $((elapsed_time%3600/60)) $((elapsed_time%60))
}

# Enhanced logging functions with tab alignment
spam()     { printf "\n${DARK_GREY}[${LIGHT_YELLOW}$(elapsed_time)${DARK_GREY}] ${LIGHT_WHITE}SPAM${NC}\t\t${DARK_GREY}|${NC} %s" "$*"; }
debug()    { printf "\n${DARK_GREY}[${LIGHT_YELLOW}$(elapsed_time)${DARK_GREY}] ${CYAN}DEBUG${NC}\t${DARK_GREY}|${NC} %s" "$*"; }
verbose()  { printf "\n${DARK_GREY}[${LIGHT_YELLOW}$(elapsed_time)${DARK_GREY}] ${LIGHT_CYAN}VERBOSE${NC}\t${DARK_GREY}|${NC} %s" "$*"; }
info()     { printf "\n${DARK_GREY}[${LIGHT_YELLOW}$(elapsed_time)${DARK_GREY}] ${LIGHT_BLUE}INFO${NC}\t\t${DARK_GREY}|${NC} %s" "$*"; }
notice()   { printf "\n${DARK_GREY}[${LIGHT_YELLOW}$(elapsed_time)${DARK_GREY}] ${MAGENTA}NOTICE${NC}\t${DARK_GREY}|${NC} %s" "$*"; }
warning()  { printf "\n${DARK_GREY}[${LIGHT_YELLOW}$(elapsed_time)${DARK_GREY}] ${YELLOW}WARNING${NC}\t${DARK_GREY}|${NC} %s" "$*"; }
success()  { printf "\n${DARK_GREY}[${LIGHT_YELLOW}$(elapsed_time)${DARK_GREY}] ${LIGHT_GREEN}SUCCESS${NC}\t${DARK_GREY}|${NC} %s" "$*"; }
error()    { printf "\n${DARK_GREY}[${LIGHT_YELLOW}$(elapsed_time)${DARK_GREY}] ${LIGHT_RED}ERROR${NC}\t${DARK_GREY}|${NC} %s" "$*"; exit 1; }
critical() { printf "\n${DARK_GREY}[${LIGHT_YELLOW}$(elapsed_time)${DARK_GREY}] ${RED}CRITICAL${NC}\t${DARK_GREY}|${NC} %s" "$*"; exit 1; }

rspam()     { printf "\r${DARK_GREY}[${LIGHT_YELLOW}$(elapsed_time)${DARK_GREY}] ${LIGHT_WHITE}SPAM${NC}\t\t${DARK_GREY}|${NC} %s" "$*"; }
rdebug()    { printf "\r${DARK_GREY}[${LIGHT_YELLOW}$(elapsed_time)${DARK_GREY}] ${CYAN}DEBUG${NC}\t${DARK_GREY}|${NC} %s" "$*"; }
rverbose()  { printf "\r${DARK_GREY}[${LIGHT_YELLOW}$(elapsed_time)${DARK_GREY}] ${LIGHT_CYAN}VERBOSE${NC}\t${DARK_GREY}|${NC} %s" "$*"; }
rinfo()     { printf "\r${DARK_GREY}[${LIGHT_YELLOW}$(elapsed_time)${DARK_GREY}] ${LIGHT_BLUE}INFO${NC}\t\t${DARK_GREY}|${NC} %s" "$*"; }
rnotice()   { printf "\r${DARK_GREY}[${LIGHT_YELLOW}$(elapsed_time)${DARK_GREY}] ${MAGENTA}NOTICE${NC}\t${DARK_GREY}|${NC} %s" "$*"; }
rwarning()  { printf "\r${DARK_GREY}[${LIGHT_YELLOW}$(elapsed_time)${DARK_GREY}] ${YELLOW}WARNING${NC}\t${DARK_GREY}|${NC} %s" "$*"; }
rsuccess()  { printf "\r${DARK_GREY}[${LIGHT_YELLOW}$(elapsed_time)${DARK_GREY}] ${LIGHT_GREEN}SUCCESS${NC}\t${DARK_GREY}|${NC} %s" "$*"; }
rerror()    { printf "\r${DARK_GREY}[${LIGHT_YELLOW}$(elapsed_time)${DARK_GREY}] ${LIGHT_RED}ERROR${NC}\t${DARK_GREY}|${NC} %s" "$*"; exit 1; }
rcritical() { printf "\r${DARK_GREY}[${LIGHT_YELLOW}$(elapsed_time)${DARK_GREY}] ${RED}CRITICAL${NC}\t${DARK_GREY}|${NC} %s" "$*"; exit 1; }

logo() {
    clear
    printf "${LIGHT_CYAN}
╔══════════════════════════════════════════════════════════════════════════════════╗
║                                                                                  ║
║  ${LIGHT_BLUE}██╗  ██╗██╗   ██╗██████╗ ██████╗ ███████╗██████╗  █████╗  ██████╗███████╗${LIGHT_CYAN}       ║
║  ${LIGHT_BLUE}██║  ██║╚██╗ ██╔╝██╔══██╗██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝██╔════╝${LIGHT_CYAN}       ║
║  ${LIGHT_BLUE}███████║ ╚████╔╝ ██████╔╝██████╔╝███████╗██████╔╝███████║██║     █████╗${LIGHT_CYAN}         ║
║  ${LIGHT_BLUE}██╔══██║  ╚██╔╝  ██╔═══╝ ██╔══██╗╚════██║██╔═══╝ ██╔══██║██║     ██╔══╝${LIGHT_CYAN}         ║
║  ${LIGHT_BLUE}██║  ██║   ██║   ██║     ██║  ██║███████║██║     ██║  ██║╚██████╗███████╗${LIGHT_CYAN}       ║
║  ${LIGHT_BLUE}╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝  ╚═╝ ╚═════╝╚══════╝${LIGHT_CYAN}       ║
║                                                                                  ║
║  ${LIGHT_GREEN}A custom installation for ${LIGHT_MAGENTA}Hyprland${NC} ${LIGHT_GREEN}by ${LIGHT_YELLOW}hurameco${LIGHT_CYAN}                                  ║
╚══════════════════════════════════════════════════════════════════════════════════╝${NC}\n"
}

export -f spam debug verbose info notice warning success error critical elapsed_time

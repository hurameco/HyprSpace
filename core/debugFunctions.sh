#!/bin/bash

# Color codes for different log levels
SPAM_COLOR='\033[2;37m'      # Dim gray
DEBUG_COLOR='\033[0;36m'     # Cyan
VERBOSE_COLOR='\033[0;37m'   # White/light gray
INFO_COLOR='\033[0;34m'      # Blue
NOTICE_COLOR='\033[0;35m'    # Magenta
WARNING_COLOR='\033[0;33m'   # Yellow
SUCCESS_COLOR='\033[0;32m'   # Green
ERROR_COLOR='\033[0;31m'     # Red
CRITICAL_COLOR='\033[1;91m'  # Bright red/bold
ORANGE='\033[38;5;208m'      # Timestamp color
GRAY='\033[0;90m'            # For brackets and separators
NC='\033[0m'                 # No Color

start_time=$SECONDS

# Function to calculate elapsed time
elapsed_time() {
  elapsed_time=$((SECONDS - start_time))
  printf "%02d:%02d:%02d" $((elapsed_time/3600)) $((elapsed_time%3600/60)) $((elapsed_time%60))
}

# Enhanced logging functions with tab alignment
spam()     { echo -e "${GRAY}[${ORANGE}$(elapsed_time)${GRAY}] ${SPAM_COLOR}SPAM${NC}\t\t${GRAY}|${NC} $*"; }
debug()    { echo -e "${GRAY}[${ORANGE}$(elapsed_time)${GRAY}] ${DEBUG_COLOR}DEBUG${NC}\t${GRAY}|${NC} $*"; }
verbose()  { echo -e "${GRAY}[${ORANGE}$(elapsed_time)${GRAY}] ${VERBOSE_COLOR}VERBOSE${NC}\t${GRAY}|${NC} $*"; }
info()     { echo -e "${GRAY}[${ORANGE}$(elapsed_time)${GRAY}] ${INFO_COLOR}INFO${NC}\t\t${GRAY}|${NC} $*"; }
notice()   { echo -e "${GRAY}[${ORANGE}$(elapsed_time)${GRAY}] ${NOTICE_COLOR}NOTICE${NC}\t${GRAY}|${NC} $*"; }
warning()  { echo -e "${GRAY}[${ORANGE}$(elapsed_time)${GRAY}] ${WARNING_COLOR}WARNING${NC}\t${GRAY}|${NC} $*"; }
success()  { echo -e "${GRAY}[${ORANGE}$(elapsed_time)${GRAY}] ${SUCCESS_COLOR}SUCCESS${NC}\t${GRAY}|${NC} $*"; }
error()    { echo -e "${GRAY}[${ORANGE}$(elapsed_time)${GRAY}] ${ERROR_COLOR}ERROR${NC}\t${GRAY}|${NC} $*"; exit 1; }
critical() { echo -e "${GRAY}[${ORANGE}$(elapsed_time)${GRAY}] ${CRITICAL_COLOR}CRITICAL${NC}\t${GRAY}|${NC} $*"; exit 1; }

logo() {
    echo -e "${SUCCESS_COLOR}
╔══════════════════════════════════════════════════════════════════════════════════╗
║                                                                                  ║
║  ██╗  ██╗██╗   ██╗██████╗ ██████╗ ███████╗██████╗  █████╗  ██████╗███████╗       ║
║  ██║  ██║╚██╗ ██╔╝██╔══██╗██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝██╔════╝       ║
║  ███████║ ╚████╔╝ ██████╔╝██████╔╝███████╗██████╔╝███████║██║     █████╗         ║
║  ██╔══██║  ╚██╔╝  ██╔═══╝ ██╔══██╗╚════██║██╔═══╝ ██╔══██║██║     ██╔══╝         ║
║  ██║  ██║   ██║   ██║     ██║  ██║███████║██║     ██║  ██║╚██████╗███████╗       ║
║  ╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝  ╚═╝ ╚═════╝╚══════╝       ║
║                                                                                  ║
║  ${ORANGE}A custom installation for ${WARNING_COLOR}Hyprland${NC} ${ORANGE}by ${CRITICAL_COLOR}hurameco${SUCCESS_COLOR}                                  ║
╚══════════════════════════════════════════════════════════════════════════════════╝${NC}"
}

export -f spam debug verbose info notice warning success error critical elapsed_time

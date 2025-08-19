#!/bin/bash

# TTY Color Support Test Script
# This script tests what colors and formatting are available in your terminal/TTY

echo "=== TTY Color Support Test ==="
echo

# Test basic 8 colors (foreground)
echo "Basic 8 Colors (Foreground):"
printf "\033[0;30mBlack\033[0m "
printf "\033[0;31mRed\033[0m "
printf "\033[0;32mGreen\033[0m "
printf "\033[0;33mYellow\033[0m "
printf "\033[0;34mBlue\033[0m "
printf "\033[0;35mMagenta\033[0m "
printf "\033[0;36mCyan\033[0m "
printf "\033[0;37mWhite\033[0m\n"
echo

# Test bright colors (if supported)
echo "Bright Colors (90-97):"
printf "\033[0;90mBright Black\033[0m "
printf "\033[0;91mBright Red\033[0m "
printf "\033[0;92mBright Green\033[0m "
printf "\033[0;93mBright Yellow\033[0m "
printf "\033[0;94mBright Blue\033[0m "
printf "\033[0;95mBright Magenta\033[0m "
printf "\033[0;96mBright Cyan\033[0m "
printf "\033[0;97mBright White\033[0m\n"
echo

# Test text formatting
echo "Text Formatting:"
printf "\033[1mBold\033[0m "
printf "\033[2mDim\033[0m "
printf "\033[3mItalic\033[0m "
printf "\033[4mUnderline\033[0m "
printf "\033[5mBlink\033[0m "
printf "\033[7mReverse\033[0m "
printf "\033[9mStrikethrough\033[0m\n"
echo

# Test background colors
echo "Background Colors:"
printf "\033[40;37m Black BG \033[0m "
printf "\033[41;37m Red BG \033[0m "
printf "\033[42;30m Green BG \033[0m "
printf "\033[43;30m Yellow BG \033[0m "
printf "\033[44;37m Blue BG \033[0m "
printf "\033[45;37m Magenta BG \033[0m "
printf "\033[46;30m Cyan BG \033[0m "
printf "\033[47;30m White BG \033[0m\n"
echo

# Test 256-color support (basic test)
echo "256-Color Support Test:"
if command -v tput >/dev/null 2>&1; then
    colors=$(tput colors 2>/dev/null || echo "unknown")
    echo "Terminal reports: $colors colors"
else
    echo "tput command not available"
fi

# Test a few 256 colors
echo "Sample 256 colors (if supported):"
for i in {16..21} {28..33} {40..45} {52..57}; do
    printf "\033[38;5;${i}m●\033[0m"
done
echo
echo

# Test true color (24-bit)
echo "True Color (24-bit) Test:"
echo "If you see a smooth gradient, true color is supported:"
for i in {0..255..8}; do
    printf "\033[38;2;${i};$((255-i));128m█\033[0m"
done
echo
echo

# Environment info
echo "=== Environment Information ==="
echo "TERM: ${TERM:-not set}"
echo "COLORTERM: ${COLORTERM:-not set}"
echo "Terminal: $(ps -o comm= -p $PPID 2>/dev/null || echo 'unknown')"

# TTY detection
if [ -t 1 ]; then
    echo "Output: TTY/Terminal"
else
    echo "Output: Not a TTY (piped/redirected)"
fi

# Check for specific TTY
if [[ "$TTY" == /dev/tty* ]] || [[ "$(tty 2>/dev/null)" == /dev/tty* ]]; then
    echo "Running in: Linux Console TTY"
    echo "Note: Linux console TTY typically supports 8-16 colors only"
else
    echo "Running in: Terminal emulator"
fi

echo
echo "=== Color Code Reference ==="
echo "Basic colors: \\033[0;3Xm (X = 0-7)"
echo "Bright colors: \\033[0;9Xm (X = 0-7)"
echo "256 colors: \\033[38;5;Xm (X = 0-255)"
echo "True color: \\033[38;2;R;G;Bm"
echo "Reset: \\033[0m"

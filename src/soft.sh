kernel_name="$(uname)"

if [ "${kernel_name}" = "Darwin" ]; then
	printf "🍎\n"
	system_version="$(system_profiler SPSoftwareDataType | awk -F ': ' '/System Version/ {printf $2}')"
	os_name=$(cut -d " " -f 1 <<< "$system_version")
	os_version=$(cut -d " " -f 2 <<< "$system_version")
elif [ "${kernel_name}" = "Linux" ]; then
	printf "🐧\n"
	os_name=$(awk -F '=' '/^NAME/ {printf $2}' /etc/*-release | tr -d '"')
	os_version=$(awk -F '=' '/^VERSION_ID/ {printf $2}' /etc/*-release | tr -d '"')
fi

kernel_version="$(uname -r | grep -oE '^[0-9]+(\.[0-9]+)*')"

if type -P bash &> /dev/null; then
	bash="$(bash --version | awk '/bash/ {printf $4}' | grep -oE '^[0-9]+(\.[0-9]+)*')"
else
	bash="✖"
fi

if ! type -P ldd &> /dev/null; then
	glibc="✖"
else
	glibc="$(ldd --version | awk '/ldd/ {printf $NF}')"
fi

printf "OS: \x1b[1m%s %s\x1b[0m\n" "${os_name}" "${os_version}"
printf "Kernel: \x1b[1m%s %s\x1b[0m\n" "${kernel_name}" "${kernel_version}"
printf "Bash: \x1b[1m%s\x1b[0m\n" "${bash}"
printf "glibc: \x1b[1m%s\x1b[0m\n" "${glibc}"

printf "             normal bright\n"
printf "0 (\x1b[3mblack\x1b[0m):   \x1b[40m       \x1b[100m       \x1b[0m\n"
printf "1 (\x1b[3mred\x1b[0m):     \x1b[41m       \x1b[101m       \x1b[0m\n"
printf "2 (\x1b[3mgreen\x1b[0m):   \x1b[42m       \x1b[102m       \x1b[0m\n"
printf "3 (\x1b[3myellow\x1b[0m):  \x1b[43m       \x1b[103m       \x1b[0m\n"
printf "4 (\x1b[3mblue\x1b[0m):    \x1b[44m       \x1b[104m       \x1b[0m\n"
printf "5 (\x1b[3mmagenta\x1b[0m): \x1b[45m       \x1b[105m       \x1b[0m\n"
printf "6 (\x1b[3mcyan\x1b[0m):    \x1b[46m       \x1b[106m       \x1b[0m\n"
printf "7 (\x1b[3mwhite\x1b[0m):   \x1b[47m       \x1b[107m       \x1b[0m\n"

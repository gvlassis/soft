kernel_name="$(uname)"

if [ "${kernel_name}" = "Darwin" ]; then
	system_version="$(system_profiler SPSoftwareDataType | awk -F ': ' '/System Version/ {printf $2}')"
	os_name=$(cut -d " " -f 1 <<< "$system_version")
	os_version=$(cut -d " " -f 2 <<< "$system_version")
elif [ "${kernel_name}" = "Linux" ]; then
	os_name=$(awk -F '=' '/^NAME/ {printf $2}' /etc/*-release | tr -d '"')
	os_version=$(awk -F '=' '/^VERSION_ID/ {printf $2}' /etc/*-release | tr -d '"')
fi
printf "OS: \x1b[1m%s %s\x1b[0m\n" "${os_name}" "${os_version}"

kernel_version="$(uname -r | grep -oE '^[0-9]+(\.[0-9]+)*')"
printf "Kernel: \x1b[1m%s %s\x1b[0m\n" "${kernel_name}" "${kernel_version}"

if ! type -P ldd &> /dev/null; then
	glibc="✖"
else
	glibc="$(ldd --version | awk '/ldd/ {printf $NF}')"
fi
printf "glibc: \x1b[1m%s\x1b[0m\n" "${glibc}"

if ! type -P nvidia-smi &> /dev/null; then
	cuda="✖"
else
	cuda="≤$(nvidia-smi | grep -oE 'CUDA Version: [0-9]+(\.[0-9]+)*' | cut -d ' ' -f 3)"
fi
printf "CUDA: \x1b[1m%s\x1b[0m\n" "${cuda}"

printf "\n"

if type -P bash &> /dev/null; then
	bash="$(bash --version | awk '/bash/ {printf $4}' | grep -oE '^[0-9]+(\.[0-9]+)*')"
else
	bash="✖"
fi
printf "Bash: \x1b[1m%s\x1b[0m\n" "${bash}"

if type -P python3 &> /dev/null; then
	python="$(python3 --version | grep -oE '[0-9]+(\.[0-9]+)*')"
else
	python="✖"
fi
printf "Python: \x1b[1m%s\x1b[0m\n" "${python}"

printf "\n"

printf "             normal bright\n"
printf "0 (\x1b[3mblack\x1b[0m):   \x1b[40m       \x1b[100m       \x1b[0m\n"
printf "1 (\x1b[3mred\x1b[0m):     \x1b[41m       \x1b[101m       \x1b[0m\n"
printf "2 (\x1b[3mgreen\x1b[0m):   \x1b[42m       \x1b[102m       \x1b[0m\n"
printf "3 (\x1b[3myellow\x1b[0m):  \x1b[43m       \x1b[103m       \x1b[0m\n"
printf "4 (\x1b[3mblue\x1b[0m):    \x1b[44m       \x1b[104m       \x1b[0m\n"
printf "5 (\x1b[3mmagenta\x1b[0m): \x1b[45m       \x1b[105m       \x1b[0m\n"
printf "6 (\x1b[3mcyan\x1b[0m):    \x1b[46m       \x1b[106m       \x1b[0m\n"
printf "7 (\x1b[3mwhite\x1b[0m):   \x1b[47m       \x1b[107m       \x1b[0m\n"

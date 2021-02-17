alias gpg=gpg2

mkcd() { mkdir -p "$1" && cd "$1"; }

# Python Virtual Environment Support
[ -z "$PYVENV_DIR" ] && PYVENV_DIR="${HOME}/.local/share/pyshenv"
venv() {
	mkdir -p "$PYVENV_DIR"

	case $# in
		1)
			local NAME="$1"
			local PYBIN="python3"
			;;
		2)
			local NAME="$1"
			local PYBIN="$2"
			;;
		*)
			echo "Usage: venv <name> [python_binary]"
			return 1
			;;
	esac
	
	if [ ! -d "${PYVENV_DIR}/${NAME}" ]; then
		$PYBIN -m venv "${PYVENV_DIR}/${NAME}"
	fi
	source "${PYVENV_DIR}/${NAME}/bin/activate"
}
lspybins() {
	echo -n $PATH | xargs -d : -I {} find {} -maxdepth 1 \
		-executable -type f -printf '%P\n' 2>/dev/null \
		| grep -E "^python[2,3](\.[0-9]m?)?$"
}

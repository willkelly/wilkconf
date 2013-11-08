VENV=${VENV:-$HOME/src/venv/global}
mkdir -p $(dirname ${VENV}) &>/dev/null || true
if ! [[ -f ${VENV}/bin/activate ]]; then
    echo "Virtual env ${VENV} not created." 1>&2
    if ! which virtualenv &>/dev/null; then
	echo "virtualenv not found, installing" 1>&2
	sudo apt-get install -y python-virtualenv
    fi
    virtualenv ${VENV} &>/dev/null
fi

source ${VENV}/bin/activate

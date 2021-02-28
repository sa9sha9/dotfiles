# dispatch load script by arch
arch_name="$(uname -m)"
if [ "${arch_name}" = "x86_64" ]; then
    if [ "$(sysctl -in sysctl.proc_translated)" = "1" ]; then
        echo "Running on Rosetta 2"
        export PATH="/opt/homebrew/bin:$PATH" #brew
    else
        echo "Running on native Intel"
        export PATH="/usr/local/bin:$PATH" #brew
    fi
elif [ "${arch_name}" = "arm64" ]; then
    echo "Running on ARM"
else
    echo "Unknown architecture: ${arch_name}"
fi

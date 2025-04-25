#!/bin/bash
set -e

INITIUM_DIR="$HOME/.initium"
BIN_PATH="$INITIUM_DIR/bin"
TEMPLATE_PATH="$INITIUM_DIR/template"
LINK_PATH="$HOME/.local/bin/initium"

echo "[*] Installing initium Locally"

mkdir -p "$BIN_PATH"
mkdir -p "$TEMPLATE_PATH"
mkdir -p "$HOME/.local/bin"

cp ./initium "$BIN_PATH/initium"
chmod +x "$BIN_PATH/initium"

cp -r ./template/* "$TEMPLATE_PATH/"

if [[ -f "$LINK_PATH" ]]; then
	echo "[!] Existing symlink at $LINK_PATH found. Replacing..."
	rm "$LINK_PATH"
fi
ln -s "$BIN_PATH/initium" "$LINK_PATH"

if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
	echo -e "\n[!] WARNING: ~/.local/bin is not in your PATH."
	echo "	Add this to your shell config (e.g., .bashrc or .zshrc):"
	echo "	export PATH=\"\$HOME/.local/bin:\$PATH\""
fi

echo -e "\n[!] initium installed successfully!"
echo "	You can now run: initium -h"

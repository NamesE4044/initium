#!/bin/bash
set -e

INITIUM_DIR="$HOME/.firmkit"
BIN_PATH="$INITIUM_DIR/bin"
TEMPLATE_PATH="$INITIUM_DIR/template"
LINK_PATH="$HOME/.local/bin/firmkit"

echo "[*] Installing firmkit Locally"

mkdir -p "$BIN_PATH"
mkdir -p "$TEMPLATE_PATH"
mkdir -p "$HOME/.local/bin"

cp ./firmkit "$BIN_PATH/firmkit"
chmod +x "$BIN_PATH/firmkit"

cp -r ./template/* "$TEMPLATE_PATH/"

if [[ -f "$LINK_PATH" ]]; then
	echo "[!] Existing symlink at $LINK_PATH found. Replacing..."
	rm "$LINK_PATH"
fi
ln -s "$BIN_PATH/firmkit" "$LINK_PATH"

if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
	echo -e "\n[!] WARNING: ~/.local/bin is not in your PATH."
	echo "	Add this to your shell config (e.g., .bashrc or .zshrc):"
	echo "	export PATH=\"\$HOME/.local/bin:\$PATH\""
fi

echo -e "\n[!] firmkit installed successfully!"
echo "	You can now run: firmkit -h"

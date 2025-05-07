#!/bin/bash
set -e

INITIUM_DIR="$HOME/.ustart"
BIN_PATH="$INITIUM_DIR/bin"
TEMPLATE_PATH="$INITIUM_DIR/template"
LINK_PATH="$HOME/.local/bin/ustart"

echo "[*] Installing ustart Locally"

mkdir -p "$BIN_PATH" "$TEMPLATE_PATH" "$HOME/.local/bin"
echo "[*] Created core directories"

cp ./ustart "$BIN_PATH/ustart"
chmod +x "$BIN_PATH/ustart"
echo "[*] ustart CLI installed"

cp ./ustart-projects.dat "$INITIUM_DIR"

cp -r ./template* "$TEMPLATE_PATH/"
echo "[*] Templates installed"

if [[ -f "$LINK_PATH" ]]; then
	echo "[!] Existing symlink at $LINK_PATH found. Replacing..."
	rm "$LINK_PATH"
fi
ln -s "$BIN_PATH/ustart" "$LINK_PATH"


if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
	echo -e "\n[!] WARNING: ~/.local/bin is not in your PATH."
	echo "	Add this to your shell config (e.g., .bashrc or .zshrc):"
	echo "	export PATH=\"\$HOME/.local/bin:\$PATH\""
fi

echo -e "\n[!] ustart installed successfully!"
echo "You can now run: ustart -h"

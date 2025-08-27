#!/usr/bin/env sh

# =========================================
# palera1n iOS 18.4 Additional Setup Script
# =========================================

RED='\033[0;31m'
YELLOW='\033[0;33m'
DARK_GRAY='\033[90m'
LIGHT_CYAN='\033[0;96m'
DARK_CYAN='\033[0;36m'
NO_COLOR='\033[0m'
BOLD='\033[1m'

# =========
# Logging
# =========

error() {
    printf '%b\n' " - [${DARK_GRAY}$(date +'%m/%d/%y %H:%M:%S')${NO_COLOR}] ${RED}${BOLD}<Error>${NO_COLOR}: ${RED}$1${NO_COLOR}"
}

info() {
    printf '%b\n' " - [${DARK_GRAY}$(date +'%m/%d/%y %H:%M:%S')${NO_COLOR}] ${DARK_CYAN}${BOLD}<Info>${NO_COLOR}: ${DARK_CYAN}$1${NO_COLOR}"
}

warning() {
    printf '%b\n' " - [${DARK_GRAY}$(date +'%m/%d/%y %H:%M:%S')${NO_COLOR}] ${YELLOW}${BOLD}<Warning>${NO_COLOR}: ${YELLOW}$1${NO_COLOR}"
}

# =========
# Check if id is 0
# =========

[ "$(id -u)" -ne 0 ] && {
    warning "In order to use this script, run with root or use sudo."
    exit 1
}

# =========
# Variables
# =========

# Directory to store palera1n artifacts
ARTIFACTS_DIR="/usr/local/lib/palera1n"
PONGO_PATH="${ARTIFACTS_DIR}/Pongo.bin.development"
KPF_PATH="${ARTIFACTS_DIR}/checkra1n-kpf-pongo.development"
RAMDISK_PATH="${ARTIFACTS_DIR}/ramdisk.dmg"

# URLs for downloads
PONGO_URL="https://cdn.nickchan.lol/palera1n/artifacts/kpf/ios18.4/Pongo.bin.development"
KPF_URL="https://cdn.nickchan.lol/palera1n/artifacts/kpf/ios18.4/checkra1n-kpf-pongo.development"
RAMDISK_URL="https://cdn.nickchan.lol/palera1n/c-rewrite/deps/ramdisk.dmg"

# =========
# Functions
# =========

download_file() {
    local url="$1"
    local output_path="$2"
    local description="$3"
    
    info "Downloading ${description}..."
    status=$(curl --progress-bar --write-out '%{http_code}' -Lo "$output_path" "$url")
    
    if [ "$status" -ne 200 ]; then
        error "${description} failed to download. (Status: $status)"
        exit 1
    fi
    
    info "${description} downloaded successfully."
}

create_alias() {
    local alias_command="alias palera1n-18.4+='palera1n -l -k ${PONGO_PATH} -r ${RAMDISK_PATH} -K ${KPF_PATH}'"
    
    # Detect the current shell
    if [ -n "$BASH_VERSION" ]; then
        shell_config="$HOME/.bashrc"
    elif [ -n "$ZSH_VERSION" ]; then
        shell_config="$HOME/.zshrc"
    else
        # Default to bash if shell detection fails
        shell_config="$HOME/.bashrc"
    fi
    
    # For root user, also check /root directory
    if [ "$(id -u)" -eq 0 ]; then
        if [ -f "/root/.bashrc" ]; then
            shell_config="/root/.bashrc"
        elif [ -f "/root/.zshrc" ]; then
            shell_config="/root/.zshrc"
        fi
    fi
    
    # Check if alias already exists
    if grep -q "alias palera1n-18.4+=" "$shell_config" 2>/dev/null; then
        info "Alias already exists in $shell_config, updating..."
        # Remove old alias
        sed -i.bak "/alias palera1n-18.4+=/d" "$shell_config"
    fi
    
    # Add the alias to shell config
    echo "" >> "$shell_config"
    echo "# palera1n iOS 18.4 alias" >> "$shell_config"
    echo "$alias_command" >> "$shell_config"
    
    info "Alias added to $shell_config"
    
    # Also add to /etc/profile.d for system-wide availability
    if [ -d "/etc/profile.d" ]; then
        echo "#!/bin/sh" > /etc/profile.d/palera1n-18.4+.sh
        echo "$alias_command" >> /etc/profile.d/palera1n-18.4+.sh
        chmod +x /etc/profile.d/palera1n-18.4+.sh
        info "System-wide alias created in /etc/profile.d/palera1n-18.4+.sh"
    fi
}

# =========
# Main
# =========

info "Starting palera1n iOS 18.4 setup..."

# Check if palera1n is installed
if ! command -v palera1n >/dev/null 2>&1; then
    error "palera1n is not installed. Please run the install script first."
    exit 1
fi

# Create artifacts directory
info "Creating artifacts directory at ${ARTIFACTS_DIR}..."
mkdir -p "${ARTIFACTS_DIR}"

# Download required files
download_file "$PONGO_URL" "$PONGO_PATH" "Pongo.bin.development"
download_file "$KPF_URL" "$KPF_PATH" "checkra1n-kpf-pongo.development"
download_file "$RAMDISK_URL" "$RAMDISK_PATH" "ramdisk.dmg"

# Set proper permissions
chmod 644 "$PONGO_PATH"
chmod 644 "$KPF_PATH"
chmod 644 "$RAMDISK_PATH"

# Create the alias
create_alias

info "Setup complete!"
info ""
info "Files downloaded to:"
info "  - Pongo: ${PONGO_PATH}"
info "  - KPF: ${KPF_PATH}"
info "  - Ramdisk: ${RAMDISK_PATH}"
info ""
info "You can now use the command: palera1n-18.4+"
info "This is equivalent to: palera1n -l -k ${PONGO_PATH} -r ${RAMDISK_PATH} -K ${KPF_PATH}"
info ""
info "Please restart your shell or run: source ~/.bashrc (or ~/.zshrc)"
info "Or log out and log back in for the alias to take effect."
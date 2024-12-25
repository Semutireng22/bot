#!/bin/bash

# Colors for styling
GREEN="\033[1;32m"
CYAN="\033[1;36m"
YELLOW="\033[1;33m"
RED="\033[1;31m"
RESET="\033[0m"

# Banner
echo -e "${CYAN}"
echo "██╗   ██╗ ██████╗ ██████╗      █████╗ ██╗██████╗ ██████╗ ██████╗  ██████╗ ██████╗"
echo "██║   ██║██╔════╝ ██╔══██╗    ██╔══██╗██║██╔══██╗██╔══██╗██╔══██╗██╔═══██╗██╔══██╗"
echo "██║   ██║██║  ███╗██║  ██║    ███████║██║██████╔╝██║  ██║██████╔╝██║   ██║██████╔╝"
echo "██║   ██║██║   ██║██║  ██║    ██╔══██║██║██╔══██╗██║  ██║██╔══██╗██║   ██║██╔═══╝"
echo "╚██████╔╝╚██████╔╝██████╔╝    ██║  ██║██║██║  ██║██████╔╝██║  ██║╚██████╔╝██║"
echo " ╚═════╝  ╚═════╝ ╚═════╝     ╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚═╝"
echo -e "${RESET}${YELLOW}===================================================="
echo "     BOT                : Cyberfly Installer"
echo "     Telegram Channel   : https://t.me/UGDairdrop"
echo -e "====================================================${RESET}"

# Prompt for Kadena wallet address
read -p "$(echo -e "${GREEN}Enter your Kadena wallet address: ${RESET}")" kadena_wallet

# Automatically add "k:" if not present
if [[ $kadena_wallet != k:* ]]; then
  kadena_wallet="k:$kadena_wallet"
  echo -e "${YELLOW}Your Kadena wallet address has been updated to: ${CYAN}$kadena_wallet${RESET}"
fi

# Prompt for Node private key
read -p "$(echo -e "${GREEN}Enter your Node private key: ${RESET}")" node_priv_key

# Clone the repository
echo -e "${CYAN}Cloning the Cyberfly Node repository...${RESET}"
git clone https://github.com/cyberfly-io/cyberfly-node-docker.git
cd cyberfly-node-docker || exit

# Pull the latest changes
echo -e "${CYAN}Updating the repository...${RESET}"
git pull

# Set permissions and start the node
echo -e "${CYAN}Setting up and starting the node...${RESET}"
sudo chmod +x start_node.sh
sudo ./start_node.sh "$kadena_wallet" "$node_priv_key"

# Get the server's IP address
ip_address=$(curl -s ifconfig.me)

# Display success message with instructions
echo -e "${GREEN}===================================================="
echo "  Cyberfly Node setup complete!"
echo -e "====================================================${RESET}"
echo -e "${YELLOW}You can now access your node's UI by visiting:${RESET}"
echo -e "${CYAN}http://$ip_address:31000${RESET}"
echo -e "${GREEN}====================================================${RESET}"

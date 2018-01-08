#!/bin/bash

UNAMESTR=`uname`
USERNAME=`whoami`
PLUGINSPATH=$HOME/.oh-my-zsh/custom/plugins

RED='\033[0;31m'    # Red color
GREEN='\033[0;32m'  # Red color
NC='\033[0m'        # No Color

# Check if git is installed
if ! [ -x "$(command -v git)" ]; then
  echo "${RED}Error: git is not installed.${NC}" >&2
  exit 1
fi

# Check if ZSH is installed
if ! [ -x "$(command -v zsh)" ]; then
  echo "${RED}Error: zsh is not installed." >&2
  if [[ $UNAMESTR == 'Linux' ]]; then
     echo "Can be installed with package manager (yum install zsh)${NC}" >&2
  elif [[ $UNAMESTR == 'Darwin' ]]; then
     echo "Can be installed with: brew install zsh zsh-completion${NC}" >&2
  fi
  exit 1
fi

# Install Oh My ZSH
echo "${GREEN}Installing oh-my-zsh...${NC}"
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

# Install zsh-autosuggestions plugin
echo "${GREEN}Installing zsh-autosuggestions plugin...${NC}"
git clone https://github.com/zsh-users/zsh-autosuggestions $PLUGINSPATH/zsh-autosuggestions

# Install zsh-syntax-highlighting
echo "${GREEN}Installing zsh-syntax-highlighting plugin...${NC}"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $PLUGINSPATH/zsh-syntax-highlighting

# Install zsh-output-highlighting
echo "${GREEN}Installing zsh-output-highlighting plugin...${NC}"
git clone https://github.com/l4u/zsh-output-highlighting.git $PLUGINSPATH/zsh-output-highlighting

# .zshrc file modifications
sed -i 's/robbyrussell/agnoster/g' .zshrc                                                 # Change theme to agnoster
echo '# ZSH syntax highlighting (must be at the end of the file)' >> .zshrc               # Add syntax hightlighting plugin
echo "source $PLUGINSPATH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> .zshrc  # Add syntax hightlighting plugin
sed -i "/plugins=($/a \ \ zsh-autosuggestions" .zshrc                                     # Add zsh-autosuggestions plugin
sed -i "/plugins=($/a \ \ zsh-output-highlighting" .zshrc                                 # Add zsh-output-hightlighting plugin


# Check the username. If it is ec2-user this is probably an AWS machine and needs creating a password
# for the user to change shell into ohmyzsh
if [[ $USERNAME == 'ec2-user' ]]; then
  echo "${GREEN}Your username is ec2-user so this is probably an AWS machine. You will need to create a password for the user. This script will automatically delete back the password at the end.${NC}"
  sudo passwd ec2-user
fi

# Change shell to zsh
chsh -s /bin/zsh

# Delete user password if this is AWS
if [[ $USERNAME == 'ec2-user' ]]; then
  echo "${GREEN}Deleting previously created user password for security reasons...${NC}"
  sudo passwd --delete ec2-user
fi

# Final message
echo "${GREEN}Installation was successful. Relog into the console to enter oh-my-zsh. Keep in mind you have to install highlighting (OSX> brew install highlight Linux> install liblua https://rpmfind.net/linux/rpm2html/search.php?query=liblua-5.3.so()(64bit) , then install highlight http://www.andre-simon.de/zip/download.php.${NC}"

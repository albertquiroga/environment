# Environment
General server utilities and scripts

## Sources

iTerm2 + Oh My ZSH environment: https://gist.github.com/kevin-smets/8568070

ZSH output highlighting: https://github.com/l4u/zsh-output-highlighting#zsh-output-highlighting

A beautifully productive terminal experience: http://mikebuss.com/2014/02/02/a-beautiful-productive-terminal-experience/

Powerlevel10k theme: https://github.com/romkatv/powerlevel10k

Powerlevel9k prompt customization: https://github.com/bhilburn/powerlevel9k#prompt-customization

Add icons to the prompt: https://medium.freecodecamp.org/how-you-can-style-your-terminal-like-medium-freecodecamp-or-any-way-you-want-f499234d48bc

Nerd fonts (using 'hack' font): http://nerdfonts.com/#cheat-sheet

## How-to

1. Install Hack Nerd Font (or any other nerd font)

2. Install iTerm2, then configure it:
    1. Go to Preferences -> Profiles -> Create a new profile and set is as default
    2. In the profile configuration, go to Colors -> Color Presets -> Import -> Import the 'aws.itermcolors' file, then select the new aws profile
    3. In the profile configuration, go to Window and set the number of columns to 120
    4. In the profile configuration, go to Text and select Hack Nerd Font as the font
    5. In the profile configuration, go to Keys -> Presets and seelct Natural Text Editing
    6. Go to settings -> Appearance
    7. Under the General tab, set the Theme to Minimal
    8. Under the Windows tab, mark the Hide scrollbars option

2. Follow the 'environmentSetup.sh' script to install zsh, oh-my-zsh, plugins (zsh-autosuggestions, zsh-syntax-highlighting, zsh-output-highlighting)

3. Install the powerlevel10k oh-my-zsh theme

4. Edit your the .zshrc file to set it like the one in this repo

Done.

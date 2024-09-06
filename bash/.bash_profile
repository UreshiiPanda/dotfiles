# bash_profile:  for things you want to run just once on system startup/login

# run .bashrc each time .bash_profile is run
# gets all bash settings from .bashrc
source .bashrc

# load bash env vars each time .bash_profile is run
if [ -f ~/.bash_env ]; then
    source ~/.bash_env
fi

export PATH=$PATH:/Users/jojo/.spicetify

# Created by `pipx` on 2024-09-05 22:56:41
export PATH="$PATH:/Users/jojo/.local/bin"

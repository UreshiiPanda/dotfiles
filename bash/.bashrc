# bashrc:  for things that should run on every Bash open

echo $PATH
echo "\n 1 \n"

# modify the shell env to include all HomeBrew binaries and libraries
#eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="/opt/homebrew/bin:$PATH"

echo $PATH
echo "\n 2 \n"

# setup NVM and nvm bash_completion
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"       # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"     # This loads nvm bash_completion

echo $PATH
echo "\n 3 \n"

# setup PyEnv and add to path
export PYENV_ROOT="$HOME/.pyenv"
export PATH=$PATH:~/.pyenv/
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

echo $PATH
echo "\n 4 \n"

# setup FZF
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
eval "$(fzf --bash)"


# set editor to vim
set -o vi
export EDITOR=vi

echo $PATH
echo "\n 5 \n"

# get rid of Bash warnings
# you can also create a file called .hushlogin to get rid of "last login" msg in bash
export BASH_SILENCE_DEPRECATION_WARNING=1

echo $PATH
echo "\n 6 \n"

# this is for linking the system llvm to HomeBrew so that another version of llvm does NOT get installed
# cuz llvm is needed for ccls, a c++ lang server
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib/c++ -Wl,-rpath,/opt/homebrew/opt/llvm/lib/c++"

echo $PATH
echo "\n 7 \n"

# add LLVM to path
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

echo $PATH
echo "\n 8 \n"

# add Spicetify to Path 
export PATH=$PATH:~/.spicetify/

echo $PATH
echo "\n 9 \n"

# add gcloud to path
source "$(brew --prefix)/share/google-cloud-sdk/path.bash.inc"

echo $PATH
echo "\n 10 \n"

# add Kitty to the path (this was only needed for Kitty window shortcuts on non "~" dirs)
export PATH="/Applications/kitty.app/Contents/MacOS/kitty:$PATH"

echo $PATH
echo "\n 11 \n"

# add user bin to path
# for running user scripts globally
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/dotfiles/scripts:$PATH"

echo $PATH
echo "\n 12 \n"

# Ensure standard system bin directories are in PATH
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

echo $PATH
echo "\n 13 \n"

# Load Angular CLI autocompletion.
source <(ng completion script)

echo $PATH
echo $SHELL
echo "\n 14 \n"

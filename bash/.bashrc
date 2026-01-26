# bashrc:  for things that should run on every Bash open

# Initialize PATH with Homebrew paths first
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin"

# Then add other directories
export PATH="$PATH:/Applications/kitty.app/Contents/MacOS/kitty"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/dotfiles/scripts"
export PATH="$PATH:$HOME/.spicetify"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.pyenv"
export PATH="$PATH:/opt/homebrew/opt/llvm/bin"

# Add system paths last
export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# setup NVM and nvm bash_completion
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# setup PyEnv and add to path
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# setup FZF
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
eval "$(fzf --bash)"

# Enhanced FZF default options with preview
export FZF_DEFAULT_OPTS="
  --bind 'tab:down'
  --bind 'btab:up'
  --bind 'ctrl-a:toggle'
  --layout reverse
  --border rounded
  --height 80%
  --preview '~/bin/fp {}'
  --preview-window 'right:50%:wrap'
  --info inline
  --preview-window 'right:50%:border-left:wrap:border-sharp'"

# Default find command
export FZF_DEFAULT_COMMAND='find . -type f -not -path "*/\.*"'

# CTRL-T command
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# CTRL-R command for history
export FZF_CTRL_R_OPTS="
  --preview 'echo {}'
  --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# set editor to vim
set -o vi
export EDITOR=vi

# get rid of Bash warnings
# you can also create a file called .hushlogin to get rid of "last login" msg in bash
export BASH_SILENCE_DEPRECATION_WARNING=1

# this is for linking the system llvm to HomeBrew so that another version of llvm does NOT get installed
# cuz llvm is needed for ccls, a c++ lang server
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib/c++ -Wl,-rpath,/opt/homebrew/opt/llvm/lib/c++"

# add gcloud to path
source "$(brew --prefix)/share/google-cloud-sdk/path.bash.inc"

# Load Angular CLI autocompletion
source <(ng completion script)

# Add cargo environment
. "$HOME/.cargo/env"
export PATH="$PATH:$HOME/go/bin"
export PATH="/opt/homebrew/bin:$PATH"

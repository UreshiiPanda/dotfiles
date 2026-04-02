# bashrc: for things that should run on every Bash open

# --- PATH & Environment Setup ---
# Initialize PATH with Homebrew paths first
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

# Add other directories
export PATH="$PATH:/Applications/kitty.app/Contents/MacOS/kitty"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/dotfiles/scripts"
export PATH="$PATH:$HOME/.spicetify"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.pyenv/bin"
export PATH="$PATH:/opt/homebrew/opt/llvm/bin"
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# Set editor to Neovim
set -o vi
export EDITOR=nvim

# Get rid of Bash warnings
export BASH_SILENCE_DEPRECATION_WARNING=1

# --- Language & Tool Version Managers ---

# Setup NVM and nvm bash_completion
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# Setup PyEnv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Add cargo environment
. "$HOME/.cargo/env"

# --- FZF Configuration ---
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
eval "$(fzf --bash)"

# The "f" alias: Open selected file in Neovim (handles spaces in filenames)
alias f='fzf --print0 | xargs -0 -o nvim'

# Enhanced FZF default options with preview
export FZF_DEFAULT_OPTS="
  --bind 'tab:toggle'
  --bind 'btab:toggle'
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

# --- Build & Linker Flags (LLVM/CCLS) ---
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
export LDFLAGS="$LDFLAGS -L/opt/homebrew/opt/llvm/lib/c++ -Wl,-rpath,/opt/homebrew/opt/llvm/lib/c++"

# --- External SDKs & Completions ---
# Add gcloud to path
if [ -f "$(brew --prefix)/share/google-cloud-sdk/path.bash.inc" ]; then
    source "$(brew --prefix)/share/google-cloud-sdk/path.bash.inc"
fi

# Load Angular CLI autocompletion
source <(ng completion script)

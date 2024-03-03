# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.config/zsh/histfile
HISTSIZE=1000
SAVEHIST=10000
setopt autocd extendedglob nomatch notify
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/vebly/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

PS1="%n@ %~ %# "

# Aliases
alias zshconf="nvim ~/.zshrc"
alias zshso="source ~/.zshrc"
alias cpwd='pwd | tr -d "\n" | xargs echo -n | xclip -selection clipboard'
alias cmake_ecc='cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..'
alias nvimconf='nvim ~/.config/nvim/lua/core/init.lua'
alias nvimbinds='nvim ~/.config/nvim/lua/core/keymaps.lua'

# Zoxide, also creates alias
eval "$(zoxide init --cmd cd zsh)"

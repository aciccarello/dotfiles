# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="amuse"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  gitfast
  npm
  nvm
  grails
)

zstyle ':omz:plugins:nvm' autoload yes

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export PATH="$HOME/.poetry/bin:$PATH"

# bun completions
[ -s "/Users/aciccarello/.bun/_bun" ] && source "/Users/aciccarello/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export PATH="/Users/aciccarello/.detaspace/bin:$PATH"

export CODE_DIR=$HOME/code

# ICD
export GRAILS_HOME=$HOME/.sdkman/candidates/grails/3.3.15
export GRADLE_TEST_MAX_FORKS=true
export GRADLE_TEST_FORK=true
alias create-configs="pushd $CODE_DIR/deployer; ./gradlew -Dtargets=admin,2gP -Denvironments=anthony local; popd"
alias delete-configs="rm -vf $HOME/.grails/admin-config.groovy $HOME/.grails/2gP-config.groovy"
alias stash-configs="mv -vf $HOME/.grails/admin-config.groovy $HOME/.grails/admin-config.groovy.stash; mv -vf $HOME/.grails/2gP-config.groovy $HOME/.grails/2gP-config.groovy.stash"
alias pop-configs="mv -vf $HOME/.grails/admin-config.groovy.stash $HOME/.grails/admin-config.groovy; mv -vf $HOME/.grails/2gP-config.groovy.stash $HOME/.grails/2gP-config.groovy"
alias idea='open -na "IntelliJ IDEA.app" --args "$@"'
sel() {
	# Run selenium tests
    if [ $# -eq 0 ]
    then # run with no args to see argument order
        echo "sel <tag> [<user> <restore> <headless> <debug>]"
        return 1
    fi
    user=${2:-aciccarello} # set default username
    restore=${3:-false}
    headless=${4:-true}
    debug=${5:-false}
    [[ $restore == "false" ]] && res="-xrestoredata" || res=""
    echo "./gradlew runCukes -Dheadless=$headless -Puser=$user -Pthreaded $res -DcleanFtpFiles=yes -DcleanEmails=yes -Ptags=$1 -Pdebug=$debug"
    (cd $CODE_DIR/selenium3 && ./gradlew runCukes -Dheadless=$headless -Puser=$user -Pthreaded $res -DcleanFtpFiles=yes -DcleanEmails=yes -Ptags=$1 -Pdebug=$debug)
	print -f '\a' # for noise
}

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

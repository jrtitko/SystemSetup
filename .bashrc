PATH=$PATH:/usr/bin/env:.

export CATALINA_HOME=/Users/jrtitko1/Tomcat/apache-tomcat-8.0.21
export JAVA_HOME=$(/usr/libexec/java_home)

export GITAWAREPROMPT=~/.bash/git-aware-prompt
source $GITAWAREPROMPT/main.sh

export EDITOR='subl -w'
alias edit="subl"

# Secure Data
if [ -f ~/.bashrc_secure ]; then
  source ~/.bashrc_secure
fi

# Prompt Manipulation
export PS1="🐼 \W \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "
export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "

# Shell
alias refresh=". ~/.bashrc"
alias subl="/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl"
alias lsa='ls -alF'
alias lst='ls -altF'
alias grep='grep --color'
alias repo='cd ~/.m2/repository'
alias mkdir='mkdir -p'
alias dup="open -n -a" # Used for opening second application of same type
alias eclipse="dup /Applications/eclipse/Eclipse.app"
alias t="tail -f -n 1000"
alias gfind="find . | grep"
alias rmd="rm -rf"
function cpt { cp "$1" ~/temp/; }
export -f cpt
alias r="cd `pwd`"
alias time="date"
alias p="ps -eah -o user,pid,ppid,%cpu,%mem,start=STIME,time=CPU-TIME,command"
function bg { nohup "$1" &>/dev/null & }
export -f bg

alias pc='~/workspaces/dev-tools/processCommand.sh'


# Java
alias unjar="jar xvf"
alias viewjar="jar tvf"
alias vj="viewjar"
function jfind { viewjar "$1" | gfind "$2"; }
export -f jfind

# Maven
alias mrun='mvn spring-boot:run'
alias mci='mvn clean install'
alias mcis="mvn clean install -DskipTests"
alias m2="cd ~/.m2/"
alias mtree="mvn dependency:tree" # may want to add '> tree.txt'

# Tomcat
alias tomcat="/Users/jrtitko1/Tomcat/apache-tomcat-8.0.21/"
alias tomcatstart="/Users/jrtitko1/Tomcat/apache-tomcat-8.0.21/bin/catalina.sh run &"

# Jenkins
jenkinsstart="sudo launchctl load /Library/LaunchDaemons/org.jenkins-ci.plist"
jenkinsstop="sudo launchctl unload /Library/LaunchDaemons/org.jenkins-ci.plist"

# Git commands - move to git eventually
alias log="git log --oneline --decorate"
alias lg="git log --oneline --decorate --graph --all"
alias bd="git branch -d"
alias branch="git checkout -b"
alias branches="git branch -a"

#GitHub
#export HOMEBREW_GITHUB_API_TOKEN= # found in .bashrc_secure

# Docker
alias dm="docker-machine"
alias dmstart="docker-machine start default"
alias dmdefault='eval "$(docker-machine env default)"'
alias confluence='eval "$(docker-machine env default)" && docker start 28db4245e5dc && echo "" && echo "confluence => http://$(dm ip default):8090" && echo "Active Docker-Machine: DEFAULT"'
#code mash
alias dmkata='eval "$(docker-machine env kata)" && echo "Active Docker-Machine: kata"'
alias dmplaycreate='docker-machine create --driver=virtualbox playground && dmplay'
alias dmplay='eval "$(docker-machine env playground)" && echo "Active Docker-Machine: PLAYGROUND"'


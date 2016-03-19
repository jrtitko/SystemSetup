PATH=$PATH:/usr/bin/env:.

export CATALINA_HOME=/Users/jrtitko1/Tomcat/apache-tomcat-8.0.21
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_40.jdk/Contents/Home

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
alias pc='~/workspaces/dev-tools/processCommand.sh'
alias mkdir='mkdir -p'
alias dup="open -n -a" # Used for opening second application of same type
alias eclipse="dup /Applications/eclipse/Eclipse.app"
alias t="tail -f -n 1000"

# Java
alias unjar="jar xvf"
alias viewjar="jar tvf"

# Maven
alias mrun='mvn spring-boot:run'
alias mci='mvn clean install'

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


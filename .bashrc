PATH=$PATH:/usr/bin/env:$GOPATH/bin:.

export CATALINA_HOME=/Users/jrtitko1/Tomcat/apache-tomcat-8.0.21
export JAVA_HOME=$(/usr/libexec/java_home)

# GO (the language) to store GO directories
export GOPATH="$HOME/workspaces/CodeMash2017/7lang/7-languages/go"

# Use below path format for most install HOMEs
export GROOVY_HOME=/usr/local/opt/groovy/libexec
export GRADLE_HOME=/usr/local/opt/gradle/libexec
# Add $GROOVY_HOME/bin to PATH ???
# Add $GRADLE_HOME/bin to PATH ???

export GITAWAREPROMPT=~/.bash/git-aware-prompt
source $GITAWAREPROMPT/main.sh

#export EDITOR='subl -w'
alias edit="subl"

# Secure Data
if [ -f ~/.bashrc_secure ]; then
  source ~/.bashrc_secure
fi

# Prompt Manipulation
export PS1="🐼 \t \W \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "
export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "

# Shell
alias bashrc="edit ~/.bashrc"
alias tricks="edit ~/SystemSetup/MacTricks.txt"
alias refresh=". ~/.bashrc"
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias lsa='ls -alF'
alias lst='ls -altF'
alias grep='grep --color'
alias repo='cd ~/.m2/repository'
alias mkdir='mkdir -p'
function mkcd { mkdir "$1" && cd "$1"; }
export mkcd
alias dup="open -n -a" # Used for opening second application of same type
alias eclipse="dup /Applications/eclipse/jee-neon/Eclipse.app"
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
alias h="history"

alias pc='~/SystemSetup/processCommand.sh'

# Operating System
alias port='sudo lsof -i'
alias cls="clear; printf '\033[3J'"

# IntelliJ
function intelliJRemove { 
	rmd ~/Library/Caches/IntelliJIdea2016.2/frameworks/detection/$1.*;  
	rmd ~/Library/Caches/IntelliJIdea2016.2/conversion/$1*;  
	rmd ~/Library/Preferences/IntelliJIdea2016.2/tasks/$1.*;  
}
export -f intelliJRemove

# Wiki
alias wiki="cd ~/Development/technotes/wiki && docker run -d -p 4567:4567 -v `pwd`:/gollum gollum"

# Java
alias unjar="jar xvf"
alias viewjar="jar tvf"
alias vj="viewjar"
function jfind { viewjar "$1" | gfind "$2"; }
export -f jfind
alias jdk7="export JAVA_HOME=$(/usr/libexec/java_home -v 1.7)"
alias jdk8="export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)"
alias java7="jdk7 && java -version"
alias java8="jdk8 && java -version"

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
alias jenkinsstart="sudo launchctl load /Library/LaunchDaemons/org.jenkins-ci.plist"
alias jenkinsstop="sudo launchctl unload /Library/LaunchDaemons/org.jenkins-ci.plist"

# Git commands - move to git eventually
alias log="git log --oneline --decorate"
alias lg="git log --oneline --decorate --graph --all"
alias delete="git branch -d"
alias deleteRemote="git branch origin --delete"
alias branch="git checkout -b"
alias branches="git branch -a"
alias remote="git remote -v"

#GitHub
#export HOMEBREW_GITHUB_API_TOKEN= # found in .bashrc_secure

# Docker
alias confluence='docker start confluence && echo "***********************************" && echo "confluence => http://localhost:8090" && echo "***********************************"'
alias mongostart='docker start mongoDB && echo "Starting"'
#alias mongo='docker start mongoDB && docker exec -it mongoDB bash'
alias dps="docker ps"
alias dpsa="docker ps -a"
alias di="docker images"

# Groovy
alias groovyConsole="groovyConsole &"

# Gradle
alias gtasks="gradle tasks --all"
alias gcb="gradle clean build --console plain"
alias gcc="gradle clean check --console plain"
alias gbr="gradle bootRun"
alias gcbr='cls && gradle clean check build bootRun'
alias gw="./gradlew"

# Spring
alias springproject="spring init --build gradle --extract --groupId com.industriousgnomes --dependencies lombok,devtools"

#####################################################
# Project Specific ##################################
#####################################################

# Commodities Project
alias commodities="cd ~/Development/IndustriousGnomes/Commodities-2017"

#code mash
alias dmkata='eval "$(docker-machine env kata)" && echo "Active Docker-Machine: kata"'
alias dmplaycreate='docker-machine create --driver=virtualbox playground && dmplay'
alias dmplay='eval "$(docker-machine env playground)" && echo "Active Docker-Machine: PLAYGROUND"'

#Target Demo
alias myRetail='cd ~/workspaces/Target/myRetail/'
alias mongo='docker start myretail_mongodb_1 && docker exec -it myretail_mongodb_1 bash'
alias buildMyRetail='cd ~/workspaces/Target/myRetail && docker build -t jrtitko/myretail .'
alias stopMyRetail='docker stop myretail_myretail_1 myretail_mongodb_1'
alias startMyRetail='cd ~/workspaces/Target/myRetail && docker-compose up'

#Minikube - Kubernetes
#alias kubestart="minikube start --network-plugin=cni --container-runtime=rkt --iso-url=http://storage.googleapis.com/minikube/iso/buildroot/minikube-v0.0.6.iso"
alias kubestart="minikube start"
alias kubestop="minikube stop"
alias kubedel="minikube delete"
# alias kube="eval $(minikube docker-env)"      <== for some reason this is not working, fix later
alias kc="kubectl"
alias mk="minikube"


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/jrtitko1/.sdkman"
[[ -s "/Users/jrtitko1/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/jrtitko1/.sdkman/bin/sdkman-init.sh"

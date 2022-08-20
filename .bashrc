PATH=$PATH:/usr/bin/env:$GOPATH/bin:.

### Default Project ###
export PROJECT=Spike

WORKSPACE_HOME=~/workspace
DEVTOOLS_HOME=~/SystemSetup

export CATALINA_HOME=~/Tomcat/apache-tomcat-8.0.21
export JAVA_HOME=$(/usr/libexec/java_home)

# Use below path format for most install HOMEs
export GROOVY_HOME=/usr/local/opt/groovy/libexec
export GRADLE_HOME=/usr/local/opt/gradle/libexec

# Prompt Manipulation
export GITAWAREPROMPT=~/.bash/git-aware-prompt
source $GITAWAREPROMPT/main.sh
CURSOR_COLOR="\033[38;5;0m\033[48;5;190m"
BRANCH_COLOR="\033[38;5;190m\033[48;5;0m"
export PS1="🐼 \[${CURSOR_COLOR}\]\t \W \[${BRANCH_COLOR}\]\$git_branch\[${BRANCH_COLOR}\]\$git_dirty\[$txtrst\]\$ "
export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "

#export EDITOR='subl -w'
alias edit="subl"
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

# Scripts
alias refresh=". ~/.bashrc*"
alias bashrc="edit -n ~/.bashrc_project && edit ~/.bashrc_docker && edit ~/.bashrc" #reverse order
alias tricks="edit ~/SystemSetup/MacTricks.txt"
function cpt { cp "$1" ~/temp/; }
export -f cpt
alias r="cd `pwd`"
function bg { nohup "$1" &>/dev/null & }
export -f bg

# Operating System
alias cls="clear; printf '\033[3J'"
alias p="cls && ps -eah -o user,pid,ppid,%cpu,%mem,start=STIME,time=CPU-TIME,command"
alias time="date"
alias lsa='ls -alF'
alias lst='ls -altF'
alias lsb='ls -alF .bashrc*'
alias grep='grep --color'
alias mkdir='mkdir -p'
function mkcd { mkdir "$1" && cd "$1"; }
export mkcd
alias t="cls && tail -f -n 1000"
alias gfind="find . | grep"
alias rmd="rm -rf"
alias cpd="cp -rf"
alias disk="df -h"
alias space="ncdu"
alias sudu="echo 'sudo $(fc -ln -1)'"
alias hosts="edit /etc/hosts"
function port { 
    cls
    if [ $# == 1 ]; then
        lsof -i :$1;
    elif [[ $# == 0 ]]; then
        lsof -i
    else
        echo "Usage: port [<port-number>]"
    fi
}
export -f port
alias ports=port

# Locations
alias tools="cd $DEVTOOLS_HOME"
alias repo='cd ~/.m2/repository'
alias notes="edit ~/Development/Notes"
alias system="edit ~/SystemSetup"

# Wiki
alias wiki="cd ~/Development/technotes/wiki && docker run -d -p 4567:4567 -v `pwd`:/gollum gollum"

# Java
alias run="cls && java -jar"
alias unjar="cls && jar xvf"
alias viewjar="cls && jar tvf"
alias vj="cls && viewjar"
function jfind { viewjar "$1" | gfind "$2"; }
export -f jfind
alias jdk8="export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)"
alias jdk11="export JAVA_HOME=$(/usr/libexec/java_home -v 11)"
alias java8="jdk8 && java -version"
alias java11="jdk11 && java -version"
# ==> Pouring openjdk@11-11.0.8.catalina.bottle.tar.gz
# ==> Caveats
# For the system Java wrappers to find this JDK, symlink it with
#   sudo ln -sfn /usr/local/opt/openjdk@11/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-11.jdk
# openjdk@11 is keg-only, which means it was not symlinked into /usr/local, because this is an alternate version of another formula.
# If you need to have openjdk@11 first in your PATH run:
#   echo 'export PATH="/usr/local/opt/openjdk@11/bin:$PATH"' >> /Users/j.r.titko/.bash_profile
# For compilers to find openjdk@11 you may need to set:
#   export CPPFLAGS="-I/usr/local/opt/openjdk@11/include"

# ProcessCommand
alias pc='$DEVTOOLS_HOME/processCommand.sh'
alias processCommand='edit $DEVTOOLS_HOME/processCommand.sh'
alias processCommands='processCommand'
alias test='pc -jlw $PROJECT gradle clean check'

# Code Repositories - Maven/Ivy
alias mrun='mvn spring-boot:run'
alias mci='mvn clean install'
alias mcis="mvn clean install -DskipTests"
alias m2="cd ~/.m2/"
alias mtree="mvn dependency:tree" # may want to add '> tree.txt'
alias ivy="cd ~/.ivy2/"

# Tomcat
alias tomcat="~/Tomcat/apache-tomcat-8.0.21/"
alias tomcatstart="~/Tomcat/apache-tomcat-8.0.21/bin/catalina.sh run &"

# Jenkins
alias jenkinsstart="sudo launchctl load /Library/LaunchDaemons/org.jenkins-ci.plist"
alias jenkinsstop="sudo launchctl unload /Library/LaunchDaemons/org.jenkins-ci.plist"

# Git commands - move to git eventually
alias log="git log --oneline --decorate"
alias lg="cls && git log --oneline --decorate --graph --all"
alias delete="git branch -d"
alias deleteRemote="git branch origin --delete"
alias branch="git checkout -b"
alias branches="git branch -a"
alias remote="git remote -v"
alias up='git checkout $(git rev-list --topo-order HEAD.."master" | tail -1)'
alias next='git checkout $(git rev-list --topo-order HEAD.."solution" | tail -1) && lg'
alias prev='git checkout HEAD~ && lg' 
alias ntest='git checkout $(git rev-list --topo-order HEAD.."solution" | tail -1)'
alias gitignore='edit ~/.gitignore_global'
alias fetch='cls && pc -w $PROJECT git fetch'
alias master='cls && pc -w $PROJECT git checkout master'
alias prune='cls && pc -sw $PROJECT git pruneremote'
alias st='cls && pc -sw $PROJECT git st'
alias update='cls && pc -jlw $PROJECT git checkout master && pc -jlxw $PROJECT git pull && pc -jlw $PROJECT git checkout -'
alias build='cls && pc -jlw $PROJECT git checkout master && pc -jlw $PROJECT gcbx -x test && pc -jlw $PROJECT git checkout -'

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
alias gw="./gradlew"
alias gtasks="cls && gw                 tasks --all"
alias gcb="cls    && gw --console=plain clean build --no-build-cache"
alias gcbit="cls  && gw --console=plain clean build -x integrationTest"
alias gcbt="cls   && gw --console=plain clean build -x test"
alias gcc="cls    && gw --console=plain clean check"
alias gbr="cls    && gw --console=plain bootRun"
alias gcbr='cls   && gw --console=plain clean check build bootRun'
alias gcbf='cls   && gw --console=plain clean check build fatjar'
alias dependencies='cls && gw  --console=plain dependencies'
alias gpl='cls    && gw --console=plain publishToMavenLocal'
alias gcbl='cls   && gw  --console=plain clean build publishToMavenLocal'
# Requires .gradle/init.gradle setup: See https://github.com/dorongold/gradle-task-tree
alias tasktree="cls && gw taskTree"
alias tasks="cls && gw taskTree"
# For use in other scripts
alias gcbx='gw clean build --continue'


# Spring
alias springproject="spring init --build gradle --extract --groupId com.industriousgnomes --dependencies lombok,devtools && git init"
alias gradleproject="gradle init --type java-application --dsl groovy --test-framework spock && gradle wrapper && git init"

# Sample of what a function can do
function history_search() {
    if [ $# > 0 ]; then
        history | grep "$*"
    else
        history
    fi
}
export -f history_search
alias h=history_search

# Display the color pallet available for terminal windows
function colorPallet {
    T='gYw'   # The test text
 
    echo "Color pallet for 16-colors"
    echo -e "                 40m     41m     42m     43m     44m     45m     46m     47m";
     
    for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
               '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
               '  36m' '1;36m' '  37m' '1;37m';
      do FG=${FGs// /}
      echo -en " $FGs \033[$FG  $T  "
      for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
        do echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m";
      done
      echo;
    done
    echo
    echo "Color pallet for 256-colors backgrounds"
    for i in {0..256}; do echo -en "\033[48;5;${i}m $i \033[0m"; done ; echo
    echo
    echo "Color pallet for 256-colors foreground"
#    BACKGROUND_COLOR="\033[0m"         # default
    BACKGROUND_COLOR="\033[48;5;190m"      # yellow
    for i in {0..256}; do echo -en "${BACKGROUND_COLOR}\033[38;5;${i}m $i \033[0m"; done ; echo
    echo
    echo "If colors are not what you expected, you can change the color pallet of the terminal window"
    echo
}
export -f colorPallet
 
function showCommand {  
  showCommand_command="$@"

  showMessage "$showCommand_command"

  eval $showCommand_command
}

function showMessage {  
  COLOR_SHOW_MESSAGE_HILIGHT="\033[97m\033[40m"
  COLOR_RESET="\033[0m"

  showMessage_command="$@"
  echo "*************************************************"
  echo -e "${COLOR_SHOW_MESSAGE_HILIGHT}$showMessage_command${COLOR_RESET}"
  echo "*************************************************"
}

function confirmCommand {
  show message "$@"

  COLOR_CONFIRM_HILIGHT="\033[48;5;197m\033[38;5;230m"
  COLOR_RESET="\033[0m"
  echo -en "${COLOR_CONFIRM_HILIGHT}Press 'Y' to continue:${COLOR_RESET}"

  read -p ": " -e -n 1 answer
  if [[ $answer == y || $answer == Y ]]; then
    eval $command
  else
    echo "abort"
  fi
}

function pullAllRepos {
# Setup:
#   brew update
#   brew install jq
  pullAllRepos_org=${1:-$PROJECT}
  pullAllRepos_login=${2:-$USER_ID}
  pullAllRepos_password=${3:-$TARGET_GITHUB_API_TOKEN}
#  pullAllRepos_url="https://git.target.com/api/v3/users/$user/repos?per_page=1000"
  pullAllRepos_url="https://git.target.com/api/v3/orgs/$pullAllRepos_org/repos?per_page=1000"

  showMessage "curl $pullAllRepos_url | jq '.[] | .ssh_url'"

  pullAllRepos_my_array=( $( curl -u $pullAllRepos_login:$pullAllRepos_password $pullAllRepos_url | jq '.[] | .ssh_url' ) )
  for pullAllRepos_repo in ${pullAllRepos_my_array[*]}
  do
    showCommand git clone $pullAllRepos_repo
  done
}
export -f pullAllRepos
alias pullRepos='pullAllRepos'

# Experiment
function testit { echo "Hello ${1:-there}"; }
export -f testit

# Maybe get rid of these
# GO (the language) to store GO directories
export GOPATH="$HOME/workspaces/CodeMash2017/7lang/7-languages/go"



# Sourcing other files last so that they can use the aliases defined above
# Secure Data
if [ -f ~/.bashrc_secure ]; then
  source ~/.bashrc_secure
fi
alias secure="edit ~/.bashrc_secure"

# Docker
if [ -f ~/.bashrc_docker ]; then
    source ~/.bashrc_docker
fi
alias bashrc_docker="edit ~/.bashrc_docker"

# Kafka
if [ -f ~/.bashrc_kafka ]; then
    source ~/.bashrc_kafka
fi
alias bashrc_kafka="edit ~/.bashrc_kafka"

# Project Specific Commands
if [ -f ~/.bashrc_project ]; then
    source ~/.bashrc_project
fi
alias bashrc_project="edit ~/.bashrc_project"

# Project Specific Commands
if [ -f ~/.bashrc_games ]; then
    source ~/.bashrc_games
fi
alias bashrc_games="edit ~/.bashrc_games"

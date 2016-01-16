#!/bin/bash

source ~/.bashrc

originalDir=`pwd`
cd ~/workspaces

command="$1"
shift
args="$@"
if alias "$command" >/dev/null 2>&1; then
  command=$(alias $command | sed "s/alias .*='\(.*\)'$/\1/")
fi

directories=("Spike/HelloWorld" "dev-tools")

hiliteFont="\033[1;97m\033[40m"
resetColor="\033[0m"

for dir in "${directories[@]}"
do
  cd ${dir}
  currentDir=`pwd`
  echo -e "${hiliteFont}${currentDir}${resetColor}"

  $command $args

  if [ $? -eq 1 ]; then
    echo "Exiting due to error"
    break
  fi

  cd ~/workspaces
done

cd ${originalDir}

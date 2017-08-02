#!/bin/bash
WHITE_ON_BLACK="\033[1;97m\033[40m"
BLACK_ON_CYAN="\033[1;30m\033[106m"
COLOR_RESET="\033[0m"
WARNING="\033[1;30m\033[105m"

source ~/.bashrc

originalDir=`pwd`
cd ~/workspaces   # used for relative pathing on projects, should be set to common workspace location

dirCommodities=(  # full paths required.  ~ doesnt work as 'home'
  "/Users/jrtitko1/Development/IndustriousGnomes/Commodities-2017/FrontEnd"
  "/Users/jrtitko1/Development/IndustriousGnomes/Commodities-2017/ServerSide"
  "/Users/jrtitko1/Development/IndustriousGnomes/Commodities-2017/DataStore"
  "/Users/jrtitko1/Development/IndustriousGnomes/Commodities-2017/Documents"
)

OPTIND=1
while getopts ":d:chx" opt; do
  case $opt in
    d)  directories=($directories $OPTARG)
        ;;
    c)  directories=($directories ${dirCommodities[@]})
        ;;
    h)  echo "-d <directories>  - list of directories to process"
        echo "-c                - predefined list of Commodities-2017 directories"
        exit 1
        ;;
    \?) echo "Invalid option -$OPTARG"
        exit 1
        ;;
    :)  echo "Option -$OPTARG requires an argument"
        exit 1
        ;;
  esac
done
shift $((OPTIND-1))

if [ -z ${directories+x} ]; then
  directories=(${dirCommodities[@]})  # list of default directories (Commodities-2017 at the moment)
fi

command="$1"
shift

args="$@"

echo -e "${BLACK_ON_CYAN}directories=${directories[@]}${COLOR_RESET}"
echo -e "${BLACK_ON_CYAN}command=$command${COLOR_RESET}"
echo -e "${BLACK_ON_CYAN}args=$args${COLOR_RESET}"

if alias "$command" >/dev/null 2>&1; then
  command=$(alias $command | sed "s/alias .*='\(.*\)'$/\1/")
fi

for dir in "${directories[@]}"
do
  cd ${dir}
  currentDir=`pwd`
  echo -e "${WHITE_ON_BLACK}${currentDir}${COLOR_RESET}"

  $command $args

  if [ $? -eq 1 ]; then
    echo -e "${WARNING}Aborting due to error${COLOR_RESET}"
    break
  fi

  cd ~/workspaces
done

cd ${originalDir}

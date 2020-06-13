#!/bin/bash
WHITE_ON_BLACK="\033[97m\033[40m"
BLACK_ON_CYAN="\033[30m\033[46m"
WHITE_ON_BLUE="\033[37m\033[44m"
COLOR_RESET="\033[0m"
WARNING="\033[1;30m\033[105m"

source ~/.bashrc

originalDir=`pwd`
cd ~/workspace

# project root within ~/workspace
workspace=$PROJECT

processDirectories=false
directoriesToProcess=""
processJava=false
processDocuments=false
processHelp=false

OPTIND=1
while getopts ":d:w:jnlxh" opt; do
  case $opt in
    d) processDirectories=true
       directoriesToProcess=$OPTARG
       ;;
    j) processJava=true
       ;;
    # n) directories=(${directories[@]} ${dirNpm[@]})
    #    ;;
    # l) directories=(${directories[@]} ${dirLib[@]})
    #    ;;
    w) workspace=$OPTARG
       ;;
    x) processDocuments=true
       ;;
    h|\?) processHelp=true
       ;;
    :) echo "Option -$OPTARG requires an argument"
        exit 1
       ;;
  esac
done
shift $((OPTIND-1))

echo -e "${WHITE_ON_BLUE} Workspace: $workspace ${COLOR_RESET}"

command="$1"
shift

[ -z $command ] && processHelp=true;

args="$@"

if $processHelp; then
       echo "************************************************************"
       echo "Usage: processCommand <dir-in-workspace> <options | -h>"
       echo "-w <workspace>     - workspace to process over. [default=$workspace]"
       echo "-d <directories>   - list of directories to work on"
       echo "-j                 - predefined list of java directories"
#       echo "-n                 - predefined list of npm directories"
#       echo "-l                 - predefined list of lib directories"
       echo "-x                 - predefined list of document directories"
       echo "************************************************************"
       exit 1
fi

dirJava=()
for FILE in ./$workspace/*; do
    if [[ -d $FILE ]] && [[ -d "$FILE/.git" ]] && [[ -d "$FILE/src" ]]; then 
        dirJava+=("$FILE")
    fi
done

dirNpm=()

dirLib=(
       )

dirDoc=()
for FILE in ./$workspace/*; do
    if [[ -d $FILE ]] && [[ -d "$FILE/.git" ]] && [[ ! -d "$FILE/src" ]]; then 
        dirDoc+=("$FILE")
    fi
done

$processDirectories && directories=(${directories[@]} $directoriesToProcess)

$processJava && directories=(${directories[@]} ${dirJava[@]})

$processDocuments && directories=(${directories[@]} ${dirDoc[@]})

[ -z ${directories+x} ] && directories=(${dirJava[@]} ${dirNpm[@]} ${dirLib[@]} ${dirDoc[@]})

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

  echo "**************"
  echo "$command $args"
  echo "**************"
  $command $args

  if [ $? -eq 1 ]; then
    echo -e "${WARNING}Aborting due to error${COLOR_RESET}"
#    break
  fi

  cd ~/workspace
done

cd ${originalDir}
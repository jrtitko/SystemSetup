#!/bin/bash
#set -x
​
WHITE_ON_BLACK="\033[97m\033[40m"
BLACK_ON_GREY="\033[30m\033[47m"
WHITE_ON_BLUE="\033[37m\033[44m"
COLOR_RESET="\033[0m"
WARNING="\033[1;37m\033[105m"
​
source ~/.bashrc
​
processCommand_originalDir=`pwd`
cd ~/workspace
​
processCommand_workspace=$PROJECT
​
processCommand_processDirectories=false
processCommand_directoriesToProcess=""
processCommand_processJava=false
processCommand_processLibs=false
processCommand_processDocuments=false
processCommand_processHelp=false
processCommand_processSkips=false
processCommand_processTags=false
processCommand_processTag=""
​
OPTIND=1
while getopts ":d:w:t:jnlxsh" opt; do
  case $opt in
    d) processCommand_processDirectories=true
       processCommand_directoriesToProcess=$OPTARG
       ;;
    t) processCommand_processTags=true
       processCommand_processTag=$OPTARG
       ;;
    j) processCommand_processJava=true
       ;;
    l) processCommand_processLibs=true
      ;;
    w) processCommand_workspace=$OPTARG
       ;;
    x) processCommand_processDocuments=true
       ;;
    s) processCommand_processSkips=true
       ;;
    h|\?) processCommand_processHelp=true
       ;;
    :) echo "Option -$OPTARG requires an argument"
        exit 1
       ;;
  esac
done
shift $((OPTIND-1))
​
echo -e "${WHITE_ON_BLUE} processCommand_workspace: $processCommand_workspace ${COLOR_RESET}"
​
processCommand_command="$1"
shift
​
[ -z $processCommand_command ] && processCommand_processHelp=true;
​
args="$@"
​
if $processCommand_processHelp; then
       echo "************************************************************"
       echo "Usage: processCommand <dir-in-workspace> <options | -h>"
       echo "-w <workspace>     - workspace to process over. [default=$processCommand_workspace]"
       echo "-d <directories>   - list of directories to work on"
       echo "-j                 - process all non-library java directories"
       echo "-l                 - process all library directories"
       echo "-x                 - process all document directories"
       echo "-s                 - include directories marked with SKIP.md"
       echo "-t <tag>           - process only directories with the TAG.md"
       echo "************************************************************"
       exit 1
fi
​
processCommand_dirJava=()
processCommand_dirLib=()
processCommand_dirDoc=()
for FILE in ./$processCommand_workspace/*; do
    ! $processCommand_processSkips && if [[ -f "$FILE/SKIP.md" ]]; then
      continue
    fi
​
    if [[ -f "$FILE/DO_NOT_PROCESS.md" ]]; then
      continue
    fi
​
    $processCommand_processTags && if [[ ! -f "$FILE/$processCommand_processTag.md" ]]; then
      continue
    fi
​
    if [[ -d $FILE ]] && [[ -d "$FILE/.git" ]] && [[ -d "$FILE/src" ]] && [[ ! -f "$FILE/LIBRARY.md" ]]; then 
        processCommand_dirJava+=("$FILE")
    fi
​
    if [[ -d $FILE ]] && [[ -d "$FILE/.git" ]] && [[ -d "$FILE/src" ]] && [[ -f "$FILE/LIBRARY.md" ]]; then 
        processCommand_dirLib+=("$FILE")
    fi
​
    if [[ -d $FILE ]] && [[ -d "$FILE/.git" ]] && [[ ! -d "$FILE/src" ]]; then 
        processCommand_dirDoc+=("$FILE")
    fi
done
​
$processCommand_processDirectories && directories=(${directories[@]} $processCommand_directoriesToProcess)
​
$processCommand_processJava && directories=(${directories[@]} ${processCommand_dirJava[@]})
​
$processCommand_processLibs && directories=(${directories[@]} ${processCommand_dirLib[@]})
​
$processCommand_processDocuments && directories=(${directories[@]} ${processCommand_dirDoc[@]})
​
[ -z ${directories+x} ] && directories=(${processCommand_dirJava[@]} ${processCommand_dirLib[@]} ${processCommand_dirDoc[@]})
​
echo -e "${BLACK_ON_GREY}directories=${directories[@]}${COLOR_RESET}"
echo -e "${BLACK_ON_GREY}processCommand_command=$processCommand_command${COLOR_RESET}"
echo -e "${BLACK_ON_GREY}args=$args${COLOR_RESET}"
​
if alias "$processCommand_command" >/dev/null 2>&1; then
  processCommand_command=$(alias $processCommand_command | sed "s/alias .*='\(.*\)'$/\1/")
fi
​
for dir in "${directories[@]}"
do
  cd ${dir}
  processCommand_currentDir=`pwd`
  echo -e "${WHITE_ON_BLACK}${processCommand_currentDir}${COLOR_RESET}"
​
  echo "**************"
  echo "$processCommand_command $args"
  echo "**************"
  $processCommand_command $args
​
  if [ $? -eq 1 ]; then
    echo -e "${WARNING}Aborting due to error${COLOR_RESET}"
#    break
  fi
​
  cd ~/processCommand_workspace
done
​
cd ${processCommand_originalDir}
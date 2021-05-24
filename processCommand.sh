#!/bin/bash
<<<<<<< HEAD
#set -x
​
WHITE_ON_BLACK="\033[97m\033[40m"
BLACK_ON_GREY="\033[30m\033[47m"
=======
WHITE_ON_BLACK="\033[97m\033[40m"
BLACK_ON_CYAN="\033[30m\033[46m"
>>>>>>> 2d97d7dfa491dc71ab6964aef06749f3d6918623
WHITE_ON_BLUE="\033[37m\033[44m"
COLOR_RESET="\033[0m"
WARNING="\033[1;37m\033[105m"
​
source ~/.bashrc
<<<<<<< HEAD
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
=======

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
>>>>>>> 2d97d7dfa491dc71ab6964aef06749f3d6918623
       ;;
    :) echo "Option -$OPTARG requires an argument"
        exit 1
       ;;
  esac
done
shift $((OPTIND-1))
<<<<<<< HEAD
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
=======

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
>>>>>>> 2d97d7dfa491dc71ab6964aef06749f3d6918623
fi
​
for dir in "${directories[@]}"
do
  cd ${dir}
<<<<<<< HEAD
  processCommand_currentDir=`pwd`
  echo -e "${WHITE_ON_BLACK}${processCommand_currentDir}${COLOR_RESET}"
​
  echo "**************"
  echo "$processCommand_command $args"
  echo "**************"
  $processCommand_command $args
​
=======
  currentDir=`pwd`
  echo -e "${WHITE_ON_BLACK}${currentDir}${COLOR_RESET}"

  echo "**************"
  echo "$command $args"
  echo "**************"
  $command $args

>>>>>>> 2d97d7dfa491dc71ab6964aef06749f3d6918623
  if [ $? -eq 1 ]; then
    echo -e "${WARNING}Aborting due to error${COLOR_RESET}"
#    break
  fi
<<<<<<< HEAD
​
  cd ~/processCommand_workspace
done
​
cd ${processCommand_originalDir}
=======

  cd ~/workspace
done

cd ${originalDir}
>>>>>>> 2d97d7dfa491dc71ab6964aef06749f3d6918623

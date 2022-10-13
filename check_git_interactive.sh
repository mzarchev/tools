#! /bin/bash

chmod u+x check_git.sh

# Colors for output
RED='\033[0;31m'
Green='\033[0;32m'
BCyan='\033[1;36m'
NC='\033[0m' # No color

printf "Let's check if there are are any ${BCyan}uncommited files${NC} in your projects\n"

# Select a project folder to check
project_selection(){
cd "V:/iBerry Study Onderzoek/Data uitgifte/Milan Zarchev/R projects"

printf "\nPlease select folder to check:\n\n"

# Print options on a single line
COLUMNS=12
# Select folder
select d in */; do test -n "$d" && break; echo ">>> Invalid selection"; done

# Change directory to selected folder
cd $d

}

# Check for uncommitted changes
check_uncommit(){
# Get names of modified files in directory if any
modified_files=$(git status --porcelain | grep "M" | paste | sed -e "s/ M/\n/")

if [ -z $modified_files ] ; then modified_files="\n${Green}None!${NC}" ; fi

printf "\nUncommited files in ${RED}$d${NC} \n ${BCyan}$modified_files${NC} \n"
}

# Ask for input for checking another project
ask_another(){
printf "\nWould you like to check another project? [y/n]:"
read choice_another
}

while :
do
  project_selection
  check_uncommit
  ask_another
  if [ $choice_another != "y" ] ; then break; fi
done

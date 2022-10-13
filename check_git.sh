#! /bin/bash

chmod u+x check_git.sh

# Colors for output
RED='\033[0;31m'
Green='\033[0;32m'
BCyan='\033[1;36m'
NC='\033[0m' # No color

printf "Let's check if there are are any ${BCyan}uncommited files${NC} in your projects\n"

cd "V:/iBerry Study Onderzoek/Data uitgifte/Milan Zarchev/R projects"


# Check for uncommitted changes
check_uncommit(){
# Get names of modified files in directory if any
modified_files=$(git status --porcelain | grep "M" | paste | sed -e "s/ M/\n/")

if [ -z "$modified_files" ] ; then modified_files="\n${Green}None!${NC}" ; fi

printf "\nUncommited files in ${RED}$d${NC} \n ${BCyan}$modified_files${NC} \n" >> ../projects_status
}

for d in */
do
 (cd "$d" && check_uncommit)
done

cat projects_status

rm projects_status

$SHELL

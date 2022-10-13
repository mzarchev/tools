
#! bin/bash

### Colors!
Red='\033[0;31m'
Green='\033[0;32m'
BCyan='\033[1;36m'
NC='\033[0m' # No color

### Directories

# Directory for starting point
dir_start="$PWD"

# Directory for inwerkmaps
dir_inwerkmap="V:\iBerry Study Onderzoek\Studenten\Inwerken studenten\Inwerkmap\2022"

# Directory with all CVs
dir_cv="/V/iBerry Study Onderzoek/Studenten/Aanmelden nieuwe studenten/2022"

# Directories for authorization forms
dir_base="V:\iBerry Study Onderzoek\METC\Study Master File - 1. Baseline\Autorisatieformulieren"
dir_t1="V:\iBerry Study Onderzoek\METC\Study Master File - 2.0\Autorisatieformulieren"
dir_t2="V:\iBerry Study Onderzoek\METC\Study Master File - 3.0\Autorisatieformulieren"

### Overview

printf "\nOpen up the ${BCyan}excel overview sheet${NC}? (go to the second overzicht beschikbaarheid sheet)? [y/n]:"
read overview_response

[ $overview_response == "y" ] &&
 start excel.exe "V:\iBerry Study Onderzoek\Studenten\Overzicht onderzoekstagiaires.xlsx"

printf "\nEnter ${BCyan}name of new student${NC}: "
read student_name

### Inwerkmap

printf "\nDo you want to open ${BCyan}the inwerkmap folder${NC} and choose a file to print? [y/n]:"
read inwerkmap_response

COLUMNS=12

[ $inwerkmap_response == "y" ] &&
cd "$dir_inwerkmap" &&
# Ask which file to open
select f in *; do test -n "$f" && break; echo ">>> Invalid selection"; done &&
start winword.exe "$f" &&
cd "$dir_start"

COLUMNS=80

### CVs

# Go to CV folder of student name
dir_cv_name='/'$student_name
# Find any files that have CV or [r]esum[e] in the folder
dir_cv_file=$(find "$dir_cv$dir_cv_name" \( -name "*CV**.pdf*" -o -name "*esum**.pdf*" \)) 2>/dev/null # Find a file that has CV and .pdf in the name
# Remove the directory and only save the filename
cv_file=$(basename "$dir_cv_file") 2>/dev/null

printf "\nDo you want to open ${BCyan}the student CVs${NC}? [y/n]:"
read cv_response

# Open the CV if available
[ $cv_response == "y" ] &&
cd "$dir_cv$dir_cv_name" &&
explorer "$cv_file" &&
cd "$dir_start" 

# Open explorer just in case
printf "\nIf that didn't work, do you want to open ${BCyan}the student CV folder${NC}? [y/n]:"
read cv_folder_response

[ $cv_folder_response == "y" ] &&
explorer "V:\iBerry Study Onderzoek\Studenten\Aanmelden nieuwe studenten\2022"

### Authorization forms

# Rename and move authorization files

printf "\nCreate ${BCyan}authorization forms${NC} with student name in baseline, T1 and T2 METC folders? [y/n]:"
read auth_create_response

[ $auth_create_response == "y" ] &&
# Temporarily copy files to working directory to manipulate (probably can do without but don't know how)
cp "$dir_base\Format\Authorization Form Baseline Format (only data use).docx" "$dir_start" &&
cp "$dir_t1\Format\Authorization form T1.docx" "$dir_start" &&
cp "$dir_t2\Format\Authorization Form T2_Student v2.docx" "$dir_start" &&
# Rename files (throws some harmless errors)
for i in *.docx
do
    mv "$i" "${i/Baseline Format (only data use)/$student_name baseline}" 2>/dev/null
    mv "$i" "${i/T1/$student_name T1}" 2>/dev/null
    mv "$i" "${i/T2_Student v2/$student_name T2}" 2>/dev/null
done

# Copy to respective folders
[ $auth_create_response == "y" ] &&
mv *baseline.docx "$dir_base" &&
mv *T1.docx "$dir_t1" &&
mv *T2.docx "$dir_t2" &&
printf "\n${Green}Word files created in baseline, T1 and T2 authorization folder${NC}\n"

# Open authorization file
printf  "\nOpen all ${BCyan}authorization form${NC} files for editting in Word? [y/n]"
read auth_open_response

[ $auth_open_response == "y" ] &&
start winword.exe "$dir_base\Authorization form $student_name baseline.docx" &&
start winword.exe "$dir_t1\Authorization form $student_name T1.docx" &&
start winword.exe "$dir_t2\Authorization form $student_name T2.docx"

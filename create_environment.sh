#!/bin/bash
while true; do
    read -p "Enter a name: " name
    word_count=$(echo "$name" | wc -w )
    if [ -z "$name" ]; then
	    echo " Directory name cannot be empty. enter 1 name"
	    continue
    elif [ "$word_count" -ne 1 ]; then
	    echo " Please enter only one name "
	    continue
    elif [ -d "submission_reminder_$name" ];then
	echo "Directory with the same name already exists"	
	
    else
    	break	    
    fi
done
#create respective directories
if [ ! -d "submission_reminder_$name" ];then	
	mkdir -p submission_reminder_$name
	cd submission_reminder_$name	
	mkdir -p app && cd app/ && touch reminder.sh 
	cd ..
	
	mkdir -p modules && cd modules/ && touch functions.sh
   	cd ..
   	
	mkdir -p assets && cd assets/ && touch submissions.txt
        cd ..
	
	mkdir -p config && cd config/ && touch config.env
        cd ..
	
	touch startup.sh
	
fi	
echo "Directory submission_reminder_$name created and its subdirectories"
echo "To run this reminder app, cd  submission_reminder_$name then ./startup.sh"

#add execution rights to all scripts and cat the content of each file in its respective place
chmod +x app/reminder.sh
cat <<BOF >> app/reminder.sh
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
BOF
#same here with reminder script content
chmod +x modules/functions.sh
cat <<BOF >> modules/functions.sh
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
BOF

#cat submissioon.txtx content and append more students at the end of the file
cat <<BOF >> assets/submissions.txt
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
BOF
cat <<EOF >> assets/submissions.txt
Kevine, Shell permissions , submitted
Esther, Shell Scripting , not submitted
Kwizera, Alu project , not submitted
Alex , Git , Submitted
Nana , Shell variables , submitted
Shakilla , Python Quiz , not submitted
Morris , SLTD assignment , not submitted
Icyeza, Mission video , submitted
EOF
#add read and write permissions to config.env because we will need to edit it later
chmod 755 config/config.env
cat <<BOF > config/config.env
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
BOF
#create startup script and give it execution permissions
chmod +x startup.sh
cat <<'BOF' > startup.sh
#!/bin/bash
source ./config/config.env
#it will read all contents in submission file from the tile downwards and their respective columns
tail -n +2 "./assets/submissions.txt" | while IFS=',' read -r student assignment status
do
  student=$(echo "$student" | xargs)
    assignment=$(echo "$assignment" | tr '[:upper:]' '[:lower:]' | xargs | sed 's/^"\(.*\)"$/\1/')
    status=$(echo "$status" | tr '[:upper:]' '[:lower:]' | xargs)
#added tr '[:upper:]' '[:lower:]' | xargs to make it case insensitive of what the user will write   

    # Check submission status
    if [[ "$status" == "not submitted" && "$assignment" == "$(echo "$ASSIGNMENT" | tr '[:upper:]' '[:lower:]')" ]]; then
        echo "..............Reminder.............
      $student, you have a pending '$assignment' assignment !"
    elif [[ "$status" == "submitted" && "$assignment" == "$(echo "$ASSIGNMENT" | tr '[:upper:]' '[:lower:]')" ]]; then
       echo "'$assignment' assignment has no pending submissions"
       echo "'$student' already submitted"
       echo "..................................."
  fi
done
BOF

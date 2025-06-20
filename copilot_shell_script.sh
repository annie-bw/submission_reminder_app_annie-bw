#!/bin/bash
#ask the user about the assignment they want to update
directory=$(find . -type d -name "submission_reminder_*" | tail -n 1 )
submission_file=${directory}/assets/submissions.txt
#define a variable that will check the latest submission_reminder_ file
config_file=${directory}/config/config.env
while true; do
    read -p "Enter the assignment name: " input
    #make input case insensitive and it should be matching an assignment in submission__file
    input=$(echo "$input" | tr '[:upper:]' '[:lower:]')
    if [ -z "$input" ]; then
        echo "Assignment name cannot be empty. Please try again."
    fi
    if cut -d',' -f2 "$submission_file" | tr '[:upper:]' '[:lower:]' | sed 's/^ *//; s/ *$//' | grep -Fxq "$input"; then

	echo "'$input' assignment found in '$submission_file'"
        break
    else
        echo "Entered a wrong assignment name, try again"
    fi
done

#change assignment to input in config file
sed -i "s/^ASSIGNMENT=\".*\"/ASSIGNMENT=\"$input\"/" "$config_file"
echo "Changed assignement name to \"$input\" in $config_file"
echo ".........✅ HELP✅..................
1.cat ${directory}/config/config.env file to see updated assignment
2.cd ${directory} 
3.then ./startup.sh to get reminders of the updated assignment"

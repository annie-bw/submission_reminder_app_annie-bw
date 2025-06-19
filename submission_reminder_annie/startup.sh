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

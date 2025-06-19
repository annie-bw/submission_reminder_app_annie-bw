📌 Submission Reminder App
Welcome to the Submission Reminder App!

🔧 What’s Inside?
We’ve got two helpful scripts:

create_environment.sh – This one sets everything up for you.

copilot_shell_script.sh – This lets you switch the assignment being tracked.

✅ How to Use
Step 1: Set up the app
Run the environment setup:

bash
Copy
Edit
./create_environment.sh
It’ll ask for your name.

Creates a folder like submission_reminder_Alex.

Inside, you'll find folders for assets, config, and source code.

Files like submissions.txt, config.env, and reminder.sh will be in the right place.

Also includes a starter script: startup.sh.

The script also adds permissions to make everything executable.

Step 2: Run the app
Inside your newly created folder, run:

bash
Copy
Edit
./startup.sh
It checks which students haven’t submitted the current assignment listed in the config file.

Step 3: Change the assignment (Copilot mode)
To update the tracked assignment:

bash
Copy
Edit
./copilot_shell_script.sh
Enter the new assignment name when prompted.

It updates the config file.

Then it shows you how to re-run the app with the new assignment.

📁 Folder Structure (After Setup)
arduino
Copy
Edit
submission_reminder_YourName/
│
├── assets/
│   └── submissions.txt
│
├── config/
│   └── config.env
│
├── modules/
│   ├── functions.sh
│   └── reminder.sh
│
└── startup.sh

✍️ About the Files
submissions.txt – Where student records live. Add at least 5 sample students.

config.env – Stores the current assignment name.

reminder.sh and functions.sh – Logic for checking submissions.

startup.sh – Reads the config and shows reminders.

copilot_shell_script.sh – Lets you change the assignment anytime.

🧪 Testing
After setup, run startup.sh to see pending students.

Change the assignment with copilot_shell_script.sh.

Run startup.sh again for the new assignment.



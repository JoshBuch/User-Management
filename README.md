# User-Management
This script can be used for user management across a multi-server infrastructure.
For example, there are 10 users on a linux server/machine and you want to provide certain permission to a group of users and also revoke certain permissions from a certain group of users. This script can be used to allot the appropriate system permissions based on a group of users. For this create a file containing the users for which you want to change the permission and the script will read from the file and perform the operation.

## Instructions
First create a file for a group of users as per the requirement in the same location as the script. The script will read from the file containing usernames and grant/revoke the permissions according to the script.

#!/bin/bash

#Place a file named "engineers" in the same folder as this script and add the name of release engineers in this file for the script to distinguish between release engineers and developers.

#Creating a file containing users whose permissions are to be changed
awk -F: '{if ($3 >= 1000) { print $1 } }' /etc/passwd > users.txt

#Name of the users for which you want the permissions to remain intact
#For example
sed -i 's/nobody//g' users.txt
sed -i 's/jenkins//g' users.txt

#Creating a sudoers file for release group to provide appropriate permissions
sudo touch /etc/sudoers.d/release

group1="developers"
if grep $group1 /etc/group
then
         echo "group already exists"
 else
         sudo groupadd $group1
fi

group2="release"
if grep $group2 /etc/group
then
         echo "group already exists"
 else
         sudo groupadd $group2
fi

#Appending the required permissions to be provided to the members of release group
#For example as shown below we want to provide just the docker permissions to the users under release group
sudo echo "Cmnd_Alias SERVICEMANAGEMENT = /usr/bin/docker" > /etc/sudoers.d/release
sudo echo "%release ALL = SERVICEMANAGEMENT" >> /etc/sudoers.d/release

echo Users having sudo access on the machine
awk '{print $1}'  /etc/group | grep sudo

#Revoking sudo access of the concerned users and providing them appropriate permissions as per their roles
input="./users.txt"
while IFS= read -r line
do
	sudo deluser $line sudo 2> /dev/null
	sudo usermod -a -G developers $line 2> /dev/null

done < "$input"
input1="./engineers"
while IFS= read -r user
do

	sudo deluser $user developers
	sudo usermod -aG release $user
done < "$input1"

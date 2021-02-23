#!/bin/bash

#Add users to the same Linux sysem as the script is executed on
USERID=$(id -u)
#------------------------------Functions----------------------------------
#Function to enter the required information (Userame, realname, password)
function enter_user_info() {
        read -p 'Enter the username to create: ' USERNAME
        read -p 'Enter the name of the person who this account is for: ' REALUSERNAME
        #read -p 'Enter a initial password to use for the account: ' PASSWORD
        #echo "${USERNAME}"
	return 100
}

function create_usr_and_change_password() {
	#Create user with password
	useradd -c "${REALUSERNAME}" -m "${USERNAME}"
	#Set password to username
	passwd ${USERNAME}
	#Force change password on the first login
	passwd -e ${USERNAME}
	#return 55 to know if everything goes well
	return 55
}


#-------------------------------Script----------------------------------
if [[ "${USERID}" -eq 0 ]];
then
        enter_user_info
	if [[ "${?}" -eq 100 ]];
	then
	create_usr_and_change_password
	if [[ "${?}" -eq 55 ]];
	then
		echo "-------------------------"
		echo "User successfully created"
		echo "-------------------------"
		echo $(finger ${USERNAME}) || sudo apt install finger && echo $(finger ${USERNAME})
		return 1
	else
		echo "Something went wrong"
	fi
else 
	echo "Something went wrong"
fi
else
        echo "Not allow to run this script"
        exit 1
fi



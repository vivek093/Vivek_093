#! /bin/bash
# To specify which script is being used
# By: Vivek Sharma
# PRN: 0120180482






# BEFORE RUNNING, GIVE EXECUTABLE PERMISSION TO THIS FILE


# 1. Go to the directory this file is in, (type : cd "CONTAINING DIRECTORY ADDRESS HERE")
# 2. In the terminal type, ( chmod 777 filemgmt.sh )

clear

read -p "Hey there, please enter your name : " name
#Taking user input in name variable
echo

echo -e "Your current Directory : \c"
pwd

# \c keeps cursor on same line, -e flag enables such backslash escapes
echo

#If dirctory already exits, delete it irrespective of it's contents.
if [ -d $name ]
then
	rm -rf $name
fi

#Creates a Directory with your name
mkdir $name

#Navigate to new directory
cd $name

echo
echo "	Lets Play a Game, $name"
echo
echo "Both of us choose an integer among 1 to 5, if they match, I'll give you 100$ if they don't you'll give me 50$"
echo
echo "Here, have 300$ to start with!"
echo
echo "To stop playing, enter 99"

curbal=300
#Current Balance

touch summary.txt
touch choices.txt
touch balance.txt

while [ $curbal -gt 0 ]
do
	echo
	echo "Current Balance : $curbal " 
	
	echo $curbal >> balance.txt
	#Log of balance

	read -p "Enter your choice : " ch
	#Player's Choice

	echo $ch >> choices.txt
	#Log of Player Choices

	if [ $ch -eq 99 ]
	then
		state="Quitter"
		break
	fi
	#Exit if Player doesn't want to play
	
	if [ $ch -gt 5  -o  $ch -lt 1 ]
	then
		echo "Naughty, I said between 1 to 5!!"
		echo "I'm gonna penalise you 10$ for this"
		curbal=$(( curbal-10 ))
		state="Cheater"
		continue
	fi
	#Check if choice is within range

	if [ $curbal -lt 1 ]
	then
		echo
		echo "You're bankrupt!!!"
		break
		state="Bankrupt"
	fi
	#Checks If no cash left

	compch=$((1 + RANDOM%5))
	#Computer's choice

	if [ $ch -eq $compch ]
	then
		echo "Congratulation, I chose $compch too! Here's 100$"
		curbal=$(( curbal+100 ))
		#If choices match, player gets 100
	else
		echo "Hard Luck, I chose $compch...."
		curbal=$(( curbal-50))	
	fi

	if [ $curbal -lt 1 ]
	then
		echo
		echo "You're bankrupt!!!"
		break
		state="Bankrupt"
	fi
done

echo
echo "Choices and Balance after every round availabe in: "
ls
#Display Files

summ="Name: $name; Status: $state; Balance: $curbal"
echo $summ >> summary.txt

#Create Summary

cd ..

if [ -f gen_summary.txt ]
then
	cat $name/summary.txt >> gen_summary.txt
else
	mv $name/summary.txt .
	mv summary.txt gen_summary.txt
fi

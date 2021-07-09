#!/bin/bash -x
declare -A singlet
singlet=( ["H"]=0 ["T"]=0 )
timesFlip=0
choice=0
function flipCoin() {
	face=$(( RANDOM % 2 ))
	if [ $face -eq 1 ]
	then
		echo "H"
	else
		echo "T"
	fi
}
function percentage() { #singlet starts
	temp=$1
	noFlip=$2
	percent=$(( temp * 100 / 10 ))
	echo "$percent%"
}

function maxOneFlip() {
	for combination in "${!singlet[@]}"
	do
		if [[ $maxCount -lt ${singlet[$combination]} ]]
		then
			maxCount=${singlet[$combination]}
			maxCombination=$combination
		fi
	done
	echo "Winning Combination is $maxCombination with $maxCount"
}

function oneFlip() {
	noFlip=$1
	singletHeadCount=0
	singletTailCount=0
	for (( i=0; i<10; i++ ))
	do
		result=$( flipCoin )
		if [ $result == H ]
		then
			(( singletHeadCount++ ))
			singlet[H]=$singletHeadCount
		else
			(( singletTailCount++ ))
			singlet[T]=$singletTailCount
		fi
	done

echo The Percentage of Head in singlet combination is $( percentage $singletHeadCount )
echo The Percentage of Tail in singlet combination is $( percentage $singletTailCount )
}


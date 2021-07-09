#!/bin/bash -x
declare -A singlet
singlet=( ["H"]=0 ["T"]=0 )

declare -A doublet
doublet=( ["HH"]=0 ["TT"]=0 ["HT"]=0 ["TH"]=0 )
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

#Singlet

function percentage() {
	temp=$1
	noFlip=$2
	percent=$(( temp * 100 / 10 ))
	echo "$percent%"
}
function percentage() {
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
function maxTwoFlip() {
	for combination in "${!doublet[@]}"
	do
		if [[ $maxCount -lt ${doublet[$combination]} ]]
		then
			maxCount=${doublet[$combination]}
			maxCombination=$combination
		fi
	done

	echo "Winning combination is $maxCombination with $maxCount"
}
function twoFlip() {
	noFlip=$1
	doubleHeadCount=0
	doubleTailCount=0
	headThenTailCount=0
	tailThenHeadCount=0
	for (( j=0; j<10; j++ ))
	do
		result1=$( flipCoin )
		result2=$( flipCoin )
		if [ $result1$result2 == HH ]
		then
			(( doubleHeadCount++ ))
			doublet[HH]=$doubleHeadCount
		elif [ $result1$result2 == TT ]
		then
			(( doubleTailCount++ ))
			doublet[TT]=$doubleTailCount
		elif [ $result1$result2 == HT ]
		then
			(( headThenTailCount++ ))
			doublet[HT]=$headThenTailCount
                else
			(( tailThenHeadCount++ ))
			doublet[TH]=$tailThenHeadCount
		fi
	done

echo HH percent: $( percentage $doubleHeadCount ), TT percent: $( percentage $doubleTailCount ), HT percent: $( percentage $headThenTailCount ), TH percent: $( percentage $tailThenHeadCount ) 
}

#!/bin/bash -x
declare -A singlet
singlet=( ["H"]=0 ["T"]=0 )

declare -A doublet
doublet=( ["HH"]=0 ["TT"]=0 ["HT"]=0 ["TH"]=0 )

declare -A triplet
triplet=( ["HHH"]=0 ["TTT"]=0 ["HHT"]=0 ["TTH"]=0 ["HTH"]=0 ["THT"]=0 ["THH"]=0 ["HTT"]=0 )

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

#Doublet

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

#Triplet

function maxThreeFlip() {
	for combination in "${!triplet[@]}"
	do
		if [[ $maxCount -lt ${triplet[$combination]} ]]
		then
			maxCount=${triplet[$combination]}
			maxCombination=$combination
		fi
	done

	echo "Winning combination is $maxCombination with $maxCount"
}
function threeFlip() {
	noFlip=$1
	tripleHeadCount=0
	tripleTailCount=0
	headHeadTail=0
	tailTailHead=0
	headTailHead=0
	tailHeadTail=0
	tailHeadHead=0
	headTailTail=0
	for (( k=0; k<$noFlip; k++ ))
	do
		result1=$( flipCoin )
		result2=$( flipCoin )
		result3=$( flipCoin )
		result=$result1$result2$result3
		if [ $result == HHH ]
		then
			(( tripleHeadCount++ ))
			triplet[HHH]=$tripleHeadCount
		elif [ $result == TTT ]
		then
			(( tripleTailCount++ ))
			triplet[TTT]=$tripleTailCount
		elif [ $result == HHT ]
		then
			(( headHeadTail++ ))
			triplet[HHT]=$headHeadTail
		elif [ $result == TTH ]
		then
			(( tailTailHead++ ))
			triplet[TTH]=$tailTailHead
		elif [ $result == HTH ]
		then
			(( headTailHead++ ))
			triplet[HTH]=$headTailHead
		elif [ $result == THT ]
		then
			(( tailHeadTail++ ))
			triplet[THT]=$tailHeadTail
		elif [ $result == THH ]
		then
			(( tailHeadHead++ ))
			triplet[THH]=$tailHeadHead
		else
			(( headTailTail++ ))
			triplet[HTT]=$headTailTail
		fi
	done

	echo HHH percent: $( percentage $tripleHeadCount $noFlip ), TTT percent: $( percentage $tripleTailCount $noFlip ), HHT percent: $( percentage $headHeadTail $noFlip ), TTH percent: $( percentage $tailTailHead $noFlip ), HTH percent: $( percentage $headTailHead $noFlip ), THT percent: $( percentage $tailHeadTail $noFlip ) , THH percent: $( percentage $tailHeadHead $noFlip ), HTT percent: $( percentage $headTailTail $noFlip )
}
function main() {
        echo "----------Flip Coin Simulation----------"
	echo -e "Enter 1 to flip one coin \nEnter 2 to flip two coin \nEnter 3 to flip three coin"
	read -p "Enter choice: " choice
	read -p "How many times you want to flip the coin: " timesFlip

	case $choice in
		1)
			oneFlip $timesFlip;;
		2)
			twoFlip $timesFlip;;
		3)
			threeFlip $timesFlip;;
		*)
			echo "Invalid choice!!";;
	esac
}
main

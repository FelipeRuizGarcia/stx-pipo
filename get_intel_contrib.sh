#!/bin/bash

BASE="$(dirname "$(readlink -f "${BASH_SOURCE[0]}" )" )"
LIST_INTEL_CONTRIB="$BASE/intel-contrib.txt"

rm $LIST_INTEL_CONTRIB

for repo in $( ls -d repos/* -1 ); do

	cd $BASE/$repo
	echo $(pwd)
	for file in $( find . -type f ); do
		git shortlog -e $file | grep @intel &>/dev/null  && readlink -f $file >> $LIST_INTEL_CONTRIB
	done

done

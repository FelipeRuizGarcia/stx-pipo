#!/bin/bash

BASE="$(dirname "$(readlink -f "${BASH_SOURCE[0]}" )" )"
LIST_INTEL_CONTRIB="$BASE/intel-contrib.txt"
LIST_INTEL_ADDED="$BASE/intel-added.txt"

rm $LIST_INTEL_CONTRIB
rm $LIST_INTEL_ADDED

for repo in $( ls -d repos/* -1 ); do

	cd $BASE/$repo
	echo $(pwd)
	for file in $( find . -type f ); do
		git shortlog -e $file | grep @intel &>/dev/null  && readlink -f $file >> $LIST_INTEL_CONTRIB
		git log --reverse --follow $file | head -2 | grep "intel" &>/dev/null && readlink -f $file >> $LIST_INTEL_ADDED
	done

done

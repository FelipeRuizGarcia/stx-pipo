#!/bin/bash

# failed packages
# rpmlints .

stx_project="stx_project"

stx_repos="stx_repos"

stx_repos_warning="stx_warnings"
stx_repos_warning_systemd="stx_repos_warnings_systemd"
stx_repos_warning_systemd_all="stx_repos_warnings_systemd_all"

mkdir -p $stx_repos_warning

echo "STARTING TO CHECK STARLINGX PACKAGING ON OBS"
echo "CONNECTING TO OBS"

osc api -X GET "/build/Cloud:StarlingX:2.0/_result" > $stx_project

grep package $stx_project | awk -F "\"" '{print $2 }' > $stx_repos

echo "WRITING $stx_project FILE"

for repo in `cat $stx_repos`;
do
	echo "CHECKING RPMLINT FOR REPO $repo ..."
	osc api -X GET "/build/Cloud:StarlingX:2.0/openSUSE_Leap_15.0/x86_64/$repo/rpmlint.log" > $stx_repos_warning/$repo
done

echo "CHECKING SYSTEMD WARNINGS "
grep systemd $stx_repos_warning/* > $stx_repos_warning_systemd_all
grep systemd $stx_repos_warning/* | awk -F ":" '{print $1}' | sort -u  > $stx_repos_warning_systemd
echo "SYSTEMD WARNINGS REPOS WRITTED AT $stx_repos_warning_systemd"
echo "SYSTEMD WARNINGS REPOS WRITTED AT $stx_repos_warning_systemd_all"

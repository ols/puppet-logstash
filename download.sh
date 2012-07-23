#!/bin/bash
echo -e "Type version to download (at time of writing "1.1.1"): \c"
read ls_version
ls_archive="logstash-$ls_version-monolithic.jar"
ls_source="http://semicomplete.com/files/logstash"
curl -o files/$ls_archive $ls_source/$ls_archive


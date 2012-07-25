#!/bin/bash
read -p "Type LogStash version to download [1.1.1]: " -e 1.1.1 -i ls_version
ls_archive="logstash-$ls_version-monolithic.jar"
ls_source="http://semicomplete.com/files/logstash"
curl -o files/$ls_archive $ls_source/$ls_archive

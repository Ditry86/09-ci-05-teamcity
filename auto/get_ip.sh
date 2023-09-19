#!/usr/bin/env 
[ -f ./ext_ip ] && echo > ./ext_ip || touch ./ext_ip
cd terraform/ && terraform output > ../tf_out
cd ..
cat tf_out | sed '/external.*/,/}/!d;//d;s/[",=]//g;/![teamcity\-server]/,//d' | grep teamcity-server | sed 's/^[[:space:]]*//' >> ext_ip
cat tf_out | sed '/external.*/,/}/!d;//d;s/[",=]//g;/![teamcity\-agent]/,//d' | grep teamcity-agent | sed 's/^[[:space:]]*//' >> ext_ip
cat tf_out | sed '/external.*/,/}/!d;//d;s/[",=]//g;/![nexus]/,//d' | grep nexus | sed 's/^[[:space:]]*//' >> ext_ip
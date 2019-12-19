#!/bin/bash
stty erase ^h

#获取版本号
version=`awk '/<version>[^<]+<\/version>/{gsub(/<version>|<\/version>/,"",$1);print $1;exit;}' pom.xml`
echo $version

if [ $1 == "major"  ];then
       version=`awk '/<version>[^<]+<\/version>/{gsub(/<version>|<\/version>/,"",$1);print $1;exit;}' pom.xml`
       developVersion=$(echo $version | awk -F"." '{print $1}')
       developVersion=$(expr $developVersion + 1)
       git add .
       git commit -m "[maven-release-plugin] prepare patch version: ${developVersion}.0.0-SNAPSHOT"
       mvn release:clean release:prepare -B -DdevelopmentVersion=${developVersion}.0.0-SNAPSHOT -DreleaseVersion=${developVersion}.0.0 -Dtag=${developVersion}.0.0
       git checkout -b release/${developVersion}.0.0 ${developVersion}.0.0
       git push origin HEAD
       #mvn release:perform
       git checkout master
       git checkout -b fix/${developVersion}.0 ${developVersion}.0.0
       mvn versions:set -DnewVersion="${developVersion}.0.1-SNAPSHOT"
       git add .
       git commit -m "[maven-release-plugin] prepare patch version: ${developVersion}.0.1-SNAPSHOT"
       git push origin HEAD       
elif [ $1 == "minor"  ];then
        version=`awk '/<version>[^<]+<\/version>/{gsub(/<version>|<\/version>/,"",$1);print $1;exit;}' pom.xml`
        majordevelopVersion=$(echo $version | awk -F"." '{print $1}')
        developVersion=$(echo $version | awk -F"." '{print $2}')
        echo $developVersion
        developVersion=$(expr $developVersion + 1)
        mvn release:clean release:prepare -B -DdevelopmentVersion=${majordevelopVersion}.${developVersion}.0-SNAPSHOT -DreleaseVersion=${majordevelopVersion}.${deveopVersion}.0 -Dtag=${majordevelopVersion}.${developVersion}.0
       
        mvn release:perform
elif [ $1 == "patch" ];then
        read -p "Input Version: (fix/162.0) " version
        echo $version
        git branch -r |grep $version
    
        
else
   echo "You must input choice"
fi



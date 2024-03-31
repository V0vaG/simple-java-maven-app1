#!/bin/bash

sed -i "s/x.y.z/$1.$2.$3/g" pom.xml

cat pom.xml

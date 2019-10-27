#!/usr/bin/ruby -p
$_.gsub!(/^\s*(\w+)\s*$/, "<#{$1}></#{$1}>\n")
#!/bin/bash

cat corps.txt | sed -r -s 's/([*][^*]*[*])/<strong>\1<\/strong>/g' | sed -e 's/\*//g' | sed -r -s 's/(["][^"]*["])/<em>\1<\/em>/g' | sed -e 's/\"//g'

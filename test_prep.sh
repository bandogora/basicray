#!/bin/bash

rm ~/basicray/main ~/basicray/intersect_tests/run_tbs.sh
rm ~/basicray/intersect_tests/results_c ~/basicray/intersect_tests/results_v
rm -r ~/basicray/intersect_tests/tbs/
g++ -o ~/basicray/main ~/basicray/main.cpp
./main >> ~/basicray/intersect_tests/results_c
chmod 777 ~/basicray/intersect_tests/run_tbs.sh

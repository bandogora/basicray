#!/bin/bash

g++ -o /home/jforgue/raytracing/basicray/main /home/jforgue/raytracing/basicray/main.cpp
./main >> /home/jforgue/raytracing/basicray/intersect_tests/results_c
rm /home/jforgue/raytracing/basicray/intersect_tests/results_v
chmod 777 /home/jforgue/raytracing/basicray/intersect_tests/run_tbs.sh

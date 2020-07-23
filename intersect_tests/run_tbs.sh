#!/bin/bash

V=0
while [ $V -le 82944 ]
do
  iverilog -o intersect_$V intersect_tb$V.v &> /dev/null
  vvp intersect_$V >> results_v
  ((V++))
done

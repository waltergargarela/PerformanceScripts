#!/bin/bash

logdir="./log"

iostat -dmt 2 > $logdir/iostat.out &

vmstat -ans -S k 2 > $logdir/vmstat.out &

mpstat 2 > $logdir/mpstat.out &

sar 2 > $logdir/sar.out &

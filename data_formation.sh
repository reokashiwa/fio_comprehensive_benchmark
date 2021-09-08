#!/usr/bin/bash

for rw in read write
do
  case "$rw" in
    "read" ) PATTERN="READ:" ;;
    "write" ) PATTERN="WRITE:" ;;
  esac
  for runtime in 1 2 4 8 16 32 64 128
  do
    for numjobs in 1 2 4 8 16 32 64 128
    do
      if [ -e ${rw}_${numjobs}_${runtime}.dat ]; then
        rm ${rw}_${numjobs}_${runtime}.dat
      fi
      touch ${rw}_${numjobs}_${runtime}.dat
      for size in 1 2 4 8 16 32 64 128 256 512 1024 2048
      do 
        for bs in 4 8 16 32 64 128 256 512 1024 2048
        do
          TP=`grep ${PATTERN} ${rw}_${bs}_${size}_${numjobs}_${runtime}.dat| \
            awk '{print $2}'|awk -F= '{print $2}'|sed -e 's/MiB\/s//'`
          echo -e "${size}\t${bs}\t${TP}" >> ${rw}_${numjobs}_${runtime}.dat
        done
        echo >> ${rw}_${numjobs}_${runtime}.dat
      done
    done
  done
done

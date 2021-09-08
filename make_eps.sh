#!/usr/bin/bash

for rw in read write
do
  for runtime in 1 2 4 8 16 32 64 128
  do
    for numjobs in 1 2 4 8 16 32 64 128
    do
      FILENAME=${rw}_${numjobs}_${runtime}
      cp template.plt ${FILENAME}.plt
      echo "set output '${FILENAME}.eps'" >> ${FILENAME}.plt
      echo "splot '${FILENAME}.dat' with pm3d,'${FILENAME}.dat' with lines" >> \
        ${FILENAME}.plt
      gnuplot ${FILENAME}.plt
    done
  done
done

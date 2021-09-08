#!/usr/bin/bash

PRODUCT_ID=$1
TARGET_DEV=$2
FIO="./fio"

mkdir ${PRODUCT_ID}
mkdir ${PRODUCT_ID}/${TARGET_DEV}

for rw in read write trim randread randwrite randtrim readwrite randrw trimwrite
do
	for bs in 1 2 4 8 16 32 64 128 256 512 1024 2048 4096
	do
		for size in 1 2 4 8 16 32 64 128 256 512 1024 2048 4096
		do
			for numjobs in 1 2 4 8 16 32 64 128
			do
				${FIO} -filename=${TARGET_DEV} \
						   -direct=1 \
						   -rw=${rw} \
					     -bs=${bs}k \
						   -size=${size}M \
						   -numjobs=${numjobs} \
						   -group_reporting \
					     -name=${PRODUCT_ID}_${TARGET_DEV}_${rw}_${bs}_${size}_${numjobs} \
						   -output=${PRODUCT_ID}/${TARGET_DEV}/${rw}_${bs}_${size}_${numjobs}.dat
			done
		done
	done
done

#!/bin/bash

$MONTAGE/bin/mImgtbl . images.tbl
$MONTAGE/bin/mAdd -p . images.tbl %=HEADER% m101_uncorrected.fits

sleep 3
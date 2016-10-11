#!/bin/bash
$MONTAGE/bin/mImgtbl . images.tbl
%=WFDIR%/bin/MontageFormatInputData cm ofitplane.hfrag

$MONTAGE/bin/mBgModel images.tbl fits.tbl corrections.tbl

rm -rf corrdir
mkdir corrdir
cp *.fits corrdir

$MONTAGE/bin/mBgExec -p . images.tbl corrections.tbl corrdir

$MONTAGE/bin/mAdd -p corrdir images.tbl %=HEADER% mosaic_corrected.fits

$MONTAGE/bin/mJPEG -gray mosaic_corrected.fits 0s max gaussian-log -out mosaic_corrected.jpg
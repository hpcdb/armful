#!/bin/bash
mImgtbl rawdir images-rawdir.tbl
mProjExec -p rawdir images-rawdir.tbl template.hdr projdir stats.tbl
mImgtbl projdir images.tbl
mAdd -p projdir images.tbl template.hdr final/m101_uncorrected.fits
mJPEG -gray final/m101_uncorrected.fits 20% 99.98% log -out final/m101_uncorrected.jpg
mOverlaps images.tbl diffs.tbl
mDiffExec -p projdir diffs.tbl template.hdr diffdir
mFitExec diffs.tbl fits.tbl diffdir
mBgModel images.tbl fits.tbl corrections.tbl
mBgExec -p projdir images.tbl corrections.tbl corrdir
mAdd -p corrdir images.tbl template.hdr final/m101_mosaic.fits
mJPEG -gray final/m101_mosaic.fits 0s max gaussian-log -out final/m101_mosaic.jpg
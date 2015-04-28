#!/bin/sh
R CMD BATCH --slave --no-restore --no-save $1 $2

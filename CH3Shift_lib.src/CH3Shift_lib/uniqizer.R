################################################################################
# Copyright (C) 2009+ Aleksandr B. Sahakyan (aleksahak[at]cantab.net).         #
#                                                                              #
# License: You may redistribute this source code (or its components) and/or    #
#   modify/translate it under the terms of the GNU General Public License      #
#   as published by the Free Software Foundation; version 2 of the License     #
#   (GPL2). You can find the details of GPL2 in the follwing link:             #
#   https://www.gnu.org/licenses/gpl-2.0.html                                  #
################################################################################
# This script given the object that contains $resSeq and $chainID branches
# returns the same object with the same but rewritten branches that are
# unique accounting the chain differences as well!

uniqizer <- function(OBJECT){
  unique.ids <- paste(OBJECT$resSeq, OBJECT$chainID, sep="_")
  unique.ids <- unique(unique.ids)
  unique.ids <- unlist(strsplit(unique.ids,"_"))
  OBJECT$resSeq  <- as.numeric(unique.ids[seq(from=1, to=length(unique.ids), by=2)])
  OBJECT$chainID <- unique.ids[seq(from=2, to=length(unique.ids), by=2)]
  return(OBJECT)
}

################################################################################

################################################################################
# Copyright (C) 2009+ Aleksandr B. Sahakyan (aleksahak[at]cantab.net).         #
#                                                                              #
# License: You may redistribute this source code (or its components) and/or    #
#   modify/translate it under the terms of the GNU General Public License      #
#   as published by the Free Software Foundation; version 2 of the License     #
#   (GPL2). You can find the details of GPL2 in the follwing link:             #
#   https://www.gnu.org/licenses/gpl-2.0.html                                  #
################################################################################
# This function analyses the arealt object from the getarea() function
# and determines whether there are distances of the same type, meaning
# that both the arealt$resName and arealt$name are the same. The $resSeq
# CAN be different, indicating that the atoms of the same type and 
# amino acid type belong to different residues. As a result, the function
# returns an object, which contains:
# $name -- non repeeting names if do not belong to different amino acids,
# $resName -- non repeating amino acid names corresponding to $names
# $Sdist -- sum of distances of the type and order as the object above.
# $SdistR2 -- sum of 1/(dist^2) of the type and order as the object above. 
# $SdistR3 -- sum of 1/(dist^3) of the type and order as the object above. 
# THIS FUNCTION IS ESSENTIAL FOR THE DISTANCE COMPONENTS OF DATA EXTRACTION
################################################################################
# VERSION: 8 March., R1 and R6 are added, a bug is fixed

CH3.Merge.Same.Type.dist  <- function(arealt, cutoffR=0.01) {
  excl <- which(arealt$dist <= cutoffR)
  if(length(excl)!=0){
    arealt$dist    <- areal$dist[-excl]
    arealt$resName <- areal$resName[-excl]
    arealt$resSeq  <- areal$resSeq[-excl]
    arealt$name    <- areal$name[-excl]
    arealt$chain   <- areal$chain[-excl]
  }
  RESULT <- NULL
  resName.name <- NULL
  for(i in 1:length(arealt$dist)) {
    resName.name[i] <- paste(arealt$resName[i],"_",arealt$name[i],sep="")
  }; rm(i)
  resName.name <- unique(resName.name)
  for(i in 1:length(resName.name)) {
    RESULT$resName[i] <- unlist(strsplit(resName.name[i], "_"))[1]
    RESULT$name[i]    <- unlist(strsplit(resName.name[i], "_"))[2]
    sametype.dist     <- arealt$dist[which(arealt$name==RESULT$name[i] & arealt$resName==RESULT$resName[i])]
    RESULT$Sdist[i]   <- sum(sametype.dist)
    RESULT$SdistR1[i] <- sum(1/sametype.dist)
    ### ### RESULT$SdistR2[i] <- sum(1/(sametype.dist^2))
    RESULT$SdistR3[i] <- sum(1/(sametype.dist^3))
    RESULT$SdistR6[i] <- sum(1/(sametype.dist^6))
  }
  return(RESULT)
}

################################################################################

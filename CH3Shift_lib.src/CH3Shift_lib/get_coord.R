################################################################################
# Copyright (C) 2009+ Aleksandr B. Sahakyan (aleksahak[at]cantab.net).         #
#                                                                              #
# License: You may redistribute this source code (or its components) and/or    #
#   modify/translate it under the terms of the GNU General Public License      #
#   as published by the Free Software Foundation; version 2 of the License     #
#   (GPL2). You can find the details of GPL2 in the follwing link:             #
#   https://www.gnu.org/licenses/gpl-2.0.html                                  #
################################################################################
## This function takes the name of the atom in a residue (i.e. "name"         ##
## in the parsed pdb object, such as "NE2"), the residue sequence num.        ##
## ("resSeq") and the residue type (three capital letter, i.e. "VAL").        ##
## The output holds xyz coordinates of the queried atom. If the inputs        ##
## are vectors of atoms with equal length, the output will be a 3 times       ##
## longer length, holding x1,y1,z1,x2,y2,z2,x3,y3,z3..... etc.                ##
##      Of course the parsed pdb object should also be inputted.              ##
################################################################################

# 11 Aug, 2010 -- the function is enhanced by an optional inclusion of
# the chain identifier in a more robust recognition in multichain 
# parsed.pdb objects, while keeping a full back-compatibility.

# 14 Jul, 2010 -- a significant bug is corrected:
# if there are more than 2 entries with the same name, resSeq and chainID,
# but different iCode (let us say A and B), then the function will always
# take the first entry (A), achieved via replacing [indx] by [indx[1]]

get.coord <- function(name, resSeq, parsed.pdb, chainID=NULL) {
# example   get.coord("CG1",  5,    parsed.pdb)

  if(length(chainID)==0){

    l <- length(name)
    output <- NULL
    for(i in 1:l) {
      indx <- which( (parsed.pdb$resSeq==resSeq[i]) &
                     (parsed.pdb$name==name[i])          )
      xyz <- c(parsed.pdb$x[indx[1]],parsed.pdb$y[indx[1]],parsed.pdb$z[indx[1]])
      if( sum(is.na(xyz))!=0 ){ xyz <- integer(0) }
      output <- c(output, xyz)
    }
    return(output)

  } else {

    l <- length(name)
    output <- NULL
    for(i in 1:l) {
      indx <- which( (parsed.pdb$resSeq==resSeq[i]) &
                     (parsed.pdb$name==name[i]) &
                     (parsed.pdb$chainID==chainID)    )
      xyz <- c(parsed.pdb$x[indx[1]],parsed.pdb$y[indx[1]],parsed.pdb$z[indx[1]])
      if( sum(is.na(xyz))!=0 ){ xyz <- integer(0) }
      output <- c(output, xyz)
    }
    return(output)

  }

}

################################################################################


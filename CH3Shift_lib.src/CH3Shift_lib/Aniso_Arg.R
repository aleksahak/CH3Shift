################################################################################
# Copyright (C) 2009+ Aleksandr B. Sahakyan (aleksahak[at]cantab.net).         #
#                                                                              #
# License: You may redistribute this source code (or its components) and/or    #
#   modify/translate it under the terms of the GNU General Public License      #
#   as published by the Free Software Foundation; version 2 of the License     #
#   (GPL2). You can find the details of GPL2 in the follwing link:             #
#   https://www.gnu.org/licenses/gpl-2.0.html                                  #
################################################################################
# This function, given the query coordinates, the residue sequence number,
# the areal object from the "getarea" function and the parsed pdb object,
# and the atom names to identify the presence of moieties in vicinity,
# determines the presence of peptide groups in the vicinity and calculates
# the geometric factor from the contribution from arginine guanidine groups.
################################################################################
# VERSION: 28 October 2010 - modified to become chain sensitive
# REQUIRES: "PlaneCurrent.ARG" SOURCE: "PlaneCurrent_ARG.R"
# REQUIRES: "get.coord" SOURCE "get_coord.R"
# REQUIRES: "uniqizer"  SOURCE "uniqizer.R"

Aniso.Arg <- function(query.xyz, areal, parsed.pdb, 
                      atom1="CZ", atom2="NH1", atom3="NH2", Amino="ARG") {



  ind.arg <- which(areal$name==atom2 & areal$resName==Amino)
  if(length(ind.arg)==0) {
    ind.arg <- which(areal$name==atom3 & areal$resName==Amino)
  }  
  if(length(ind.arg)==0) {
    ind.arg <- which(areal$name==atom1 & areal$resName==Amino)
  }  
  ARG <- NULL
  ########################
  if(length(ind.arg)!=0){   
    ARG$resSeq  <- areal$resSeq[ind.arg]
    ARG$chainID <- areal$chain[ind.arg]
    ARG <- uniqizer(ARG)
    # Calculating geometric factors for each of resSeq
    ARG$PC <- NULL
    for(i in 1:length(ARG$resSeq)){
      C.coord  <- get.coord(atom1, resSeq=ARG$resSeq[i], parsed.pdb, chainID=ARG$chainID[i])
      O1.coord <- get.coord(atom2, resSeq=ARG$resSeq[i], parsed.pdb, chainID=ARG$chainID[i])
      O2.coord <- get.coord(atom3, resSeq=ARG$resSeq[i], parsed.pdb, chainID=ARG$chainID[i])
      ARG$PC[i] <- PlaneCurrent.ARG(query.xyz=query.xyz, xyz1=C.coord,
                                    xyz2=O1.coord, xyz3=O2.coord)$GPC
    }; rm(i)
    # Calculating sum of the geometric factors:
    ARG$ANISO.SUM <- sum(ARG$PC)
  }
  ########################
  return(ARG) # Null if the moieties are absent in areal
}

################################################################################

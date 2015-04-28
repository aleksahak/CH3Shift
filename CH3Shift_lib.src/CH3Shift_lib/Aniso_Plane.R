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
# determines the presence of anisotr. groups in the vicinity and calculates
# the geometric factor from the contribution from anisotropic groups.
################################################################################
# VERSION: 28 October 2010, modified to be chain sensitive!
# REQUIRES: "PlaneCurrent" SOURCE: "PlaneCurrent.R"
# REQUIRES: "get.coord" SOURCE "get_coord.R"
# REQUIRES: "uniqizer" SOURCE "uniqizer.R"

Aniso.Plane <- function(query.xyz, areal, parsed.pdb, 
                        atom1="CG", atom2="OD1", atom3="OD2", Amino="ASP") {

  ind.pln <- which(areal$name==atom1 & areal$resName==Amino)
  if(length(ind.pln)==0) {
    ind.pln <- which(areal$name==atom2 & areal$resName==Amino)
  }  
  if(length(ind.pln)==0) {
    ind.pln <- which(areal$name==atom3 & areal$resName==Amino)
  }  
  PLN <- NULL
  ########################
  if(length(ind.pln)!=0){   
    PLN$resSeq  <- areal$resSeq[ind.pln]
    PLN$chainID <- areal$chain[ind.pln]
    PLN <- uniqizer(PLN)
    # Calculating geometric factors for each of resSeq
    PLN$PC <- NULL
    for(i in 1:length(PLN$resSeq)){
      C.coord   <- get.coord(atom1, resSeq=PLN$resSeq[i], parsed.pdb, chainID=PLN$chainID[i])
      O1.coord  <- get.coord(atom2, resSeq=PLN$resSeq[i], parsed.pdb, chainID=PLN$chainID[i])
      O2.coord  <- get.coord(atom3, resSeq=PLN$resSeq[i], parsed.pdb, chainID=PLN$chainID[i])
      PLN$PC[i] <- PlaneCurrent(query.xyz=query.xyz, xyz1=C.coord, xyz2=O1.coord, xyz3=O2.coord)$GPC
    }; rm(i)
    # Calculating sum of the geometric factors:
    PLN$ANISO.SUM <- sum(PLN$PC)
  }
  ########################
  return(PLN) # will be NULL if the moiety does not exist
}

################################################################################

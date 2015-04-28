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
# determines the presence of peptide groups in the vicinity and calculates
# the geometric factor from the contribution from peptide groups.
# It returns also the sum of the geometric factors and differentiates 
# between own and distant peptide groups.
################################################################################
# VERSION: 28 October 2010 - modified to account chain ids.
# VERSION: FEB 20, Polished, a source of error is eliminated!
# REQUIRES: "PlaneCurrent" SOURCE: "PlaneCurrent.R"
# REQUIRES: "get.coord" SOURCE "get_coord.R"

Aniso.Pept <- function(query.xyz, resSeqnum, areal, parsed.pdb, chainID) {

  ind.pept <- which(areal$name=="C")
  PEPT <- NULL
  ########################
  if(length(ind.pept)!=0) {   
    PEPT$flag    <- rep(0, length(ind.pept)) # 1 => close (own) peptide
    PEPT$resSeq  <- areal$resSeq[ind.pept]
    PEPT$chainID <- areal$chain[ind.pept]
    PEPT <- uniqizer(PEPT)
    close.pept.ind <- c(which(PEPT$resSeq==resSeqnum & PEPT$chainID==chainID), 
                        which(PEPT$resSeq==(resSeqnum-1) & PEPT$chainID==chainID) )
    if(length(close.pept.ind)!=0) {
      PEPT$flag[close.pept.ind] <- 1
    }
    # Calculating geometric factors for each of resSeq
    PEPT$PC <- NULL
    for(i in 1:length(PEPT$resSeq)){
      C.coord <- get.coord("C", resSeq=PEPT$resSeq[i], parsed.pdb, chainID=PEPT$chainID[i])
      O.coord <- get.coord("O", resSeq=PEPT$resSeq[i], parsed.pdb, chainID=PEPT$chainID[i])
      if(length(O.coord)==0){    # A terminal moiety = COOH => N does not exist.
        PEPT$PC[i] <- 0.00
      } else {
        # Pay attention to +1 to account shift in residue number
        N.coord <- get.coord("N", resSeq=PEPT$resSeq[i]+1, parsed.pdb, chainID=PEPT$chainID[i])
        if(length(N.coord)==0){  # A terminal moiety = COOH => N of the next pept. does not exist.
          PEPT$PC[i] <- 0.00
        } else {
          PEPT$PC[i] <- PlaneCurrent(query.xyz=query.xyz, xyz1=C.coord, xyz2=O.coord, xyz3=N.coord)$GPC
        }
      }
    }; rm(i)
    # Calculating sum of the geometric factors including and excluding the own
    # peptide moieties:
    PEPT$ANISO.PEPT <- sum(PEPT$PC)
    far.ind <- which(PEPT$flag==0)
    if(length(far.ind)!=0){
      PEPT$ANISO.FARPEPT <- sum(PEPT$PC[far.ind])
    }  
  }
  ########################
  return(PEPT)

}

################################################################################

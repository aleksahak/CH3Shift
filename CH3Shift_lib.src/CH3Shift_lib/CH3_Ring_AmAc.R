################################################################################
# Copyright (C) 2009+ Aleksandr B. Sahakyan (aleksahak[at]cantab.net).         #
#                                                                              #
# License: You may redistribute this source code (or its components) and/or    #
#   modify/translate it under the terms of the GNU General Public License      #
#   as published by the Free Software Foundation; version 2 of the License     #
#   (GPL2). You can find the details of GPL2 in the follwing link:             #
#   https://www.gnu.org/licenses/gpl-2.0.html                                  #
################################################################################
# Finds the rings and calculates the ring current factors and the sum          #
################################################################################
# VERSION: 02 November 2010, modified to accoun chainIDs
# REQUIRES: "RingCurrent" SOURCE: "RingCurrent.R"
# REQUIRES: "get.coord" SOURCE "get_coord.R"

CH3.Ring.AmAc <- function(query.xyz, areal, parsed.pdb, rng) {

  RING <- NULL
  if(rng=="TYR") {
    ind.ring <- c(which(areal$name=="CG"  & areal$resName=="TYR"),
                  which(areal$name=="CD1" & areal$resName=="TYR"),
                  which(areal$name=="CE1" & areal$resName=="TYR"),
                  which(areal$name=="CZ"  & areal$resName=="TYR"),
                  which(areal$name=="CE2" & areal$resName=="TYR"),
                  which(areal$name=="CD2" & areal$resName=="TYR") )
    ########################
    if(length(ind.ring) > 1) {  # at leat 2 atoms from the ring are at the vicinity   
      RING$resSeq  <- areal$resSeq[ind.ring]
      RING$chainID <- areal$chain[ind.ring]
      RING <- uniqizer(RING)
      # Calculating geometric factors for each of resSeq
      RING$RC <- NULL
      for(i in 1:length(RING$resSeq)) {
        xyz1 <- get.coord("CG",  resSeq=RING$resSeq[i], parsed.pdb, chainID=RING$chainID[i])
        xyz2 <- get.coord("CD1", resSeq=RING$resSeq[i], parsed.pdb, chainID=RING$chainID[i])
        xyz3 <- get.coord("CE1", resSeq=RING$resSeq[i], parsed.pdb, chainID=RING$chainID[i])
        xyz4 <- get.coord("CZ",  resSeq=RING$resSeq[i], parsed.pdb, chainID=RING$chainID[i])
        xyz5 <- get.coord("CE2", resSeq=RING$resSeq[i], parsed.pdb, chainID=RING$chainID[i])
        xyz6 <- get.coord("CD2", resSeq=RING$resSeq[i], parsed.pdb, chainID=RING$chainID[i])
        RING$RC[i] <- RingCurrent(query.xyz, xyz1=xyz1, xyz2=xyz2,
                                  xyz3=xyz3, xyz4=xyz4, xyz5=xyz5, xyz6=xyz6)$gfHM
      }; rm(i)
      # Calculating sum of the geometric factors for the given residue type:
      RING$RC.SUM <- sum(RING$RC)
    }
    ########################
  }
  if(rng=="PHE") {
    ind.ring <- c(which(areal$name=="CG" & areal$resName=="PHE"),
                  which(areal$name=="CD1" & areal$resName=="PHE"),
                  which(areal$name=="CE1" & areal$resName=="PHE"),
                  which(areal$name=="CZ" & areal$resName=="PHE"),
                  which(areal$name=="CE2" & areal$resName=="PHE"),
                  which(areal$name=="CD2" & areal$resName=="PHE") )
    ########################
    if(length(ind.ring) > 1) {  # at leat 2 atoms from the ring are at the vicinity   
      RING$resSeq  <- areal$resSeq[ind.ring]
      RING$chainID <- areal$chain[ind.ring]
      RING <- uniqizer(RING)
      # Calculating geometric factors for each of resSeq
      RING$RC <- NULL
      for(i in 1:length(RING$resSeq)) {
        xyz1 <- get.coord("CG",  resSeq=RING$resSeq[i], parsed.pdb, chainID=RING$chainID[i])
        xyz2 <- get.coord("CD1", resSeq=RING$resSeq[i], parsed.pdb, chainID=RING$chainID[i])
        xyz3 <- get.coord("CE1", resSeq=RING$resSeq[i], parsed.pdb, chainID=RING$chainID[i])
        xyz4 <- get.coord("CZ",  resSeq=RING$resSeq[i], parsed.pdb, chainID=RING$chainID[i])
        xyz5 <- get.coord("CE2", resSeq=RING$resSeq[i], parsed.pdb, chainID=RING$chainID[i])
        xyz6 <- get.coord("CD2", resSeq=RING$resSeq[i], parsed.pdb, chainID=RING$chainID[i])
        RING$RC[i] <- RingCurrent(query.xyz, xyz1=xyz1, xyz2=xyz2,
                                  xyz3=xyz3, xyz4=xyz4, xyz5=xyz5, xyz6=xyz6)$gfHM
      }; rm(i)
      # Calculating sum of the geometric factors for the given residue type:
      RING$RC.SUM <- sum(RING$RC)
    }
    ########################
  }
  if(rng=="HIS") {
    ind.ring <- c(which(areal$name=="CG" & areal$resName=="HIS"),
                  which(areal$name=="ND1" & areal$resName=="HIS"),
                  which(areal$name=="CE1" & areal$resName=="HIS"),
                  which(areal$name=="NE2" & areal$resName=="HIS"),
                  which(areal$name=="CD2" & areal$resName=="HIS"))
    ########################
    if(length(ind.ring) > 1) {  # at leat 2 atoms from the ring are at the vicinity   
      RING$resSeq  <- areal$resSeq[ind.ring]
      RING$chainID <- areal$chain[ind.ring]
      RING <- uniqizer(RING)
      # Calculating geometric factors for each of resSeq
      RING$RC <- NULL
      for(i in 1:length(RING$resSeq)) {
        xyz1 <- get.coord("CG",  resSeq=RING$resSeq[i], parsed.pdb, chainID=RING$chainID[i])
        xyz2 <- get.coord("ND1", resSeq=RING$resSeq[i], parsed.pdb, chainID=RING$chainID[i])
        xyz3 <- get.coord("CE1", resSeq=RING$resSeq[i], parsed.pdb, chainID=RING$chainID[i])
        xyz4 <- get.coord("NE2", resSeq=RING$resSeq[i], parsed.pdb, chainID=RING$chainID[i])
        xyz5 <- get.coord("CD2", resSeq=RING$resSeq[i], parsed.pdb, chainID=RING$chainID[i])
        RING$RC[i] <- RingCurrent(query.xyz, xyz1=xyz1, xyz2=xyz2,
                                  xyz3=xyz3, xyz4=xyz4, xyz5=xyz5, xyz6=NULL)$gfHM
      }; rm(i)
      # Calculating sum of the geometric factors for the given residue type:
      RING$RC.SUM <- sum(RING$RC)
    }
    ########################
  }
  if(rng=="TRP") {
    ind.ring <- c(which(areal$name=="CG" & areal$resName=="TRP"),  # TRP5
                  which(areal$name=="CD1" & areal$resName=="TRP"),
                  which(areal$name=="NE1" & areal$resName=="TRP"),
                  which(areal$name=="CE2" & areal$resName=="TRP"),
                  which(areal$name=="CD2" & areal$resName=="TRP"),

                  which(areal$name=="CD2" & areal$resName=="TRP"), # TRP6
                  which(areal$name=="CE2" & areal$resName=="TRP"),
                  which(areal$name=="CZ2" & areal$resName=="TRP"),
                  which(areal$name=="CH2" & areal$resName=="TRP"),
                  which(areal$name=="CZ3" & areal$resName=="TRP"),
                  which(areal$name=="CE3" & areal$resName=="TRP") )
    ########################
    if(length(ind.ring) > 1) {  # at leat 2 atoms from the ring are at the vicinity   
      RING$resSeq  <- areal$resSeq[ind.ring]
      RING$chainID <- areal$chain[ind.ring]
      RING <- uniqizer(RING)
      # Calculating geometric factors for each of resSeq
      RING$RC1 <- RING$RC2 <- NULL
      for(i in 1:length(RING$resSeq)) {
        xyz1 <- get.coord("CG",  resSeq=RING$resSeq[i], parsed.pdb, chainID=RING$chainID[i])
        xyz2 <- get.coord("CD1", resSeq=RING$resSeq[i], parsed.pdb, chainID=RING$chainID[i])
        xyz3 <- get.coord("NE1", resSeq=RING$resSeq[i], parsed.pdb, chainID=RING$chainID[i])
        xyz4 <- get.coord("CE2", resSeq=RING$resSeq[i], parsed.pdb, chainID=RING$chainID[i])
        xyz5 <- get.coord("CD2", resSeq=RING$resSeq[i], parsed.pdb, chainID=RING$chainID[i])
        RING$RC1[i] <- RingCurrent(query.xyz, xyz1=xyz1, xyz2=xyz2,
                                  xyz3=xyz3, xyz4=xyz4, xyz5=xyz5, xyz6=NULL)$gfHM
        xyz1 <- get.coord("CD2", resSeq=RING$resSeq[i], parsed.pdb, chainID=RING$chainID[i])
        xyz2 <- get.coord("CE2", resSeq=RING$resSeq[i], parsed.pdb, chainID=RING$chainID[i])
        xyz3 <- get.coord("CZ2", resSeq=RING$resSeq[i], parsed.pdb, chainID=RING$chainID[i])
        xyz4 <- get.coord("CH2", resSeq=RING$resSeq[i], parsed.pdb, chainID=RING$chainID[i])
        xyz5 <- get.coord("CZ3", resSeq=RING$resSeq[i], parsed.pdb, chainID=RING$chainID[i])
        xyz6 <- get.coord("CE3", resSeq=RING$resSeq[i], parsed.pdb, chainID=RING$chainID[i])
        RING$RC2[i] <- RingCurrent(query.xyz, xyz1=xyz1, xyz2=xyz2,
                                  xyz3=xyz3, xyz4=xyz4, xyz5=xyz5, xyz6=xyz6)$gfHM
      }; rm(i)
      # Calculating sum of the geometric factors for the given residue type:
      RING$RC1.SUM <- sum(RING$RC1)  # 5 membered
      RING$RC2.SUM <- sum(RING$RC2)  # 6 membered
    }
    ########################
  }
  
  return(RING)
}

################################################################################

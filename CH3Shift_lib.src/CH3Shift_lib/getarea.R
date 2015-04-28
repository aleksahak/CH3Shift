################################################################################
# Copyright (C) 2009+ Aleksandr B. Sahakyan (aleksahak[at]cantab.net).         #
#                                                                              #
# License: You may redistribute this source code (or its components) and/or    #
#   modify/translate it under the terms of the GNU General Public License      #
#   as published by the Free Software Foundation; version 2 of the License     #
#   (GPL2). You can find the details of GPL2 in the follwing link:             #
#   https://www.gnu.org/licenses/gpl-2.0.html                                  #
################################################################################
##  This file, given the x,y,z coordinates of a point, determines all         ##
##   the protein atoms within the specified distance from that point          ##
## INPUT: xyz - numeric vector of x, y and z coordinates.                     ##
##        parsed.pdb - parsed pdb object                                      ##
##        r - maximum distance from the point                                 ##
##                                                                            ##
## OUTPUT vicinity$dist -- distance (Angstroms)                               ##
## vicinity$resName  -- residue names (THR etc...)                            ##
## vicinity$name  -- atom names (CG1 etc...)                                  ##
## vicinity$resSeq -- sequence number                                         ##
## vicinity$ring -- "Present"/"Absent" in vicinity                            ##
################################################################################
# VERSION: 28 October, 2010 - chain vector is added in the output
# REQUIRES: "Xdist" SOURCE: "Xdist.R" topol.retrieve

getarea <- function(xyz, parsed.pdb, r, charge=FALSE, proc.topol=NULL) {

  vicinity <- NULL

  # Determining the indexes of atoms in parsed.pdb file, which are not
  # obviously far from the queried point + r area.

  ind <- which( abs(parsed.pdb$x-xyz[1])<=r &
                abs(parsed.pdb$y-xyz[2])<=r & 
                abs(parsed.pdb$z-xyz[3])<=r   )

  x <- parsed.pdb$x[ind]
  y <- parsed.pdb$y[ind]
  z <- parsed.pdb$z[ind]

  FUN.dist <- function(i) {
    P.x<-x[i]; P.y<-y[i]; P.z<-z[i]
    P.cart <- c(P.x, P.y, P.z)
    dist <- Xdist(P.cart, xyz)
    return(dist)
  }

  distances <- sapply(1:length(x), FUN.dist, simplify=TRUE)
  # 0.1 to exclude the center itself
  ToBeRemoved <- which(distances > r | distances < 0.1) 

  ind <- ind[-ToBeRemoved]   # really close atoms

  vicinity$dist    <- distances[-ToBeRemoved]
  vicinity$resName <- parsed.pdb$resName[ind]
  vicinity$name    <- parsed.pdb$name[ind]
  vicinity$resSeq  <- parsed.pdb$resSeq[ind]
  vicinity$chain   <- parsed.pdb$chainID[ind]
  if(length(unique(vicinity$chain))>1){
    vicinity$interchain <- "+"
  } else {
    vicinity$interchain <- "-"
  }

  if(charge==TRUE) {
   vicinity$charge <- NULL
   counterik <- 1
   for(indexik in ind) { 
    charge.name <- parsed.pdb$name[indexik]
    charge.resSeq <- parsed.pdb$resSeq[indexik] 
    charge.resName <- parsed.pdb$resName[indexik]

    if(charge.resName=="CYS"){charge.resName <- "CYN"} 
    if(charge.resName=="HIS"){charge.resName <- "HID"} 

    if(charge.resName!="PHE" & charge.resName!="TYR" & 
       charge.resName!="TRP" & charge.resName!="HID" &
       charge.resName!="HIE" & charge.resName!="HIP" &  
       charge.resName!="PRO" & charge.resName!="GLY" & 
       charge.resName!="ALA" & charge.resName!="ARG" & 
       charge.resName!="LYS" & charge.resName!="ASP" & 
       charge.resName!="ASN" & charge.resName!="GLU" &
       charge.resName!="GLN" & charge.resName!="SER" &  
       charge.resName!="THR" & charge.resName!="LEU" &
       charge.resName!="ILE" & charge.resName!="VAL" & 
       charge.resName!="CYS" & charge.resName!="CYN" &
       charge.resName!="CYS2" & charge.resName!="HIS" & 
       charge.resName!="MET" & charge.resName!="NTR" &
       charge.resName!="CTR") {charge.resName <- "ALIEN"}

    if(charge.name=="N" & charge.resSeq==min(parsed.pdb$resSeq)) {
      charge.resName <- "NTR"
    }
    if(charge.name=="HT1" & charge.resSeq==min(parsed.pdb$resSeq)) {
      charge.resName <- "NTR"
    }
    if(charge.name=="HT2" & charge.resSeq==min(parsed.pdb$resSeq)) {
      charge.resName <- "NTR"
    }
    if(charge.name=="HT3" & charge.resSeq==min(parsed.pdb$resSeq)) {
      charge.resName <- "NTR"
    }
    if(charge.name=="C" & charge.resSeq==max(parsed.pdb$resSeq)) {
      charge.resName <- "CTR"
    }
    if(charge.name=="OT1" & charge.resSeq==max(parsed.pdb$resSeq)) {
      charge.resName <- "CTR"
    }
    if(charge.name=="OT2" & charge.resSeq==max(parsed.pdb$resSeq)) {
      charge.resName <- "CTR"
    }
    crgik <- 0.00   # For Aliens, the charge will be set 0
    if(charge.resName!="ALIEN") {
      topik <- topol.retrieve(AmAc=charge.resName, record.variants=NULL,
                              proc.topol=proc.topol, nvar=1)
      crgik <- as.numeric(topik[which(topik[,"record"]==charge.name),"charges"])
      if(length(crgik)==0){crgik <- 0.00}
    }
    vicinity$charge[counterik] <- crgik
    counterik <- counterik+1
   }
  }
 
  return(vicinity)

}
  
################################################################################

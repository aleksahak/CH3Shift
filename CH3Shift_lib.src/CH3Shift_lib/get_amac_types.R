################################################################################
# Copyright (C) 2009+ Aleksandr B. Sahakyan (aleksahak[at]cantab.net).         #
#                                                                              #
# License: You may redistribute this source code (or its components) and/or    #
#   modify/translate it under the terms of the GNU General Public License      #
#   as published by the Free Software Foundation; version 2 of the License     #
#   (GPL2). You can find the details of GPL2 in the follwing link:             #
#   https://www.gnu.org/licenses/gpl-2.0.html                                  #
################################################################################
##   This function, given the parsed pdb file, returns a vector with          ##
## the amino acid residue sequence, where histidines and cysteins are         ##
##     correctly identified (CYN or CYS2, HIP, HID or HIE) from the           ##
##            essential hydrogen atoms present in the pdb file.               ##
##              THE PARSED PDB SHOULD BE WITH HYDROGENS !!!                   ##
##      The program returns data without separating different chains!         ##
##                 Now it also treats RNA sequence!!!                         ##
################################################################################
# VERSION: Dec 26, 2009
# PARSER: "parsed.pdb$resName", "parsed.pdb$resSeq", "parsed.pdb$chainID"

get.amac.types <- function(parsed.pdb) {

  parsed.pdb$chainID[which(parsed.pdb$chainID=="")] <- "CHAIN"
  # takes into account the chain differences as well
  parsed.pdb.length <- 1:length(parsed.pdb$resSeq)
  mrg <- function(zz) {
    return(paste(parsed.pdb$resSeq[zz],",",parsed.pdb$chainID[zz],sep=""))
  } 
  Seq <- sapply(parsed.pdb.length, mrg, simplify=TRUE)
  Seq <- unique(Seq)  # unique in terms of both chain ID and resSeq
  rm(mrg)
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
FUN <- function(Seq.line) {
  Seq.line.component <- unlist(strsplit(Seq.line, ","))
  residueSeq <- as.numeric(Seq.line.component[1])
  chainName <- as.character(Seq.line.component[2])

  ind <- which(parsed.pdb$resSeq==residueSeq)
  ind <- ind[which(parsed.pdb$chainID[ind]==chainName)]
  resName <- unique(parsed.pdb$resName[ind])
  atom.ids <- parsed.pdb$name[ind]
  ####################
  if(resName=="HIS") {  
    he2.test <- length(grep("HE2", atom.ids)) # 1 = exists, 0 = does not
    hd1.test <- length(grep("HD1", atom.ids))
    resName <- "HID"
    if(he2.test != 0 & hd1.test != 0) {  #HE2 and HD1 exist
      resName <- "HIP"
    }  
    if(he2.test != 0 & hd1.test == 0) {  #HE2 and HD1 exist
      resName <- "HIE"
    }  
  }
  ####################
  ####################
  if(resName=="CYS") {
    hg1.test <- length(grep("HG1", atom.ids)) # 1 = exists, 0 = does not
    hg.test <- length(grep("HG", atom.ids))
    if(hg1.test != 0 | hg.test != 0) {  #HG1 or HG exist
      resName <- "CYN"
    } else { 
      resName <- "CYS2"
    }  
  }
  ###################
  ###################
  if(resName=="C") {
    ribose.test <- length(grep("O2'", atom.ids)) # 1 = exists, 0 = does not
    ribose1.test <- length(grep("O2*", atom.ids))
    if(ribose.test != 0 | ribose1.test != 0) {  #O2' or O2* exist
      resName <- "RC"
    } else { 
      resName <- "DC"
    }  
  }
  ###################
  ###################
  if(resName=="G") {
    ribose.test <- length(grep("O2'", atom.ids)) # 1 = exists, 0 = does not
    ribose1.test <- length(grep("O2*", atom.ids))
    if(ribose.test != 0 | ribose1.test != 0) {  #O2' or O2* exist
      resName <- "RG"
    } else { 
      resName <- "DG"
    }  
  }
  ###################
  ###################
  if(resName=="A") {
    ribose.test <- length(grep("O2'", atom.ids)) # 1 = exists, 0 = does not
    ribose1.test <- length(grep("O2*", atom.ids))
    if(ribose.test != 0 | ribose1.test != 0) {  #O2' or O2* exist
      resName <- "RA"
    } else { 
      resName <- "DA"
    }  
  }
  ###################
  ####################
  if(resName=="U") {
    ribose.test <- length(grep("O2'", atom.ids)) # 1 = exists, 0 = does not
    ribose1.test <- length(grep("O2*", atom.ids))
    if(ribose.test != 0 | ribose1.test != 0) {  #O2' or O2* exist
      resName <- "RU"
    } else { 
      resName <- "DU"
    }  
  }
  ###################
  ###################
  if(resName=="T") {
    ribose.test <- length(grep("O2'", atom.ids)) # 1 = exists, 0 = does not
    ribose1.test <- length(grep("O2*", atom.ids))
    if(ribose.test != 0 | ribose1.test != 0) {  #O2' or O2* exist
      resName <- "RT"
    } else { 
      resName <- "DT"
    }  
  }
  ###################

  return(resName)
}
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

  return(sapply(Seq, FUN))

}

################################################################################

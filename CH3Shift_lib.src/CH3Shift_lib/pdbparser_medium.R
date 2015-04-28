################################################################################
# Copyright (C) 2009+ Aleksandr B. Sahakyan (aleksahak[at]cantab.net).         #
#                                                                              #
# License: You may redistribute this source code (or its components) and/or    #
#   modify/translate it under the terms of the GNU General Public License      #
#   as published by the Free Software Foundation; version 2 of the License     #
#   (GPL2). You can find the details of GPL2 in the follwing link:             #
#   https://www.gnu.org/licenses/gpl-2.0.html                                  #
################################################################################
# VERSION: Dec 26, 2009
# ALIAS: pdbparser.full

pdbparser.medium <- function(PDBfile) {

  PDB <- readLines(PDBfile)
 
  # At first removing some of the rows which may contain the word ATOM
  remove <- grep("REMARK", PDB, fixed=TRUE)
  if(length(c(1,remove)) > 1) { PDB <- PDB[-remove] }

  remove <- grep("CONECT", PDB, fixed=TRUE)
  if(length(c(1,remove)) > 1) { PDB <- PDB[-remove] }

  remove <- grep("SEQRES", PDB, fixed=TRUE)
  if(length(c(1,remove)) > 1) { PDB <- PDB[-remove] }

  remove <- grep("COMPND", PDB, fixed=TRUE)
  if(length(c(1,remove)) > 1) { PDB <- PDB[-remove] }
  
  remove <- grep("TITLE", PDB, fixed=TRUE)
  if(length(c(1,remove)) > 1) { PDB <- PDB[-remove] }
  
  remove <- grep("HEADER", PDB, fixed=TRUE)
  if(length(c(1,remove)) > 1) { PDB <- PDB[-remove] }

  remove <- grep("KEYWDS", PDB, fixed=TRUE)
  if(length(c(1,remove)) > 1) { PDB <- PDB[-remove] }

  remove <- grep("EXPDTA", PDB, fixed=TRUE)
  if(length(c(1,remove)) > 1) { PDB <- PDB[-remove] }

  remove <- grep("REVDAT", PDB, fixed=TRUE)
  if(length(c(1,remove)) > 1) { PDB <- PDB[-remove] }

  remove <- grep("JRNL", PDB, fixed=TRUE)
  if(length(c(1,remove)) > 1) { PDB <- PDB[-remove] }

  remove <- grep("HETATM", PDB, fixed=TRUE)
  if(length(c(1,remove)) > 1) { PDB <- PDB[-remove] }
  # # # # # # # # # # #
  
  # Filtering the rows which contain ATOM
  PDB <- PDB[grep("ATOM  ", PDB, fixed=TRUE)]

  FUN <- function(PDBline) {
    parsedPDB <- NULL
    line <- PDBline
    line <- unlist(strsplit(line,""))

    m <- line[7:11]  ; m <- m[which(m!=" ")]
    parsedPDB$serial  <- as.numeric(paste(m,collapse=""))
    m <- line[13:16] ; m <- m[which(m!=" ")]
    parsedPDB$name    <- as.character(paste(m,collapse=""))
    m <- line[17]    ; m <- m[which(m!=" ")]
    parsedPDB$altLoc  <- as.character(paste(m,collapse=""))
    m <- line[18:20] ; m <- m[which(m!=" ")]
    parsedPDB$resName <- as.character(paste(m,collapse=""))
    m <- line[22]    ; m <- m[which(m!=" ")]
    parsedPDB$chainID <- as.character(paste(m,collapse=""))
    m <- line[23:26] ; m <- m[which(m!=" ")]
    parsedPDB$resSeq  <- as.numeric(paste(m,collapse=""))
    m <- line[27]    ; m <- m[which(m!=" ")]
    parsedPDB$iCode   <- as.character(paste(m,collapse=""))
    m <- line[31:38] ; m <- m[which(m!=" ")]
    parsedPDB$x       <- as.numeric(paste(m,collapse=""))
    m <- line[39:46] ; m <- m[which(m!=" ")]
    parsedPDB$y       <- as.numeric(paste(m,collapse=""))
    m <- line[47:54] ; m <- m[which(m!=" ")]
    parsedPDB$z       <- as.numeric(paste(m,collapse=""))
    m <- line[55:60] ; m <- m[which(m!=" ")]
    parsedPDB$occupancy <- as.character(paste(m,collapse=""))
    m <- line[61:66] ; m <- m[which(m!=" ")]
    parsedPDB$tempFactor <- as.numeric(paste(m,collapse=""))
    m <- line[77:78] ; m <- m[which(m!=" ")]
    parsedPDB$element <- as.character(paste(m,collapse=""))
    m <- line[79:80] ; m <- m[which(m!=" ")]
    parsedPDB$charge  <- as.numeric(paste(m,collapse=""))
  
  return(parsedPDB)
}

  parsedPDB <- NULL
  intmd <- sapply(PDB, FUN, simplify=TRUE, USE.NAMES=FALSE)
  parsedPDB$serial <- unlist(intmd["serial",])
  parsedPDB$name   <- unlist(intmd["name",])
  parsedPDB$altLoc   <- unlist(intmd["altLoc",])
  parsedPDB$chainID   <- unlist(intmd["chainID",])
  parsedPDB$iCode   <- unlist(intmd["iCode",])
  parsedPDB$occupancy   <- unlist(intmd["occupancy",])
  parsedPDB$tempFactor   <- unlist(intmd["tempFactor",])
  parsedPDB$charge   <- unlist(intmd["charge",])
  parsedPDB$resName <- unlist(intmd["resName",])
  parsedPDB$resSeq <- unlist(intmd["resSeq",])
  parsedPDB$x <- unlist(intmd["x",])
  parsedPDB$y <- unlist(intmd["y",])
  parsedPDB$z <- unlist(intmd["z",])
  parsedPDB$element <- unlist(intmd["element",])

  # if the casset is vacant, adds CHAIN as chainID
  parsedPDB$chainID[which(parsedPDB$chainID=="")] <- "CHAIN"
  return(parsedPDB)
}

################################################################################

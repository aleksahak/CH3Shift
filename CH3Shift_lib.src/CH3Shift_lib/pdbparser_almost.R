################################################################################
# Copyright (C) 2009+ Aleksandr B. Sahakyan (aleksahak[at]cantab.net).         #
#                                                                              #
# License: You may redistribute this source code (or its components) and/or    #
#   modify/translate it under the terms of the GNU General Public License      #
#   as published by the Free Software Foundation; version 2 of the License     #
#   (GPL2). You can find the details of GPL2 in the follwing link:             #
#   https://www.gnu.org/licenses/gpl-2.0.html                                  #
################################################################################
# ALIAS: pdbparser.full.almost

pdbparser.almost <- function(PDBfile) {

  PDB <- readLines(PDBfile)

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
    # altLoc is always taken as A (first of them => vacant altLoc)
    m <- line[18:20] ; m <- m[which(m!=" ")]
    parsedPDB$resName <- as.character(paste(m,collapse=""))
    m <- line[23:26] ; m <- m[which(m!=" ")]
    parsedPDB$resSeq  <- as.numeric(paste(m,collapse=""))
    m <- line[31:38] ; m <- m[which(m!=" ")]
    parsedPDB$x       <- as.numeric(paste(m,collapse=""))
    m <- line[39:46] ; m <- m[which(m!=" ")]
    parsedPDB$y       <- as.numeric(paste(m,collapse=""))
    m <- line[47:54] ; m <- m[which(m!=" ")]
    parsedPDB$z       <- as.numeric(paste(m,collapse=""))
    m <- line[74:76]    ; m <- m[which(m!=" ")]
    parsedPDB$chainID <- as.character(paste(m,collapse=""))
  return(parsedPDB)
}

  parsedPDB <- NULL
  intmd <- sapply(PDB, FUN, simplify=TRUE, USE.NAMES=FALSE)
  parsedPDB$serial <- unlist(intmd["serial",])
  parsedPDB$name   <- unlist(intmd["name",])
  parsedPDB$chainID   <- unlist(intmd["chainID",])
  parsedPDB$resName <- unlist(intmd["resName",])
  parsedPDB$resSeq <- unlist(intmd["resSeq",])
  parsedPDB$x <- unlist(intmd["x",])
  parsedPDB$y <- unlist(intmd["y",])
  parsedPDB$z <- unlist(intmd["z",])
 
  return(parsedPDB)
}

################################################################################

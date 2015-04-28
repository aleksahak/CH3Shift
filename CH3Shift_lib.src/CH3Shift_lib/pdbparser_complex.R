################################################################################
# Copyright (C) 2009+ Aleksandr B. Sahakyan (aleksahak[at]cantab.net).         #
#                                                                              #
# License: You may redistribute this source code (or its components) and/or    #
#   modify/translate it under the terms of the GNU General Public License      #
#   as published by the Free Software Foundation; version 2 of the License     #
#   (GPL2). You can find the details of GPL2 in the follwing link:             #
#   https://www.gnu.org/licenses/gpl-2.0.html                                  #
################################################################################
## PDB parser, which parses complete data as pdbparser.full, aditionally      ##
## differentiating and storing HETATM, RNA, DNA and PROTEIN data into         ##
##  the corresponding extension of the resulting object (for instance:        ##
##  parsedPDB$DNA). The base of the object (parsedPDB) still holds all        ##
##   the records with the type ATOM, which makes this modification be         ##
##    completely compatible with pdbparser.full or other variations.          ##
################################################################################
# VERSION: 18 Aug, 2011 (PROTEINremoveQname is added)
# ALIAS: pdbparser.differ

pdbparser.complex <- function(PDBfile, PROTEINremoveQname=TRUE) {

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

  remove <- grep("SOURCE", PDB, fixed=TRUE)
  if(length(c(1,remove)) > 1) { PDB <- PDB[-remove] }

  remove <- grep("MDLTYP", PDB, fixed=TRUE)
  if(length(c(1,remove)) > 1) { PDB <- PDB[-remove] }

  remove <- grep("AUTHOR", PDB, fixed=TRUE)
  if(length(c(1,remove)) > 1) { PDB <- PDB[-remove] }

  remove <- grep("DBREF", PDB, fixed=TRUE)
  if(length(c(1,remove)) > 1) { PDB <- PDB[-remove] }

  remove <- grep("MODRES", PDB, fixed=TRUE)
  if(length(c(1,remove)) > 1) { PDB <- PDB[-remove] }

  remove <- grep("HETNAM", PDB, fixed=TRUE)
  if(length(c(1,remove)) > 1) { PDB <- PDB[-remove] }

  remove <- grep("FORMUL", PDB, fixed=TRUE)
  if(length(c(1,remove)) > 1) { PDB <- PDB[-remove] }

  remove <- grep("LINK   ", PDB, fixed=TRUE)
  if(length(c(1,remove)) > 1) { PDB <- PDB[-remove] }

  remove <- grep("HET  ", PDB, fixed=TRUE)
  if(length(c(1,remove)) > 1) { PDB <- PDB[-remove] }

  remove <- grep("CRYST1", PDB, fixed=TRUE)
  if(length(c(1,remove)) > 1) { PDB <- PDB[-remove] }

  remove <- grep("SCALE", PDB, fixed=TRUE)
  if(length(c(1,remove)) > 1) { PDB <- PDB[-remove] }

  remove <- grep("ORIGX", PDB, fixed=TRUE)
  if(length(c(1,remove)) > 1) { PDB <- PDB[-remove] }


  # identifiers of pdb lines containing ATOM
  ATOM.ids <- grep("ATOM ", PDB, fixed=TRUE)
  ATOM.ids <- ATOM.ids[order(ATOM.ids)]   # ordering as ascending
  ATOM.ids <- ATOM.ids[which(!is.na(ATOM.ids))]
  
  # AMAC.ids = pdb lines containing Amino Acids of type ATOM 
  PHE.ids <- grep("PHE", PDB, fixed=TRUE)
  TYR.ids <- grep("TYR", PDB, fixed=TRUE)
  TRP.ids <- grep("TRP", PDB, fixed=TRUE)
  HIS.ids <- grep("HIS", PDB, fixed=TRUE)
  PRO.ids <- grep("PRO", PDB, fixed=TRUE)
  GLY.ids <- grep("GLY", PDB, fixed=TRUE)
  ALA.ids <- grep("ALA", PDB, fixed=TRUE)
  ARG.ids <- grep("ARG", PDB, fixed=TRUE)
  LYS.ids <- grep("LYS", PDB, fixed=TRUE)
  ASP.ids <- grep("ASP", PDB, fixed=TRUE)
  ASN.ids <- grep("ASN", PDB, fixed=TRUE)
  GLU.ids <- grep("GLU", PDB, fixed=TRUE)
  GLN.ids <- grep("GLN", PDB, fixed=TRUE)
  SER.ids <- grep("SER", PDB, fixed=TRUE)
  THR.ids <- grep("THR", PDB, fixed=TRUE)
  LEU.ids <- grep("LEU", PDB, fixed=TRUE)
  ILE.ids <- grep("ILE", PDB, fixed=TRUE)
  VAL.ids <- grep("VAL", PDB, fixed=TRUE)
  CYS.ids <- grep("CYS", PDB, fixed=TRUE)
  MET.ids <- grep("MET", PDB, fixed=TRUE)
  AMAC.ids <- c(PHE.ids,TYR.ids,TRP.ids,HIS.ids,PRO.ids,
                GLY.ids,ALA.ids,ARG.ids,LYS.ids,ASP.ids,
                ASN.ids,GLU.ids,GLN.ids,SER.ids,THR.ids,
                LEU.ids,ILE.ids,VAL.ids,CYS.ids,MET.ids) 
  # Many of the found records will actually be from non-ATOM lines,
  # still survived in the file => further actions to assure ATOM-ity:
  if(length(AMAC.ids)!=0) {
    AMAC.ids <- ATOM.ids[match(AMAC.ids, ATOM.ids)]
    AMAC.ids <- AMAC.ids[order(AMAC.ids)]   # ordering as ascending
    AMAC.ids <- AMAC.ids[which(!is.na(AMAC.ids))]
  }
 
  # Filtering the rows which contain ATOM
  PDB.ATOM <- PDB[ATOM.ids]
 
  # # # # # # # # # # #
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
  # # # # # # # # # # #
  
  # Parsed PDB from only ATOMS. These data will be parsed in the general
  # object parsed.PDB, in order to be compatible with other scripts, 
  # written before.
  parsedPDB <- NULL
  intmd <- sapply(PDB.ATOM, FUN, simplify=TRUE, USE.NAMES=FALSE)
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
  rm(intmd)


  # Filtering the rows which contain PROTEIN data
  PDB.PROTEIN <- PDB[AMAC.ids]
  if(length(PDB.PROTEIN)!=0){
    # parsed PDB from only PROTEIN data
    parsedPDB$PROTEIN <- NULL
    intmd <- sapply(PDB.PROTEIN, FUN, simplify=TRUE, USE.NAMES=FALSE)
    parsedPDB$PROTEIN$serial <- unlist(intmd["serial",])
    parsedPDB$PROTEIN$name   <- unlist(intmd["name",])
    parsedPDB$PROTEIN$altLoc   <- unlist(intmd["altLoc",])
    parsedPDB$PROTEIN$chainID   <- unlist(intmd["chainID",])
    parsedPDB$PROTEIN$iCode   <- unlist(intmd["iCode",])
    parsedPDB$PROTEIN$occupancy   <- unlist(intmd["occupancy",])
    parsedPDB$PROTEIN$tempFactor   <- unlist(intmd["tempFactor",])
    parsedPDB$PROTEIN$charge   <- unlist(intmd["charge",])
    parsedPDB$PROTEIN$resName <- unlist(intmd["resName",])
    parsedPDB$PROTEIN$resSeq <- unlist(intmd["resSeq",])
    parsedPDB$PROTEIN$x <- unlist(intmd["x",])
    parsedPDB$PROTEIN$y <- unlist(intmd["y",])
    parsedPDB$PROTEIN$z <- unlist(intmd["z",])
    parsedPDB$PROTEIN$element <- unlist(intmd["element",])
    rm(intmd)
    #-- removing residue names starting with Q (QD1, QE, etc..)
    if(PROTEINremoveQname==TRUE){
      Qind <- grep("Q", parsedPDB$PROTEIN$name)
      if(length(Qind)>0){
        parsedPDB$PROTEIN$serial     <- parsedPDB$PROTEIN$serial[-Qind]
        parsedPDB$PROTEIN$name       <- parsedPDB$PROTEIN$name[-Qind]
        parsedPDB$PROTEIN$altLoc     <- parsedPDB$PROTEIN$altLoc[-Qind]
        parsedPDB$PROTEIN$chainID    <- parsedPDB$PROTEIN$chainID[-Qind]
        parsedPDB$PROTEIN$iCode      <- parsedPDB$PROTEIN$iCode[-Qind]
        parsedPDB$PROTEIN$occupancy  <- parsedPDB$PROTEIN$occupancy[-Qind]
        parsedPDB$PROTEIN$tempFactor <- parsedPDB$PROTEIN$tempFactor[-Qind]
        parsedPDB$PROTEIN$charge     <- parsedPDB$PROTEIN$charge[-Qind]
        parsedPDB$PROTEIN$resName    <- parsedPDB$PROTEIN$resName[-Qind]
        parsedPDB$PROTEIN$resSeq     <- parsedPDB$PROTEIN$resSeq[-Qind]
        parsedPDB$PROTEIN$x          <- parsedPDB$PROTEIN$x[-Qind]
        parsedPDB$PROTEIN$y          <- parsedPDB$PROTEIN$y[-Qind]
        parsedPDB$PROTEIN$z          <- parsedPDB$PROTEIN$z[-Qind]
        parsedPDB$PROTEIN$element    <- parsedPDB$PROTEIN$element[-Qind]
      }
    }
    #--

  } else {
    parsedPDB$PROTEIN <- NA
  }
  # # # # # # # # # # # # # # # # # # # # # # # # #

  # Filtering the rows which contain HETATM
  PDB.HETATM <- PDB[grep("HETATM", PDB, fixed=TRUE)]
  if(length(PDB.HETATM)!=0){
    # parsed PDB from only HETATM data
    parsedPDB$HETATM <- NULL
    intmd <- sapply(PDB.HETATM, FUN, simplify=TRUE, USE.NAMES=FALSE)
    parsedPDB$HETATM$serial <- unlist(intmd["serial",])
    parsedPDB$HETATM$name   <- unlist(intmd["name",])
    parsedPDB$HETATM$altLoc   <- unlist(intmd["altLoc",])
    parsedPDB$HETATM$chainID   <- unlist(intmd["chainID",])
    parsedPDB$HETATM$iCode   <- unlist(intmd["iCode",])
    parsedPDB$HETATM$occupancy   <- unlist(intmd["occupancy",])
    parsedPDB$HETATM$tempFactor   <- unlist(intmd["tempFactor",])
    parsedPDB$HETATM$charge   <- unlist(intmd["charge",])
    parsedPDB$HETATM$resName <- unlist(intmd["resName",])
    parsedPDB$HETATM$resSeq <- unlist(intmd["resSeq",])
    parsedPDB$HETATM$x <- unlist(intmd["x",])
    parsedPDB$HETATM$y <- unlist(intmd["y",])
    parsedPDB$HETATM$z <- unlist(intmd["z",])
    parsedPDB$HETATM$element <- unlist(intmd["element",])
    rm(intmd)
  } else {
    parsedPDB$HETATM <- NA
  }
  # # # # # # # # # # # # # # # # # # # # # # # # #

  # Parsing PDB from only RNA data
  RNA.ind <- which(parsedPDB$resName=="A" | parsedPDB$resName=="G" |
                   parsedPDB$resName=="U"  | parsedPDB$resName=="C")
  RNA.ind <- RNA.ind[order(RNA.ind)]   # ordering as ascending
  RNA.ind <- RNA.ind[which(!is.na(RNA.ind))]
  if(length(RNA.ind)!=0){
    # parsed PDB from only HETATM data
    parsedPDB$RNA <- NULL
    parsedPDB$RNA$serial <- parsedPDB$serial[RNA.ind]
    parsedPDB$RNA$name   <- parsedPDB$name[RNA.ind]
    parsedPDB$RNA$altLoc   <- parsedPDB$altLoc[RNA.ind]
    parsedPDB$RNA$chainID   <- parsedPDB$chainID[RNA.ind]
    parsedPDB$RNA$iCode   <- parsedPDB$iCode[RNA.ind]
    parsedPDB$RNA$occupancy   <- parsedPDB$occupancy[RNA.ind]
    parsedPDB$RNA$tempFactor   <- parsedPDB$tempFactor[RNA.ind]
    parsedPDB$RNA$charge   <- parsedPDB$charge[RNA.ind]
    parsedPDB$RNA$resName <- parsedPDB$resName[RNA.ind]
    parsedPDB$RNA$resSeq <- parsedPDB$resSeq[RNA.ind]
    parsedPDB$RNA$x <- parsedPDB$x[RNA.ind]
    parsedPDB$RNA$y <- parsedPDB$y[RNA.ind]
    parsedPDB$RNA$z <- parsedPDB$z[RNA.ind]
    parsedPDB$RNA$element <- parsedPDB$element[RNA.ind]
  } else {
    parsedPDB$RNA <- NA
  }
  # # # # # # # # # # # # # # # # # # # # # # # # #

  # Parsing PDB from only DNA data
  DNA.ind <- which(parsedPDB$resName=="DA" | parsedPDB$resName=="DG" |
                   parsedPDB$resName=="DT"  | parsedPDB$resName=="DC")
  DNA.ind <- DNA.ind[order(DNA.ind)]   # ordering as ascending
  DNA.ind <- DNA.ind[which(!is.na(DNA.ind))]
  if(length(DNA.ind)!=0){
    # parsed PDB from only HETATM data
    parsedPDB$DNA <- NULL
    parsedPDB$DNA$serial <- parsedPDB$serial[DNA.ind]
    parsedPDB$DNA$name   <- parsedPDB$name[DNA.ind]
    parsedPDB$DNA$altLoc <- parsedPDB$altLoc[DNA.ind]
    parsedPDB$DNA$chainID <- parsedPDB$chainID[DNA.ind]
    parsedPDB$DNA$iCode   <- parsedPDB$iCode[DNA.ind]
    parsedPDB$DNA$occupancy  <- parsedPDB$occupancy[DNA.ind]
    parsedPDB$DNA$tempFactor <- parsedPDB$tempFactor[DNA.ind]
    parsedPDB$DNA$charge   <- parsedPDB$charge[DNA.ind]
    parsedPDB$DNA$resName <- parsedPDB$resName[DNA.ind]
    parsedPDB$DNA$resSeq <- parsedPDB$resSeq[DNA.ind]
    parsedPDB$DNA$x <- parsedPDB$x[DNA.ind]
    parsedPDB$DNA$y <- parsedPDB$y[DNA.ind]
    parsedPDB$DNA$z <- parsedPDB$z[DNA.ind]
    parsedPDB$DNA$element <- parsedPDB$element[DNA.ind]
  } else {
    parsedPDB$DNA <- NA
  }
  # # # # # # # # # # # # # # # # # # # # # # # # #

  # if the casset is vacant, adds CHAIN as chainID
  parsedPDB$chainID[which(parsedPDB$chainID=="")] <- "CHAIN"
  return(parsedPDB)
}

################################################################################

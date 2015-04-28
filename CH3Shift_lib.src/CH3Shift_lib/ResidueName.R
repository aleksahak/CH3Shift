################################################################################
# Copyright (C) 2009+ Aleksandr B. Sahakyan (aleksahak[at]cantab.net).         #
#                                                                              #
# License: You may redistribute this source code (or its components) and/or    #
#   modify/translate it under the terms of the GNU General Public License      #
#   as published by the Free Software Foundation; version 2 of the License     #
#   (GPL2). You can find the details of GPL2 in the follwing link:             #
#   https://www.gnu.org/licenses/gpl-2.0.html                                  #
################################################################################
## This function takes a vector of residue names, and returns a vector        ##
##    with the same order but with capitalized (capitalize=TRUE), or          ##
## 3-letter (letter3 = TRUE) or 1-letter (letter1 = TRUE) conventions.        ##
################################################################################

ResidueName <- function(resName.vec, capitalize=FALSE, threeletter=FALSE,
                                                     oneletter = FALSE) {
 
  if(capitalize==TRUE) {
    capitalizer <- function(residue.chr) {
     residue.chr.mod <- "XXX"
     if(residue.chr=="Ala" | residue.chr=="A") { residue.chr.mod <- "ALA" } 
     if(residue.chr=="Arg" | residue.chr=="R") { residue.chr.mod <- "ARG" }
     if(residue.chr=="Asn" | residue.chr=="N") { residue.chr.mod <- "ASN" } 
     if(residue.chr=="Asp" | residue.chr=="D") { residue.chr.mod <- "ASP" } 
     if(residue.chr=="Cys" | residue.chr=="C") { residue.chr.mod <- "CYS" }
     if(residue.chr=="Gln" | residue.chr=="Q") { residue.chr.mod <- "GLN" } 
     if(residue.chr=="Glu" | residue.chr=="E") { residue.chr.mod <- "GLU" }
     if(residue.chr=="Gly" | residue.chr=="G") { residue.chr.mod <- "GLY" } 
     if(residue.chr=="His" | residue.chr=="H") { residue.chr.mod <- "HIS" }
     if(residue.chr=="Ile" | residue.chr=="I") { residue.chr.mod <- "ILE" } 
     if(residue.chr=="Leu" | residue.chr=="L") { residue.chr.mod <- "LEU" }
     if(residue.chr=="Lys" | residue.chr=="K") { residue.chr.mod <- "LYS" } 
     if(residue.chr=="Met" | residue.chr=="M") { residue.chr.mod <- "MET" }
     if(residue.chr=="Phe" | residue.chr=="F") { residue.chr.mod <- "PHE" } 
     if(residue.chr=="Pro" | residue.chr=="P") { residue.chr.mod <- "PRO" }
     if(residue.chr=="Val" | residue.chr=="V") { residue.chr.mod <- "VAL" } 
     if(residue.chr=="Ser" | residue.chr=="S") { residue.chr.mod <- "SER" }
     if(residue.chr=="Thr" | residue.chr=="T") { residue.chr.mod <- "THR" } 
     if(residue.chr=="Tyr" | residue.chr=="Y") { residue.chr.mod <- "TYR" }
     if(residue.chr=="Trp" | residue.chr=="W") { residue.chr.mod <- "TRP" } 
     return(residue.chr.mod)
    }
    result <- sapply(resName.vec, capitalizer, simplify=TRUE)
    return(as.vector(result))
  }


  if(oneletter==TRUE) {
    oneletter <- function(residue.chr) {
     residue.chr.mod <- "X"
     if(residue.chr=="ALA" | residue.chr=="Ala") { residue.chr.mod <- "A" } 
     if(residue.chr=="ARG" | residue.chr=="Arg") { residue.chr.mod <- "R" }
     if(residue.chr=="ASN" | residue.chr=="Asn") { residue.chr.mod <- "N" } 
     if(residue.chr=="ASP" | residue.chr=="Asp") { residue.chr.mod <- "D" } 
     if(residue.chr=="CYS" | residue.chr=="Cys") { residue.chr.mod <- "C" }
     if(residue.chr=="GLN" | residue.chr=="Gln") { residue.chr.mod <- "Q" } 
     if(residue.chr=="GLU" | residue.chr=="Glu") { residue.chr.mod <- "E" }
     if(residue.chr=="GLY" | residue.chr=="Gly") { residue.chr.mod <- "G" } 
     if(residue.chr=="HIS" | residue.chr=="His") { residue.chr.mod <- "H" }
     if(residue.chr=="ILE" | residue.chr=="Ile") { residue.chr.mod <- "I" } 
     if(residue.chr=="LEU" | residue.chr=="Leu") { residue.chr.mod <- "L" }
     if(residue.chr=="LYS" | residue.chr=="Lys") { residue.chr.mod <- "K" } 
     if(residue.chr=="MET" | residue.chr=="Met") { residue.chr.mod <- "M" }
     if(residue.chr=="PHE" | residue.chr=="Phe") { residue.chr.mod <- "F" } 
     if(residue.chr=="PRO" | residue.chr=="Pro") { residue.chr.mod <- "P" }
     if(residue.chr=="VAL" | residue.chr=="Val") { residue.chr.mod <- "V" } 
     if(residue.chr=="SER" | residue.chr=="Ser") { residue.chr.mod <- "S" }
     if(residue.chr=="THR" | residue.chr=="Thr") { residue.chr.mod <- "T" } 
     if(residue.chr=="TYR" | residue.chr=="Tyr") { residue.chr.mod <- "Y" }
     if(residue.chr=="TRP" | residue.chr=="Trp") { residue.chr.mod <- "W" } 
     return(residue.chr.mod)
    }
    result <- sapply(resName.vec, oneletter, simplify=TRUE)
    return(as.vector(result))
  }


  if(threeletter==TRUE) {
    threeletter <- function(residue.chr) {
     residue.chr.mod <- "Xxx"
     if(residue.chr=="ALA" | residue.chr=="A") { residue.chr.mod <- "Ala" } 
     if(residue.chr=="ARG" | residue.chr=="R") { residue.chr.mod <- "Arg" }
     if(residue.chr=="ASN" | residue.chr=="N") { residue.chr.mod <- "Asn" } 
     if(residue.chr=="ASP" | residue.chr=="D") { residue.chr.mod <- "Asp" } 
     if(residue.chr=="CYS" | residue.chr=="C") { residue.chr.mod <- "Cys" }
     if(residue.chr=="GLN" | residue.chr=="Q") { residue.chr.mod <- "Gln" } 
     if(residue.chr=="GLU" | residue.chr=="E") { residue.chr.mod <- "Glu" }
     if(residue.chr=="GLY" | residue.chr=="G") { residue.chr.mod <- "Gly" } 
     if(residue.chr=="HIS" | residue.chr=="H") { residue.chr.mod <- "His" }
     if(residue.chr=="ILE" | residue.chr=="I") { residue.chr.mod <- "Ile" } 
     if(residue.chr=="LEU" | residue.chr=="L") { residue.chr.mod <- "Leu" }
     if(residue.chr=="LYS" | residue.chr=="K") { residue.chr.mod <- "Lys" } 
     if(residue.chr=="MET" | residue.chr=="M") { residue.chr.mod <- "Met" }
     if(residue.chr=="PHE" | residue.chr=="F") { residue.chr.mod <- "Phe" } 
     if(residue.chr=="PRO" | residue.chr=="P") { residue.chr.mod <- "Pro" }
     if(residue.chr=="VAL" | residue.chr=="V") { residue.chr.mod <- "Val" } 
     if(residue.chr=="SER" | residue.chr=="S") { residue.chr.mod <- "Ser" }
     if(residue.chr=="THR" | residue.chr=="T") { residue.chr.mod <- "Thr" } 
     if(residue.chr=="TYR" | residue.chr=="Y") { residue.chr.mod <- "Tyr" }
     if(residue.chr=="TRP" | residue.chr=="W") { residue.chr.mod <- "Trp" } 
     return(residue.chr.mod)
    }
    result <- sapply(resName.vec, threeletter, simplify=TRUE)
    return(as.vector(result))
  }
}

################################################################################

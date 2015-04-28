################################################################################
# Copyright (C) 2009+ Aleksandr B. Sahakyan (aleksahak[at]cantab.net).         #
#                                                                              #
# License: You may redistribute this source code (or its components) and/or    #
#   modify/translate it under the terms of the GNU General Public License      #
#   as published by the Free Software Foundation; version 2 of the License     #
#   (GPL2). You can find the details of GPL2 in the follwing link:             #
#   https://www.gnu.org/licenses/gpl-2.0.html                                  #
################################################################################
##  This script given the AmAc - residue name ("MET","RU"...) and the         ##
## object after the application of the function "pdbProc(parsed.pdb)"         ##
##   (such as "record.variants") returns the corresponding topology           ##
##                                 matrix.                                    ##
##  To reduce computational time, the processed topology can also be          ##
## provided (by default proc.topol=NULL, and the topology will be read)       ##
## nvar variable can explicitely take the variant number (for NTR/CTR).       ##
################################################################################
# VERSION: Dec 26, 2009
# REQUIRES: "topology.lib"
  
topol.retrieve <- function(AmAc, record.variants,
                                           proc.topol=NULL, nvar=NULL){

  if(length(proc.topol)==0) {
    proc.topol <- readLines( paste(LIB,"topology.lib",sep="") )
    proc.topol <- proc.topol[-grep("#", proc.topol)]
    proc.topol <- lapply(proc.topol, linesplit)
  }  
    
  subtop <- proc.topol[which(sapply(proc.topol, "[", 1)==AmAc)]

  if(length(nvar)==0) {
    nvar <- 
     record.variants$variant[which(record.variants$residue.types==AmAc)]
  }

  record <- sapply(subtop, "[", 3+nvar)
  record[which(record=="-")] <-sapply(subtop, "[", 4)[which(record=="-")]
  residues <- sapply(subtop, "[", 1)
  amber.id <- sapply(subtop, "[", 2)
  charges <- sapply(subtop, "[", 3)
  topology.mx <- cbind(residues, amber.id, charges, record)
  # removing dummy rows with BLABLABLA as amber.id
  dummy.ind <- which(topology.mx[,"amber.id"]=="BLABLABLA")
  if(length(dummy.ind) != 0 ) { 
    topology.mx <- topology.mx[-dummy.ind, ]
  }
  return(topology.mx)
}  

################################################################################

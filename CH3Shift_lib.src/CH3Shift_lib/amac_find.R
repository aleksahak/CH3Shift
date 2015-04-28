################################################################################
# Copyright (C) 2009+ Aleksandr B. Sahakyan (aleksahak[at]cantab.net).         #
#                                                                              #
# License: You may redistribute this source code (or its components) and/or    #
#   modify/translate it under the terms of the GNU General Public License      #
#   as published by the Free Software Foundation; version 2 of the License     #
#   (GPL2). You can find the details of GPL2 in the follwing link:             #
#   https://www.gnu.org/licenses/gpl-2.0.html                                  #
################################################################################
## This function requires the parsed pdb object created by "pdbparser"        ##
## style functions and the 3 capital letter idendifier of the residue         ##
## type. As a result, the function returns an object containing an in-        ##
## formation on the location and existance of the queried residue type.       ##
################################################################################
# VERSION: 28 October 2010, added chain specificity and the retrieval
#                           of $chainID information
# REQUIRES: "is.integer0" SOURCE: "is_integer0.R" 
# PARSER: "parsed.pdb$resName", "parsed.pdb$resSeq"
# OUTPUT structure:
# amac.data$resName - the enquired type of amino acid residue
# amac.data$num - number of the queried amino acid residues in the protein 
# amac.data$resSeq - sequence number of the residues (NULL if num=0).
# amac.data$info - prints information on the query 

amac.find <- function(parsed.pdb, AmAc) {
  amac.data <- NULL
  amac.data$resName <- AmAc
  ind <- which(parsed.pdb$resName==AmAc)

  if(is.integer0(ind)==FALSE) {
    chainids <- parsed.pdb$chainID[ind]
    seqns    <- parsed.pdb$resSeq[ind]
    chainids.seqns <- paste(chainids,seqns, sep="_") 
    chainids.seqns <- unique(chainids.seqns)
    chainids.seqns <- unlist(strsplit(chainids.seqns,"_"))    

    amac.data$resSeq  <- as.numeric(chainids.seqns[seq(from=2, to=length(chainids.seqns), by=2)])
    amac.data$chainID <- chainids.seqns[seq(from=1, to=length(chainids.seqns), by=2)]
    amac.data$num     <- length(amac.data$resSeq)

  } else {   
    amac.data$resSeq  <- NULL
    amac.data$chainID <- NULL
    amac.data$num     <- 0
  }
  amac.data$info <- paste("The protein contains ", amac.data$num, " ",
                            AmAc," residues.",sep="")
  return(amac.data)
}

################################################################################

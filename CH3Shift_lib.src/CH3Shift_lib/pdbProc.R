################################################################################
# Copyright (C) 2009+ Aleksandr B. Sahakyan (aleksahak[at]cantab.net).         #
#                                                                              #
# License: You may redistribute this source code (or its components) and/or    #
#   modify/translate it under the terms of the GNU General Public License      #
#   as published by the Free Software Foundation; version 2 of the License     #
#   (GPL2). You can find the details of GPL2 in the follwing link:             #
#   https://www.gnu.org/licenses/gpl-2.0.html                                  #
################################################################################
##     This script takes the parsed pdb object and determines which           ##
##  variants of the records should be used from the topology.lib file.        ##
##                 Should be used for atom assignments.                       ##
################################################################################
# VERSION: Aug 18, 2011
# REQUIRES: "linesplit" SOURCE: "linesplit.R"
# REQUIRES: "get.amac.types" SOURCE: "get_amac_types.R" 
# REQUIRES: "topology.lib"
# PARSER: "parsed.pdb$resName", "parsed.pdb$resSeq", parsed.pdb$name
# OUTPUT structure:
# $variant - variants of topology records for each of the $residue.types
# $residue.types - types of the residue
# $residue.seq - the complete sequence of the protein with type correction

pdbProc <- function(parsed.pdb, topology=NULL) { 
  if(length(topology)==0){
    topology <- readLines( paste(LIB,"topology.lib",sep="") )
    topology <- topology[-grep("#", topology)]
    topology <- lapply(topology, linesplit)
  }
  # retrieving all the records
  RECORDS <- sapply(topology, "[", 1)
  RECORDS <- unique(RECORDS[!is.na(RECORDS)])

  amac.seq <- get.amac.types(parsed.pdb)
  AmAc <- unique(amac.seq)

  matched <- match(AmAc, RECORDS)
  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
  if( length(which(is.na(matched)==TRUE)) > 0) {
    print("### ERROR: non standard amino acid residue exists.###")
    print("###            Check the PDB file!                ###")
  } else {
   
    record.variants <- NULL
    record.variants$residue.types <- AmAc
    record.variants$residue.seq <- amac.seq
    for(i in AmAc) {
      ##################################
      # finding a single resSeq, which has the aminoacid "i"
      positionINamac.seq <- which(amac.seq==i)[1]
      SeqChain.data <- unlist(strsplit(names(positionINamac.seq),","))
      resSeq <- as.numeric(SeqChain.data[1])
      chainName <- as.character(SeqChain.data[2])
      # retrieving the atom ids
      pdb.atom.id <- parsed.pdb$name[which(parsed.pdb$resSeq==resSeq &
                                           parsed.pdb$chainID==chainName)]
      # topology records for the aminoacid "i"
      subtop <- topology[which(sapply(topology, "[", 1)==i)]
      # number of naming variants
      N.variants <- length(subtop[[1]])-3
      for(nvar in 1:N.variants) {
        matched.variant <- "ERROR" # until a match is found
        atom.id <- sapply(subtop, "[", 3+nvar)
        # if "-", recovering the first record-column for the entry
        atom.id[which(atom.id=="-")] <- sapply(subtop, "[", 4)[which(atom.id=="-")]
        # removing possible edges for accounting terminal residues as well in another code
        atom.id.trimmed <- atom.id[3:(length(atom.id)-2)]
        if(length(which(is.na(match(atom.id.trimmed, pdb.atom.id))==TRUE)) == 0){
          matched.variant <- nvar; break
        }
      }
       # In Proteininc records first and second types only differ by NH - H
       # which are not accounted in matching (see the trimming above) =>
       if( length(which(parsed.pdb$name=="HN")) == 0 & # in the pdb file the amino acid residues are not of the first type 
           i!="PRO" &                                  #  which does not refer to the Proline residue, which anyway does not have H(N)
           i!="RC"  & i!="DC"  &
           i!="RG"  & i!="DG"  &
           i!="RA"  & i!="DA"  &    # i is not nucleic acid  PAY ATTENTION TO THIS LIST
           i!="RU"  & i!="DU"  &    #                   WHEN TOPOLOGY FILE IS UPDATED!!!
           i!="RT"  & i!="DT"  &
           matched.variant==1   ) {
        matched.variant <- 2
       }

     record.variants$variant <- c(record.variants$variant, matched.variant)
    }
    ##################################
  }
  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

  if(length(which(record.variants$variant=="ERROR")) == 0) {
    return(record.variants)
  } else {
    print("###    ERROR: full correspondence is missing.     ###")
    print("###     Check the PDB and topology.lib files!      ###")
    print(record.variants)
    return("ERROR")
  }

}

################################################################################

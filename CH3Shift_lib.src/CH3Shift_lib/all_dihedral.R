################################################################################
# Copyright (C) 2009+ Aleksandr B. Sahakyan (aleksahak[at]cantab.net).         #
#                                                                              #
# License: You may redistribute this source code (or its components) and/or    #
#   modify/translate it under the terms of the GNU General Public License      #
#   as published by the Free Software Foundation; version 2 of the License     #
#   (GPL2). You can find the details of GPL2 in the follwing link:             #
#   https://www.gnu.org/licenses/gpl-2.0.html                                  #
################################################################################
##   This script takes the residue sequence number and the parsed pdb         ##
## objectcalculates all the dihdral angles if ALL=TRUE. Otherwise, it         ## 
## looks to the specified value of TOR ("PHI", "PSI", "OMEGA", "CHI1",        ##
## "CHI2" etc.) and returns only the specified angle(s). TOR can be a         ##
## vector, in which case the output will also be a vector of the same         ##
##                           length and order.                                ##
################################################################################
# VERSION: 28 Oct, 2010 -- a significant change to account chain IDs 
#                          for multi-chain proteins!!!
# VERSION: 25 Jan, 2010 -- a significant bug is corrected!!!
# REQUIRES: "get.coord" SOURCE: "get_coord.R"
# REQUIRES: "get.torsion" SOURCE: "get_torsion.R"
# REQUIRES: "dihedral.lib"
# PARSER: "parsed.pdb$resName", "parsed.pdb$resSeq"
# OUTPUT structure:
# phi, psi, omega, CHI1, CHI2, CHI3, CHI4, CHI5

all.dihedral <- function(resSeqnum, parsed.pdb, READLIB=readlib.dih, chainID) { 

  AllResSeqChainSpec <- parsed.pdb$resSeq[which(parsed.pdb$chainID==chainID)]
  minresSeq <- min(AllResSeqChainSpec)[1]  # Specific to different chains!
  maxresSeq <- max(AllResSeqChainSpec)[1]
  # library for dihedral angles which is pre-read as READLIB object
  library <- READLIB # readLines(paste(LIB,"dihedral.lib",sep=""))
  library <- library[grep("DIHEDRAL",library)]
  #######################################################
  if(resSeqnum!= minresSeq & resSeqnum!= maxresSeq) {
    phi <- get.torsion( get.coord(name=c("C","N","CA","C"),
                   resSeq=c(resSeqnum-1, resSeqnum, resSeqnum, resSeqnum),
                   parsed.pdb=parsed.pdb, chainID=chainID) )
    psi <- get.torsion( get.coord(name=c("N","CA","C","N"),
                   resSeq=c(resSeqnum, resSeqnum, resSeqnum, resSeqnum+1),
                   parsed.pdb=parsed.pdb, chainID=chainID) )
    omega <- get.torsion( get.coord(name=c("CA","C","N","CA"),
                 resSeq=c(resSeqnum-1, resSeqnum-1, resSeqnum, resSeqnum),
                 parsed.pdb=parsed.pdb, chainID=chainID) )
  } else {
    if(resSeqnum == minresSeq) {
      phi <- NA
      psi <- get.torsion( get.coord(name=c("N","CA","C","N"),
                   resSeq=c(resSeqnum, resSeqnum, resSeqnum, resSeqnum+1),
                   parsed.pdb=parsed.pdb, chainID=chainID) )
      omega <- NA
    } else {
      phi <- get.torsion( get.coord(name=c("C","N","CA","C"),
                   resSeq=c(resSeqnum-1, resSeqnum, resSeqnum, resSeqnum),
                   parsed.pdb=parsed.pdb, chainID=chainID) )
      psi <- NA
      omega <- get.torsion( get.coord(name=c("CA","C","N","CA"),
                 resSeq=c(resSeqnum-1, resSeqnum-1, resSeqnum, resSeqnum),
                 parsed.pdb=parsed.pdb, chainID=chainID) )
    }
  }
  #######################################################

    resName <- parsed.pdb$resName[which(parsed.pdb$resSeq  == resSeqnum &
                                        parsed.pdb$chainID == chainID    )][1]
    #print(resName)  ######## CAN BE DELETED
    sublib <- library[grep(resName,library)]
    #####################################################################
    #####################################################################
    for(i in 1:length(sublib)) {
      line <- linesplit(sublib[i])
      # # # # # # # # # #
      if(line[4]=="NA") {
        trs <- NA
      } else {
        trs <- get.torsion(get.coord(name=unlist(strsplit(line[4],",")),
                      resSeq=c(resSeqnum,resSeqnum,resSeqnum,resSeqnum),
                      parsed.pdb=parsed.pdb, chainID=chainID) )
        ####################
        if(length(trs)==0) {
          trs <- get.torsion(get.coord(name=unlist(strsplit(line[5],",")),
                      resSeq=c(resSeqnum,resSeqnum,resSeqnum,resSeqnum),
                      parsed.pdb=parsed.pdb, chainID=chainID) )
          ##################
          if(length(trs)==0) {
            trs<-get.torsion(get.coord(name=unlist(strsplit(line[6],",")),
                       resSeq=c(resSeqnum,resSeqnum,resSeqnum,resSeqnum),
                       parsed.pdb=parsed.pdb, chainID=chainID) )
             if(length(trs)==0) { 
                trs <- NA
             }

          } 
          ##################
        }
        ####################
      }
      # # # # # # # # # #
      eval(parse(text=paste(line[3]," <- trs")))
    }
    #####################################################################
    #####################################################################

    return(c(phi, psi, omega, CHI1, CHI2, CHI3, CHI4, CHI5)) 

}

################################################################################

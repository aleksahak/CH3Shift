################################################################################
# Copyright (C) 2009+ Aleksandr B. Sahakyan (aleksahak[at]cantab.net).         #
#                                                                              #
# License: You may redistribute this source code (or its components) and/or    #
#   modify/translate it under the terms of the GNU General Public License      #
#   as published by the Free Software Foundation; version 2 of the License     #
#   (GPL2). You can find the details of GPL2 in the follwing link:             #
#   https://www.gnu.org/licenses/gpl-2.0.html                                  #
################################################################################
##  This script takes the parsed.pdb object, the processed topology           ##
## proc.topol and the  object after pdbProc() application (record.var.)       ##
## and converts the parsed.pdb$name to the 1st type (ALMOST reference)        ##
## If the $name is already of ALMOST type, nothing will be changed!           ##
## Terminal atom names will be passed unchanged!                              ##
################################################################################
# Augmented on 18 AUG, 2011

convert.topology <- function(parsed.pdb, proc.topol, record.variants){

##########
do.convert <- function(l) {
 name <- parsed.pdb$name[l]
 resSeq <- parsed.pdb$resSeq[l]
 chain <- parsed.pdb$chain[l]
 amac <- record.variants$residue.seq[paste(resSeq,",",chain,sep="")]
 variant <- record.variants$variant[which(record.variants$residue.types==amac)]


  if(variant!=1 & name!="OT1" &  name!="OT2" & name!="HT1"  &  name!="HT2" & 
     name!="HT3" & name!="OXT" & name!="H1"   &  name!="H2"  & 
     name!="H3"  & name!="HN1" & name!="HN2"  &  name!="HN3" &
     # for quickness in CH3 shift project:
     name!="HA" &  name!="CA" & name!="CB"  &  name!="N" &
     name!="O" & name!="CG") {

     AmAc <- amac
     subtop <- proc.topol[which(sapply(proc.topol, "[", 1)==AmAc)]
     nvar <- record.variants$variant[which(record.variants$residue.types==AmAc)] 
     record <- sapply(subtop, "[", 3+nvar)
     record[which(record=="-")] <-sapply(subtop, "[", 4)[which(record=="-")]
     residues <- sapply(subtop, "[", 1)
     real.top <- cbind(residues, record)

     record <- sapply(subtop, "[", 4)
     target.top <- cbind(residues, record)

     return.name <- as.vector(target.top[which(real.top[,"record"]==name),"record"])
     ## this bug correction will return atom names NAN, in cases when a certain atom type
     ## is not accounted in the topology for the unsuitability of parameterization:
     ## such as HID HE2 or ASP HD (protonated). Dummy geometric objects for NAN are created
     ## in the main script to store the dummy data, that will not accounted in prediction.
     if(length(return.name)>0){ return(return.name) } else { return("NAN") } ###18AUG11###
    
  } else {
    return(name)
  }
}
############
 new.names <- sapply(1:length(parsed.pdb$name), do.convert, simplify=TRUE)
 if(is.vector(new.names)!=TRUE){
   stop("ERROR: Problem in convert.topology subroutine!!!")
 } else {
   parsed.pdb$name <- new.names
 }

 return(parsed.pdb)
}

################################################################################

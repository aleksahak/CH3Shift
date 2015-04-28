################################################################################
# Copyright (C) 2009+ Aleksandr B. Sahakyan (aleksahak[at]cantab.net).         #
#                                                                              #
# License: You may redistribute this source code (or its components) and/or    #
#   modify/translate it under the terms of the GNU General Public License      #
#   as published by the Free Software Foundation; version 2 of the License     #
#   (GPL2). You can find the details of GPL2 in the follwing link:             #
#   https://www.gnu.org/licenses/gpl-2.0.html                                  #
################################################################################
## This function given the methyl containing amino acid name (LEU), the        
## sequence number in the protein structure file and the parsed pdb ob-        
## ject, returns a list with the following information:                        
# $ch3NUM -- number of methyl groups in the given residue
# $C[[1]] -- the ALMOST atom name of the first methylic carbon (CG1 ..) 
# $C[[2]] -- the ALMOST atom name of the second methylic carbon 
# $Cxyz[[1]] -- the xyz coordinates of the first carbon
# $Cxyz[[2]] -- the xyz coordinates of the second carbon
# $CCdir[[1]] --  the projection destination along CC(H3) axis C->out
# $CCdir[[2]] --  the projection destination along CC(H3) axis C->out
# $Havxyz[[1]] -- the xyz coordinates of the average 3C-H bonds for 1stC
# $Havxyz[[2]] -- the xyz coordinates of the average 3C-H bonds for 2ndC
################################################################################
# VERSION: 02 November 2010, significant change to account chainID
# REQUIRES: "get.coord" SOURCE: "get_coord.R"
# REQUIRES: "Vector.translate" SOURCE: "Vector_translate.R"
# REQUIRES: "Xnormcent" SOURCE: "Xnormcent.R"

methyl.name <- function(AmAc, resSeqN, parsed.pdb, chainID){
 RESULT        <- NULL
 RESULT$ch3NUM <- NULL
 RESULT$C      <- list(NULL)
 RESULT$Cxyz   <- list(NULL)
 RESULT$H      <- list(NULL)
 RESULT$Havxyz <- list(NULL)
 RESULT$CCdir  <- list(NULL)

 if(AmAc=="VAL") { 
   RESULT$ch3NUM <- 2 
   RESULT$C[[1]] <- "CG1";
   RESULT$Cxyz[[1]] <- get.coord("CG1", resSeq=resSeqN, parsed.pdb, chainID=chainID);
     priorCxyz <- get.coord("CB", resSeq=resSeqN, parsed.pdb, chainID=chainID);
     RESULT$CCdir[[1]] <- Vector.translate(c(0,0,0), Xnormcent(priorCxyz, RESULT$Cxyz[[1]]), RESULT$Cxyz[[1]])
   RESULT$C[[2]] <- "CG2";
     RESULT$Cxyz[[2]] <- get.coord("CG2", resSeq=resSeqN, parsed.pdb, chainID=chainID); 
     priorCxyz <- get.coord("CB", resSeq=resSeqN, parsed.pdb, chainID=chainID);
     RESULT$CCdir[[2]] <- Vector.translate(c(0,0,0), Xnormcent(priorCxyz, RESULT$Cxyz[[2]]), RESULT$Cxyz[[2]])  
   
   RESULT$H[[1]] <- c("HG11","HG12","HG13");
   a <- get.coord("HG11", resSeq=resSeqN, parsed.pdb, chainID=chainID);
   b <- get.coord("HG12", resSeq=resSeqN, parsed.pdb, chainID=chainID);
   c <- get.coord("HG13", resSeq=resSeqN, parsed.pdb, chainID=chainID);
   RESULT$Havxyz[[1]] <- c( ((a[1]+b[1]+c[1])/3) , 
                            ((a[2]+b[2]+c[2])/3) , 
                            ((a[3]+b[3]+c[3])/3) )
   RESULT$H[[2]] <- c("HG21","HG22","HG23")
   a <- get.coord("HG21", resSeq=resSeqN, parsed.pdb, chainID=chainID);
   b <- get.coord("HG22", resSeq=resSeqN, parsed.pdb, chainID=chainID);
   c <- get.coord("HG23", resSeq=resSeqN, parsed.pdb, chainID=chainID);
   RESULT$Havxyz[[2]] <- c( ((a[1]+b[1]+c[1])/3) , 
                            ((a[2]+b[2]+c[2])/3) , 
                            ((a[3]+b[3]+c[3])/3) ) 
 }
 if(AmAc=="LEU") { 
   RESULT$ch3NUM <- 2 
   RESULT$C[[1]] <- "CD1";
   RESULT$Cxyz[[1]] <- get.coord("CD1", resSeq=resSeqN, parsed.pdb, chainID=chainID);
     priorCxyz <- get.coord("CG", resSeq=resSeqN, parsed.pdb, chainID=chainID);
     RESULT$CCdir[[1]] <- Vector.translate(c(0,0,0), Xnormcent(priorCxyz, RESULT$Cxyz[[1]]), RESULT$Cxyz[[1]]) 
   RESULT$C[[2]] <- "CD2"
   RESULT$Cxyz[[2]] <- get.coord("CD2", resSeq=resSeqN, parsed.pdb, chainID=chainID); 
     priorCxyz <- get.coord("CG", resSeq=resSeqN, parsed.pdb, chainID=chainID);
     RESULT$CCdir[[2]] <- Vector.translate(c(0,0,0), Xnormcent(priorCxyz, RESULT$Cxyz[[2]]), RESULT$Cxyz[[2]])
   RESULT$H[[1]] <- c("HD11","HD12","HD13");
   a <- get.coord("HD11", resSeq=resSeqN, parsed.pdb, chainID=chainID);
   b <- get.coord("HD12", resSeq=resSeqN, parsed.pdb, chainID=chainID);
   c <- get.coord("HD13", resSeq=resSeqN, parsed.pdb, chainID=chainID);
   RESULT$Havxyz[[1]] <- c( ((a[1]+b[1]+c[1])/3) , 
                            ((a[2]+b[2]+c[2])/3) , 
                            ((a[3]+b[3]+c[3])/3) )   
   RESULT$H[[2]] <- c("HD21","HD22","HD23")
   a <- get.coord("HD21", resSeq=resSeqN, parsed.pdb, chainID=chainID);
   b <- get.coord("HD22", resSeq=resSeqN, parsed.pdb, chainID=chainID);
   c <- get.coord("HD23", resSeq=resSeqN, parsed.pdb, chainID=chainID);
   RESULT$Havxyz[[2]] <- c( ((a[1]+b[1]+c[1])/3) , 
                            ((a[2]+b[2]+c[2])/3) , 
                            ((a[3]+b[3]+c[3])/3) )  
 }
 if(AmAc=="THR") { 
   RESULT$ch3NUM <- 1 
   RESULT$C[[1]] <- "CG2";
   RESULT$Cxyz[[1]] <- get.coord("CG2", resSeq=resSeqN, parsed.pdb, chainID=chainID); 
     priorCxyz <- get.coord("CB", resSeq=resSeqN, parsed.pdb, chainID=chainID);
     RESULT$CCdir[[1]] <- Vector.translate(c(0,0,0), Xnormcent(priorCxyz, RESULT$Cxyz[[1]]), RESULT$Cxyz[[1]])
   RESULT$C[[2]] <- NULL
   RESULT$Cxyz[[2]] <- NULL 
     RESULT$CCdir[[2]] <- NULL
   RESULT$H[[1]] <- c("HG21","HG22","HG23");
   a <- get.coord("HG21", resSeq=resSeqN, parsed.pdb, chainID=chainID);
   b <- get.coord("HG22", resSeq=resSeqN, parsed.pdb, chainID=chainID);
   c <- get.coord("HG23", resSeq=resSeqN, parsed.pdb, chainID=chainID);
   RESULT$Havxyz[[1]] <- c( ((a[1]+b[1]+c[1])/3) , 
                            ((a[2]+b[2]+c[2])/3) , 
                            ((a[3]+b[3]+c[3])/3) )   
   RESULT$H[[2]] <- NULL
   RESULT$Havxyz[[2]] <- NULL
 }
 if(AmAc=="MET") { 
   RESULT$ch3NUM <- 1
   RESULT$C[[1]] <- "CE";
   RESULT$Cxyz[[1]] <- get.coord("CE", resSeq=resSeqN, parsed.pdb, chainID=chainID);
     priorCxyz <- get.coord("SD", resSeq=resSeqN, parsed.pdb, chainID=chainID);
     RESULT$CCdir[[1]] <- Vector.translate(c(0,0,0), Xnormcent(priorCxyz, RESULT$Cxyz[[1]]), RESULT$Cxyz[[1]])
   RESULT$C[[2]] <- NULL
   RESULT$Cxyz[[2]] <- NULL;
     RESULT$CCdir[[2]] <- NULL
   RESULT$H[[1]] <- c("HE1","HE2","HE3");
   a <- get.coord("HE1", resSeq=resSeqN, parsed.pdb, chainID=chainID);
   b <- get.coord("HE2", resSeq=resSeqN, parsed.pdb, chainID=chainID);
   c <- get.coord("HE3", resSeq=resSeqN, parsed.pdb, chainID=chainID);
   RESULT$Havxyz[[1]] <- c( ((a[1]+b[1]+c[1])/3) , 
                            ((a[2]+b[2]+c[2])/3) , 
                            ((a[3]+b[3]+c[3])/3) )
   RESULT$H[[2]] <- NULL
   RESULT$Havxyz[[2]] <- NULL
 }
 if(AmAc=="ILE") { 
   RESULT$ch3NUM <- 2 
   RESULT$C[[1]] <- "CG2";
   RESULT$Cxyz[[1]] <- get.coord("CG2", resSeq=resSeqN, parsed.pdb, chainID=chainID);
     priorCxyz <- get.coord("CB", resSeq=resSeqN, parsed.pdb, chainID=chainID);
     RESULT$CCdir[[1]] <- Vector.translate(c(0,0,0), Xnormcent(priorCxyz, RESULT$Cxyz[[1]]), RESULT$Cxyz[[1]])
   RESULT$C[[2]] <- "CD"
   RESULT$Cxyz[[2]] <- get.coord("CD", resSeq=resSeqN, parsed.pdb, chainID=chainID);
     priorCxyz <- get.coord("CG1", resSeq=resSeqN, parsed.pdb, chainID=chainID);
     RESULT$CCdir[[2]] <- Vector.translate(c(0,0,0), Xnormcent(priorCxyz, RESULT$Cxyz[[2]]), RESULT$Cxyz[[2]])
   RESULT$H[[1]] <- c("HG21","HG22","HG23");
   a <- get.coord("HG21", resSeq=resSeqN, parsed.pdb, chainID=chainID);
   b <- get.coord("HG22", resSeq=resSeqN, parsed.pdb, chainID=chainID);
   c <- get.coord("HG23", resSeq=resSeqN, parsed.pdb, chainID=chainID);
   RESULT$Havxyz[[1]] <- c( ((a[1]+b[1]+c[1])/3) , 
                            ((a[2]+b[2]+c[2])/3) , 
                            ((a[3]+b[3]+c[3])/3) )
   RESULT$H[[2]] <- c("HD1","HD2","HD3")
   a <- get.coord("HD1", resSeq=resSeqN, parsed.pdb, chainID=chainID);
   b <- get.coord("HD2", resSeq=resSeqN, parsed.pdb, chainID=chainID);
   c <- get.coord("HD3", resSeq=resSeqN, parsed.pdb, chainID=chainID);
   RESULT$Havxyz[[2]] <- c( ((a[1]+b[1]+c[1])/3) , 
                            ((a[2]+b[2]+c[2])/3) , 
                            ((a[3]+b[3]+c[3])/3) )
 }
 if(AmAc=="ALA") {
   RESULT$ch3NUM <- 1  
   RESULT$C[[1]] <- "CB";
   RESULT$Cxyz[[1]] <- get.coord("CB", resSeq=resSeqN, parsed.pdb, chainID=chainID);
     priorCxyz <- get.coord("CA", resSeq=resSeqN, parsed.pdb, chainID=chainID);
     RESULT$CCdir[[1]] <- Vector.translate(c(0,0,0), Xnormcent(priorCxyz, RESULT$Cxyz[[1]]), RESULT$Cxyz[[1]])
   RESULT$C[[2]] <- NULL
   RESULT$Cxyz[[2]] <- NULL;
   RESULT$CCdir[[2]] <- NULL
   RESULT$H[[1]] <- c("HB1","HB2","HB3");
   a <- get.coord("HB1", resSeq=resSeqN, parsed.pdb, chainID=chainID);
   b <- get.coord("HB2", resSeq=resSeqN, parsed.pdb, chainID=chainID);
   c <- get.coord("HB3", resSeq=resSeqN, parsed.pdb, chainID=chainID);
   RESULT$Havxyz[[1]] <- c( ((a[1]+b[1]+c[1])/3) , 
                            ((a[2]+b[2]+c[2])/3) , 
                            ((a[3]+b[3]+c[3])/3) )
   RESULT$H[[2]] <- NULL
   RESULT$Havxyz[[2]] <- NULL
 }
 return(RESULT)
}

################################################################################

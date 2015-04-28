################################################################################
# Copyright (C) 2009+ Aleksandr B. Sahakyan (aleksahak[at]cantab.net).         #
#                                                                              #
# License: You may redistribute this source code (or its components) and/or    #
#   modify/translate it under the terms of the GNU General Public License      #
#   as published by the Free Software Foundation; version 2 of the License     #
#   (GPL2). You can find the details of GPL2 in the follwing link:             #
#   https://www.gnu.org/licenses/gpl-2.0.html                                  #
################################################################################
# # # # # # # # # # # # # # # # #
FUN.cosapply <- function(ang) {
  if(ang!=0) {  
   COS1  <- cos( ang )                         
   COS2  <- cos( 5*ang )                       
   COS3  <- cos( 3*ang )                       
   COS4  <- (cos( ang ))^2                     
   COS5  <- cos( 2*ang )^2                    
   COS6  <- cos( 3*ang )^2      
   COS7  <- cos( ang + pi/2)     
   COS8  <- cos( ang + pi/2)^3       
   COS9  <- sin( ang )*cos( ang ) 
   COS10 <- cos( 2*(ang + (30*pi/180)) ) 
  } else {
    COS1 <- COS2 <- COS3 <- COS4 <- COS5 <- COS6 <- COS7 <- COS8 <- COS9 <- COS10 <- 0
  } 
  return(c(COS1, COS2, COS3, COS4, COS5, COS6, COS7, COS8, COS9, COS10))
}
# # # # # # # # # # # # # # # # #
#########################################################################


#########################################################################
addCos <- function(Data) {

  # Initializing the cells for holding angle data:
  Angle.COSData <- NULL
  angle.type <- c("PHI", "PSI", "CHI1", "CHI2", "CHI3")
  cosine.ind <- 1:10
  for(cosind in cosine.ind){
    for(angtyp in angle.type){
      eval(parse(text=paste("Angle.COSData$",angtyp,"COS",cosind," <- rep(NA,length(Data[,1]))",sep="")))
    }
  }; rm(cosind, angtyp)

  ##############################
  for(ind.COSData in 1:length(Data[,1])) {
    PhiPsiChi123 <- c( as.numeric(as.character(Data[ind.COSData, "PHI"])),
                       as.numeric(as.character(Data[ind.COSData, "PSI"])),
                       as.numeric(as.character(Data[ind.COSData, "CHI1"])),
                       as.numeric(as.character(Data[ind.COSData, "CHI2"])),
                       as.numeric(as.character(Data[ind.COSData, "CHI3"])) )

    cosine.matrix <- sapply(PhiPsiChi123, FUN.cosapply)
    colnames(cosine.matrix) <- c("PHI","PSI","CHI1","CHI2","CHI3")

    for(cosind in cosine.ind){
      for(angtyp in angle.type){
      eval(parse(text=paste("Angle.COSData$",angtyp,"COS",cosind,
                            "[ind.COSData] <- cosine.matrix[",cosind,", '",angtyp,"']",sep="") ))
     }
    }; rm(cosind, angtyp)
  }
  ##############################
  text <- paste("Data <- data.frame(Data, ",    angle.type[1],"COS1=Angle.COSData$",angle.type[1],"COS1, ",
                                                angle.type[1],"COS2=Angle.COSData$",angle.type[1],"COS2, ",
                                                angle.type[1],"COS3=Angle.COSData$",angle.type[1],"COS3, ",
                                                angle.type[1],"COS4=Angle.COSData$",angle.type[1],"COS4, ",
                                                angle.type[1],"COS5=Angle.COSData$",angle.type[1],"COS5, ",
                                                angle.type[1],"COS6=Angle.COSData$",angle.type[1],"COS6, ",
                                                angle.type[1],"COS7=Angle.COSData$",angle.type[1],"COS7, ",
                                                angle.type[1],"COS8=Angle.COSData$",angle.type[1],"COS8, ",
                                                angle.type[1],"COS9=Angle.COSData$",angle.type[1],"COS9, ",
                                              angle.type[1],"COS10=Angle.COSData$",angle.type[1],"COS10, ",

                                                angle.type[2],"COS1=Angle.COSData$",angle.type[2],"COS1, ",
                                                angle.type[2],"COS2=Angle.COSData$",angle.type[2],"COS2, ",
                                                angle.type[2],"COS3=Angle.COSData$",angle.type[2],"COS3, ",
                                                angle.type[2],"COS4=Angle.COSData$",angle.type[2],"COS4, ",
                                                angle.type[2],"COS5=Angle.COSData$",angle.type[2],"COS5, ",
                                                angle.type[2],"COS6=Angle.COSData$",angle.type[2],"COS6, ",
                                                angle.type[2],"COS7=Angle.COSData$",angle.type[2],"COS7, ",
                                                angle.type[2],"COS8=Angle.COSData$",angle.type[2],"COS8, ",
                                                angle.type[2],"COS9=Angle.COSData$",angle.type[2],"COS9, ",
                                              angle.type[2],"COS10=Angle.COSData$",angle.type[2],"COS10, ",

                                                angle.type[3],"COS1=Angle.COSData$",angle.type[3],"COS1, ",
                                                angle.type[3],"COS2=Angle.COSData$",angle.type[3],"COS2, ",
                                                angle.type[3],"COS3=Angle.COSData$",angle.type[3],"COS3, ",
                                                angle.type[3],"COS4=Angle.COSData$",angle.type[3],"COS4, ",
                                                angle.type[3],"COS5=Angle.COSData$",angle.type[3],"COS5, ",
                                                angle.type[3],"COS6=Angle.COSData$",angle.type[3],"COS6, ",
                                                angle.type[3],"COS7=Angle.COSData$",angle.type[3],"COS7, ",
                                                angle.type[3],"COS8=Angle.COSData$",angle.type[3],"COS8, ",
                                                angle.type[3],"COS9=Angle.COSData$",angle.type[3],"COS9, ",
                                              angle.type[3],"COS10=Angle.COSData$",angle.type[3],"COS10, ",

                                                angle.type[4],"COS1=Angle.COSData$",angle.type[4],"COS1, ",
                                                angle.type[4],"COS2=Angle.COSData$",angle.type[4],"COS2, ",
                                                angle.type[4],"COS3=Angle.COSData$",angle.type[4],"COS3, ",
                                                angle.type[4],"COS4=Angle.COSData$",angle.type[4],"COS4, ",
                                                angle.type[4],"COS5=Angle.COSData$",angle.type[4],"COS5, ",
                                                angle.type[4],"COS6=Angle.COSData$",angle.type[4],"COS6, ",
                                                angle.type[4],"COS7=Angle.COSData$",angle.type[4],"COS7, ",
                                                angle.type[4],"COS8=Angle.COSData$",angle.type[4],"COS8, ",
                                                angle.type[4],"COS9=Angle.COSData$",angle.type[4],"COS9, ",
                                              angle.type[4],"COS10=Angle.COSData$",angle.type[4],"COS10, ",

                                                angle.type[5],"COS1=Angle.COSData$",angle.type[5],"COS1, ",
                                                angle.type[5],"COS2=Angle.COSData$",angle.type[5],"COS2, ",
                                                angle.type[5],"COS3=Angle.COSData$",angle.type[5],"COS3, ",
                                                angle.type[5],"COS4=Angle.COSData$",angle.type[5],"COS4, ",
                                                angle.type[5],"COS5=Angle.COSData$",angle.type[5],"COS5, ",
                                                angle.type[5],"COS6=Angle.COSData$",angle.type[5],"COS6, ",
                                                angle.type[5],"COS7=Angle.COSData$",angle.type[5],"COS7, ",
                                                angle.type[5],"COS8=Angle.COSData$",angle.type[5],"COS8, ",
                                                angle.type[5],"COS9=Angle.COSData$",angle.type[5],"COS9, ",
                                              angle.type[5],"COS10=Angle.COSData$",angle.type[5],"COS10 )", 
                                                sep="")


  eval(parse(text=text))
  return(Data)
}

################################################################################

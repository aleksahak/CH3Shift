################################################################################
# Copyright (C) 2009+ Aleksandr B. Sahakyan (aleksahak[at]cantab.net).         #
#                                                                              #
# License: You may redistribute this source code (or its components) and/or    #
#   modify/translate it under the terms of the GNU General Public License      #
#   as published by the Free Software Foundation; version 2 of the License     #
#   (GPL2). You can find the details of GPL2 in the follwing link:             #
#   https://www.gnu.org/licenses/gpl-2.0.html                                  #
################################################################################
#er.data
#AMC   = "Ile"
#NCL   = c("HD1", "HG2")
#De_c  = c(0.5,-0.1, 0.3)
################################################################################

getP.ch3 <- function(AMC, NCL, De_c, er.data=er.data){
  # EXAMPLE: getP.ch3("Ile", NCL=c("HD1", "HG2"), De_c=c(0.2, 0.12), er.data)

  De_c <- abs(De_c)

  if(length(NCL)==1){
    # Determining the nucleus type suffix ("d1", "d2", "g1", "g2", "b")
    type <- paste(unlist(strsplit(tolower(NCL), ""))[2:length(unlist(strsplit(tolower(NCL), "")))], collapse="")
    # ind - indices of entries that contain shift info (!=NONE) and are of the same AMC type.
    eval(parse(text=paste("ind <- which( as.character(as.vector(er.data$RES))==AMC & as.character(as.vector(er.data$ABSERROR.n",type,"))!='NONE' )", sep="")))

    # ind.s of er.data[ind] that have errors >= than the specified one:
    eval(parse(text=paste("ind.s <- which( as.numeric(as.vector(er.data$ABSERROR.n",type,"[ind])) >=De_c )",sep="")))
  
    Hits  <- length(ind.s)
    Pool  <- length(ind)
    Prob <- round(Hits/Pool, 5)
    Stars <- 1
  }

  if(length(NCL)==2){
    # Determining the nucleus type suffix ("d", "e" or "z")
    type1 <- paste(unlist(strsplit(tolower(NCL[1]), ""))[2:length(unlist(strsplit(tolower(NCL[1]), "")))], collapse="")
    type2 <- paste(unlist(strsplit(tolower(NCL[2]), ""))[2:length(unlist(strsplit(tolower(NCL[2]), "")))], collapse="")
  
    # ind - indices of entries that contain shift info (!=NONE) and are of the same AMC type.
    eval(parse(text=paste("ind <- which( as.character(as.vector(er.data$RES))==AMC & as.character(as.vector(er.data$ABSERROR.n",type1,"))!='NONE' & as.character(as.vector(er.data$ABSERROR.n",type2,"))!='NONE' )", sep="")))

    # ind.s of er.data[ind] that have errors >= than the specified one:
    eval(parse(text=paste("ind.s <- which( as.numeric(as.vector(er.data$ABSERROR.n",type1,"[ind])) >=De_c[1] & as.numeric(as.vector(er.data$ABSERROR.n",type2,"[ind])) >=De_c[2] )",sep="")))

    Hits  <- length(ind.s)
    Pool  <- length(ind)
    Prob <- round(Hits/Pool, 5)
    Stars <- 2
  }


  RESULT <- NULL
  RESULT$Stars <- Stars
  RESULT$Prob  <- Prob
  RESULT$Hits  <- Hits
  RESULT$Pool  <- Pool

  return(RESULT)

}

################################################################################

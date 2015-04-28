################################################################################
# Copyright (C) 2009+ Aleksandr B. Sahakyan (aleksahak[at]cantab.net).         #
#                                                                              #
# License: You may redistribute this source code (or its components) and/or    #
#   modify/translate it under the terms of the GNU General Public License      #
#   as published by the Free Software Foundation; version 2 of the License     #
#   (GPL2). You can find the details of GPL2 in the follwing link:             #
#   https://www.gnu.org/licenses/gpl-2.0.html                                  #
################################################################################
# This function given the index
# of the methyl group in the usual output of the "methyl.name()" function,
# the output of the "methyl.name()" function (ch3.names) and the object
# from the "getarea()" function (areal), returns the electric field pro-
# jection FACTOR along the axis specified in ch3.names. Also requires
# the parsed pdb object.
################################################################################
# REQUIRES: "get.coord" SOURCE: "get_coord.R"
# REQUIRES: "Xangle" SOURCE: "Xangle.R"  -- the updated version
# REQUIRES: "Xnormcent" SOURCE: "Xnormcent.R"

CH3.getEF <- function(index.Methyl.name, ch3.names, areal, parsed.pdb, discard.rad) {
  ef.app <- ch3.names$Cxyz[[index.Methyl.name]]
  ef.dir <- ch3.names$CCdir[[index.Methyl.name]]
  geo.factor <- NULL
  for(i in 1:length(areal$dist)) {
    q.xyz <- get.coord(areal$name[i], areal$resSeq[i], parsed.pdb, chainID=areal$chain[i])
    cos.angle <- Xangle(Xnormcent(ef.app, q.xyz), Xnormcent(ef.app, ef.dir), cosine=TRUE)
    geo.factor[i] <- (areal$charge[i]*cos.angle)/(areal$dist[i])^2
  }
  EF <- NULL
  ### ### EF$CC <- sum(geo.factor)
  # discarding charges closer than discard.rad A
  EF$FARCC <- sum(geo.factor[-which(areal$dist<=discard.rad)])  
  return(EF)
}

################################################################################
################################################################################
# Copyright (C) 2009+ Aleksandr B. Sahakyan (aleksahak[at]cantab.net).         #
#                                                                              #
# License: You may redistribute this source code (or its components) and/or    #
#   modify/translate it under the terms of the GNU General Public License      #
#   as published by the Free Software Foundation; version 2 of the License     #
#   (GPL2). You can find the details of GPL2 in the follwing link:             #
#   https://www.gnu.org/licenses/gpl-2.0.html                                  #
################################################################################
# This function, given query xyz (query.xyz) and three other xyz coordi-
# nate set (xyz1, xyz2, xyz3, where the xyz1 is the central one, and 
# xyz2 and xyz3 are its branches), determines the distance $R from the
# query.xyz to the COM center of mass of xyz2 and xyz3, and the geometric
# factor $G = (3cos^2Theta-1)/R^3, where the Theta is the angle between $R
# and closest normal of the triangle xyz1, xyz2 and xyz3.
################################################################################
# REQUIRES: "Xnormcent" SOURCE: "Xnormcent.R"
# REQUIRES: "normal.vec" SOURCE: "normal_vec.R"
# REQUIRES: "Xdist" SOURCE: "Xdist.R"
# REQUIRES: "Xangle" SOURCE: "Xangle.R"

PlaneCurrent.ARG<-function(query.xyz, xyz1, xyz2, xyz3){
# PlaneCurrent(query.xyz, xyz1, xyz2, xyz3, xyz4, xyz5, xyz6)

  # center of mass is the one at CZ !!!!! modified for Arg usage only!
  COM <- xyz1
  # creating a joint object holding plane xyz coordinates
  ring.XYZ <- list(NULL)
  ring.XYZ[[1]] <- xyz1; ring.XYZ[[2]] <- xyz2
  ring.XYZ[[3]] <- xyz3

    AT2 <- 1; A <- 2; AT1 <- 3
 
  # Calculating 2 possible ring normals from different vector pairs
  # in the ring, for accounting the ring planarity distortions.
  CNvec1E <- Xnormcent( ring.XYZ[[ AT2 ]], ring.XYZ[[ A ]] ) 
  CNvec2E <- Xnormcent( ring.XYZ[[ A ]], ring.XYZ[[ AT1 ]] ) 
  normal1 <- normal.vec(CNvec1E, CNvec2E)  
  normal1.rev <- normal.vec(CNvec2E, CNvec1E)  

  # Averaging the two normals for eliminating the ring planarity
  # distortion effect.
  Normal <- Xnormcent(c(0,0,0), normal1)
  Normal.rev <- Xnormcent(c(0,0,0), normal1.rev)

  # Placeing the normalized ring normal vectors onto the COM of the ring
  # Normal.B <- Normal.rev.B <- COM
  Normal.E <- c(  Normal[1] + ( COM[1] ),
                  Normal[2] + ( COM[2] ),
                  Normal[3] + ( COM[3] )  )
  Normal.rev.E <- c(  Normal.rev[1] + ( COM[1] ),
                      Normal.rev[2] + ( COM[2] ),
                      Normal.rev[3] + ( COM[3] )  )

  # Distance between the query and the center of mass of the ring:
  distance <- Xdist(COM, query.xyz)

  # Calculating the distances between the end-points of the determined
  # two normals and  the queried point (query.xyz), in order to determine
  # the normal, which faces the point.
  DATA <- NULL
  DATA$distanceCOM <- distance
  DATA$query.xyz <- query.xyz
  DATA$Centered0RealNormal <- Normal
  DATA$COM <- COM
  if( Xdist(Normal.E, query.xyz) < Xdist(Normal.rev.E, query.xyz) ) {
  # DATA$Normal.E is always the closest (faceing) normal ending coord.!!!
    DATA$Normal.E <- Normal.E  
    DATA$Normal.rev.E <- Normal.rev.E
  } else {
    DATA$Normal.E <- Normal.rev.E
    DATA$Normal.rev.E <- Normal.E 
  }
  
  # Calculating the angle between the query.xyz---COM  vector and the 
  # ring normal.
  DATA$Theta <- Xangle(Xnormcent(DATA$COM, DATA$Normal.E), 
                       Xnormcent(DATA$COM, DATA$query.xyz))
  Theta.radian <- (DATA$Theta/180)*pi
  # Calculating the geometrical factor for plane current effects:
  DATA$GPC <- ( (3*( (cos(Theta.radian))^2 ))-1 ) / (DATA$distanceCOM^3)

  return(DATA)  

}

################################################################################

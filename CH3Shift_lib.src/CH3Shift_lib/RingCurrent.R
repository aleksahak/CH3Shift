################################################################################
# Copyright (C) 2009+ Aleksandr B. Sahakyan (aleksahak[at]cantab.net).         #
#                                                                              #
# License: You may redistribute this source code (or its components) and/or    #
#   modify/translate it under the terms of the GNU General Public License      #
#   as published by the Free Software Foundation; version 2 of the License     #
#   (GPL2). You can find the details of GPL2 in the follwing link:             #
#   https://www.gnu.org/licenses/gpl-2.0.html                                  #
################################################################################
##  This function, takes as an argument the coordinates of each of the        ##
##   ring (5 or 6 membered) atom coordinates as xyz1=, xyz2= ..., and         ##
##    the xyz coordinates of a query point (atom) as query.xyz. As a          ##
##                     result, the function returns:                          ##
##                                                                            ##
## $Centered0RealNormal - the real unit normal of the ring given the          ##
##                        inputted order of ring members, centered to         ##
##                        zero (only endpoint coordinates are stored).        ##
## $distanceCOM - the distance between the query point and the center         ##
##                of the ring system.                                         ##
## $COM - the vector of x, y and z coordinates of the ring center             ##
## $Normal.E -    the vector of x, y and z coordinates of the endpoint        ##
##                of the faceing/closest to the query point normal            ##
##                vector with a unit length                                   ##
## $Normal.rev.E - the endpoint coordinates of the reverse normal             ##
## $Theta -        the angle between the orthogonal to the ring plane         ##
##                 axis and the query point                                   ##
## $Project - the xyz coordinates of the query point onto the plane           ##
##            which holds the ring                                            ##
## $gfPople - the geometric factor of the Pople's point-dipole model          ## 
## $gfHM - the geometric factor of the Haigh-Mallion model (without           ## 
##                                                         <-> sign)          ##
## $HM - all the computational details within the H.-M. model                 ##
##                                                                            ##
## EXAMPLE INPUT DATA:                                                        ##
## query.xyz <- c(3, 1.5, 5)                                                  ##
## xyz1 <- c(1, 1, 0)                                                         ##
## xyz2 <- c(1.5, 0.5, 0)                                                     ##
## xyz3 <- c(1, 0, 0)                                                         ##
## xyz4 <- c(0.5, 0, 0)                                                       ##
## xyz5 <- c(0, 0.5, 0)                                                       ##
## xyz6 <- c(0.5, 1, 0)                                                       ##
##                                                                            ##
## WARNING: THE COORDINATES FOR RING ATOMS SHOULD BE PROVIDED SEQUENTI-       ##
## ALLY, SO THAT THE NEARBY ATOM DATA ARE REALLY ADJACENT IN THE RING!!       ##
##                                                                            ##
## The function takes two pairs of vectors to calculate the normals,          ##
## owing to which it eliminates the ring planarity distortion effect          ##
## on the precision of the ring endpoint coordinates.                         ##
################################################################################
# REQUIRES: "Xnormcent" SOURCE: "Xnormcent.R"
# REQUIRES: "normal.vec" SOURCE: "normal_vec.R"
# REQUIRES: "vec2.aver" SOURCE: "vec2_aver.R"
# REQUIRES: "Xdist" SOURCE: "Xdist.R"
# REQUIRES: "Xangle" SOURCE: "Xangle.R"
# REQUIRES: "Xnormcent.length" SOURCE: "Xnormcent_length.R"
# REQUIRES: "Vector.translate" SOURCE: "Vector_translate.R"

RingCurrent <- function(query.xyz, xyz1, xyz2, xyz3, xyz4, xyz5, xyz6=NULL){
# RingNormExp(query.xyz, xyz1, xyz2, xyz3, xyz4, xyz5, xyz6)

  # center of mass x,y,z
  COM <- c( mean(c(xyz1[1],xyz2[1],xyz3[1],xyz4[1],xyz5[1],xyz6[1])),
            mean(c(xyz1[2],xyz2[2],xyz3[2],xyz4[2],xyz5[2],xyz6[2])),
            mean(c(xyz1[3],xyz2[3],xyz3[3],xyz4[3],xyz5[3],xyz6[3])) )
  # creating a joint object holding ring xyz coordinates
  ring.XYZ <- list(NULL)
  ring.XYZ[[1]] <- xyz1; ring.XYZ[[2]] <- xyz2
  ring.XYZ[[3]] <- xyz3; ring.XYZ[[4]] <- xyz4
  ring.XYZ[[5]] <- xyz5; ring.XYZ[[6]] <- xyz6

  if(length(xyz6)==0) {  # 5-membered ring
    AT2 <- 4; A <- 1; AT1 <- 3
    BT2 <- 5; B <- 4; BT1 <- 2 
  } else {               # 6-membered ring
    AT2 <- 5; A <- 1; AT1 <- 3
    BT2 <- 6; B <- 4; BT1 <- 2   
  }

  # Calculating 2 possible ring normals from different vector pairs
  # in the ring, for accounting the ring planarity distortions.
  CNvec1E <- Xnormcent( ring.XYZ[[ AT2 ]], ring.XYZ[[ A ]] ) 
  CNvec2E <- Xnormcent( ring.XYZ[[ A ]], ring.XYZ[[ AT1 ]] ) 
  normal1 <- normal.vec(CNvec1E, CNvec2E)  
  normal1.rev <- normal.vec(CNvec2E, CNvec1E)  

  CNvec1E <- Xnormcent( ring.XYZ[[ BT1 ]], ring.XYZ[[ B ]] ) 
  CNvec2E <- Xnormcent( ring.XYZ[[ B ]], ring.XYZ[[ BT2 ]] ) 
  normal2 <- normal.vec(CNvec1E, CNvec2E)  
  normal2.rev <- normal.vec(CNvec2E, CNvec1E)  

  # Averaging the two normals for eliminating the ring planarity
  # distortion effect.
  Normal <- Xnormcent(c(0,0,0), vec2.aver(normal1, normal2))
  Normal.rev <- Xnormcent(c(0,0,0), vec2.aver(normal1.rev, normal2.rev))

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

  if( Xdist(Normal.E, query.xyz) < Xdist(Normal.rev.E, query.xyz) ) {
  # DATA$Normal.E is always the closest (faceing) normal ending coord.!!!
    DATA$Normal.E <- Normal.E
    DATA$COM <- COM
    DATA$Normal.rev.E <- Normal.rev.E
  } else {
  # DATA$Normal.E is always the closest (faceing) normal ending coord.!!!
    DATA$Normal.E <- Normal.rev.E
    DATA$COM <- COM
    DATA$Normal.rev.E <- Normal.E 
  }
  

  ### ###  From now 6x# with a space means commented out for performance (as only)
  ### ### $gfHM is required.

  # Calculating the angle between the query.xyz---COM  vector and the 
  # ring normal.
  DATA$Theta <- Xangle(Xnormcent(DATA$COM, DATA$Normal.E), 
                       Xnormcent(DATA$COM, DATA$query.xyz))

  # Calculating the vector of xyz coordinates for the projection of the
  # query point onto the surface determined by the calculated normal.
  Theta.radian <- (DATA$Theta/180)*pi
  newNormal.length <- cos(Theta.radian)*(DATA$distanceCOM)
  ctr.E <- Xnormcent.length(DATA$COM,DATA$Normal.E,Length=newNormal.length)
  query.COM.xyz <- Vector.translate(c(0,0,0), ctr.E, NewB=DATA$COM)
  DATA$Project <- 
             Vector.translate(query.COM.xyz, DATA$query.xyz, NewB=DATA$COM)
  
  # Calculating the geometrical factor for ring current effects,
  # according to the Pople's model.
  ### ### DATA$gfPople <- ( (3*( (cos(Theta.radian))^2 ))-1 ) / (DATA$distanceCOM^3)

  #######################################################################
  # Calculating the geometrical factor for ring current effects,
  # according to the Haigh-Mellion model.

  polygon <- list(NULL)
  # defining the sequential polygon vertices
  if(length(xyz6)==0) {  # 5-membered ring  
    polygon[[1]] <- c(1,2) ; polygon[[2]] <- c(2,3)
    polygon[[3]] <- c(3,4) ; polygon[[4]] <- c(4,5)
    polygon[[5]] <- c(5,1) 
  } else {               # 6-membered ring 
    polygon[[1]] <- c(1,2) ; polygon[[2]] <- c(2,3)
    polygon[[3]] <- c(3,4) ; polygon[[4]] <- c(4,5)
    polygon[[5]] <- c(5,6) ; polygon[[6]] <- c(6,1) 
  }
  
  # Calculating the triangle areas formed by the points DATA$Project and
  # the atoms of polygon.
  ##########
  HM <- NULL
  for(i in 1:length(polygon)) {
    ring.atoms <- polygon[[i]]
    # determining the lengths of vertices
    a <- Xdist(DATA$Project, ring.XYZ[[ring.atoms[1]]])
    b <- Xdist(DATA$Project, ring.XYZ[[ring.atoms[2]]])
    c <- Xdist(ring.XYZ[[ring.atoms[1]]], ring.XYZ[[ring.atoms[2]]])
    semip <- (a+b+c)/2
    Sij <- sqrt(semip*(semip-a)*(semip-b)*(semip-c))  # Angstrom^2 (Heron's formula)
    # 1000 is for eliminating numerical errors while summing and dividing
    Factor.rij <- (1000/(Xdist(DATA$query.xyz, ring.XYZ[[ring.atoms[1]]])^3)
                  + 1000/(Xdist(DATA$query.xyz, ring.XYZ[[ring.atoms[2]]])^3))/1000

    # triangle.norm -- normalized and centered triangle normal (endpoint coordinates)
    triangle.norm <- normal.vec(Xnormcent(DATA$Project, ring.XYZ[[ring.atoms[1]]]),
                                Xnormcent(ring.XYZ[[ring.atoms[1]]], ring.XYZ[[ring.atoms[2]]]))
    # checking whether the triangle normal has the same direction as the ring normal.
    # In ideal case if the directions are the same, the endpoint coordinates should
    # be the same, as we compare the normalized and centered normal vectors. However,
    # as in reality we can have small numerical errors, the distance between the 
    # endpoints is considered with a certain tolerance towards error -> 0.001
    dist <- Xdist(triangle.norm, DATA$Centered0RealNormal)
    if(dist < 0.5) {  # the normals have the same direction
      sign <- 1         # the sign of the triangle area is positive   
    } else {            # the normals are antiparallel
      sign <- -1        # the sign of the triangle area is negative 
    }
    
    HM$Sij[i] <- Sij
    HM$sign[i] <- sign
    HM$Factor.rij[i] <- Factor.rij 
  }
  HM$SignedSij <- HM$Sij * HM$sign
  ##########
  DATA$gfHM <-  sum( HM$SignedSij * HM$Factor.rij )
  ### ### DATA$HM <- HM
  #######################################################################

  return(DATA)  

}

# Example Runs
# DATA<-RingCurrent(c(0.7,0.5, -3),c(1,1,0),c(1.5,0.5,0),c(1,0,0),c(0.5,0,0),c(0,0.5,0),c(0.5,1,0))
# DATA<-RingCurrent(c(0.7,0.5, -3),c(0.5,1,0),c(0,0.5,0),c(0.5,0,0),c(1,0,0),c(1.5,0.5,0),c(1,1,0))

# print(c(DATA$gfHM, DATA$gfPople))
################################################################################

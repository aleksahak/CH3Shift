################################################################################
# Copyright (C) 2009+ Aleksandr B. Sahakyan (aleksahak[at]cantab.net).         #
#                                                                              #
# License: You may redistribute this source code (or its components) and/or    #
#   modify/translate it under the terms of the GNU General Public License      #
#   as published by the Free Software Foundation; version 2 of the License     #
#   (GPL2). You can find the details of GPL2 in the follwing link:             #
#   https://www.gnu.org/licenses/gpl-2.0.html                                  #
################################################################################
## This function calculates  a dihedral angle, given a vector of x, y         ##
##  and z coordiantes of atoms 1, 2, 3 and 4 => c(x1,y1,z1, x2,y2,z2,         ##
##       x3,y3,z3, x4,y4,z4). The returned angle is in degrees.               ## 
##   Getting torsion angle for 1--2--3--4 with respect to 2--3 axis           ##
################################################################################ 
# REQUIRES: "Xdist" SOURCE: "Xdist.R"
# VERSION 23 Jan, 2010.

get.torsion <- function (xyz, atm.inc = 4) {       # borrowed from bio3d C
  if(length(xyz)/3 < 4) {
    return(NULL)
  } else {
    if (!is.vector(xyz) || !is.numeric(xyz)) 
        stop("input 'xyz' should be a numeric vector")
    natm <- length(xyz)/3
    if (natm < 4) 
        stop("Need at least four atoms to define a dihedral")
    if (natm%%1 != 0) 
        stop("There should be three 'xyz' elements per atom")
    m.xyz <- matrix(xyz, nrow = 3)
    atm.inds <- c(1:4)
    out <- NULL
    while (atm.inds[4] <= natm) {
        if (any(is.na(m.xyz[, atm.inds]))) {
            torp <- NA
        }
        else {
            d1 <- m.xyz[, atm.inds[2]] - m.xyz[, atm.inds[1]]
            d2 <- m.xyz[, atm.inds[3]] - m.xyz[, atm.inds[2]]
            d3 <- m.xyz[, atm.inds[4]] - m.xyz[, atm.inds[3]]
            u1 <- (d1[c(2, 3, 1)] * d2[c(3, 1, 2)]) - (d2[c(2, 
                3, 1)] * d1[c(3, 1, 2)])
            u2 <- (d2[c(2, 3, 1)] * d3[c(3, 1, 2)]) - (d3[c(2, 
                3, 1)] * d2[c(3, 1, 2)])
            ctor <- sum(u1 * u2)/sqrt(sum(u1 * u1) * sum(u2 * 
                u2))
            ctor[ctor > 1] <- 1
            ctor[ctor < -1] <- -1
            torp <- matrix(acos(ctor) * (180/pi), ncol = 1)
            if (sum(u1 * ((u2[c(2, 3, 1)] * d2[c(3, 1, 2)]) - 
                (u2[c(3, 1, 2)] * d2[c(2, 3, 1)]))) < 0) 
                torp <- -torp
        }
        out <- c(out, torp)
        atm.inds <- atm.inds + atm.inc
    }
    if (atm.inc == 1 & natm > 4) 
        out <- c(NA, out, NA, NA)
    return(out)
  }
}

################################################################################
       
#get.torsion.unsign <- function(xyz.vec) {
## xyz.vec = x1,y1,z1, x2,y2,z2, x3,y3,z3, x4,y4,z4
#  x1 <- xyz.vec[1] ; y1 <- xyz.vec[2] ; z1 <- xyz.vec[3] ;
#  x2 <- xyz.vec[4] ; y2 <- xyz.vec[5] ; z2 <- xyz.vec[6] ;
#  x3 <- xyz.vec[7] ; y3 <- xyz.vec[8] ; z3 <- xyz.vec[9] ;
#  x4 <- xyz.vec[10] ; y4 <- xyz.vec[11] ; z4 <- xyz.vec[12]
#
#  d12 <- Xdist(c(x1,y1,z1), c(x2,y2,z2))
#  d23 <- Xdist(c(x2,y2,z2), c(x3,y3,z3))
#  d34 <- Xdist(c(x3,y3,z3), c(x4,y4,z4))
#  d13 <- Xdist(c(x1,y1,z1), c(x3,y3,z3))
#  d14 <- Xdist(c(x1,y1,z1), c(x4,y4,z4))
#  d24 <- Xdist(c(x2,y2,z2), c(x4,y4,z4))
#  P <- ( (d12^2) * ( (d23^2)+(d34^2)-(d24^2)) ) + 
#       ( (d23^2) * (-(d23^2)+(d34^2)+(d24^2)) ) +
#       ( (d13^2) * ( (d23^2)-(d34^2)+(d24^2)) ) -
#       ( 2 * (d23^2) * (d14^2) )
#
#  Q <- (d12 + d23 + d13) * ( d12 + d23 - d13)  *
#       (d12 - d23 + d13) * (-d12 + d23 + d13 ) *
#       (d23 + d34 + d24) * ( d23 + d34 - d24 ) *
#       (d23 - d34 + d24) * (-d23 + d34 + d24 )
#
#  Torsion <- (acos(P/sqrt(Q))*180)/pi   # cos(AngleRadian)=P/sqrt(Q)
#  return(Torsion)
#
#}

#########################################################################
################################################################################
# Copyright (C) 2009+ Aleksandr B. Sahakyan (aleksahak[at]cantab.net).         #
#                                                                              #
# License: You may redistribute this source code (or its components) and/or    #
#   modify/translate it under the terms of the GNU General Public License      #
#   as published by the Free Software Foundation; version 2 of the License     #
#   (GPL2). You can find the details of GPL2 in the follwing link:             #
#   https://www.gnu.org/licenses/gpl-2.0.html                                  #
################################################################################
##  This function takes the coordinates of the ends of 2 centered and         ##
##  normalized vectors (or the components of the i,j,k) and calculates        ##
##    the end point coordinates of the centerd and normalized normal          ##    
##                              vector.                                       ##
################################################################################
# REQUIRES: "Xnormcent" SOURCE: "Xnormcent.R"

normal.vec <- function(CNvec1E, CNvec2E) {

  # x <- ay*bz-az*by
  x <- (CNvec1E[2]*CNvec2E[3]) - (CNvec1E[3]*CNvec2E[2])
  # y <- az*bx-ax*bz
  y <- (CNvec1E[3]*CNvec2E[1]) - (CNvec1E[1]*CNvec2E[3])
  # z <- ax*by-ay*bx
  z <- (CNvec1E[1]*CNvec2E[2]) - (CNvec1E[2]*CNvec2E[1])
  return(   Xnormcent(c(0,0,0), c(x,y,z))   ) 

}

################################################################################
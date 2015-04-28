################################################################################
# Copyright (C) 2009+ Aleksandr B. Sahakyan (aleksahak[at]cantab.net).         #
#                                                                              #
# License: You may redistribute this source code (or its components) and/or    #
#   modify/translate it under the terms of the GNU General Public License      #
#   as published by the Free Software Foundation; version 2 of the License     #
#   (GPL2). You can find the details of GPL2 in the follwing link:             #
#   https://www.gnu.org/licenses/gpl-2.0.html                                  #
################################################################################
## This function calculates the angle between 2 vectors, having as an         ##
## argument the coordinates of the ends of 2 normalized and centered          ##
##                 vectors in Vec1 and Vec2 objects                           ##
################################################################################

Xangle <- function(CNVec1, CNVec2, cosine=FALSE, radian=FALSE) {
  COS.AB <-
     ((CNVec1[1]*CNVec2[1])+(CNVec1[2]*CNVec2[2])+(CNVec1[3]*CNVec2[3]))/
     (  ((((CNVec1[1])^2)+((CNVec1[2])^2)+((CNVec1[3])^2))^0.5)*
        ((((CNVec2[1])^2)+((CNVec2[2])^2)+((CNVec2[3])^2))^0.5)  )
  #################
  if(cosine==TRUE){
    return(COS.AB)
  } else {
    ##################
    if(radian==TRUE){
      return(acos(COS.AB))
    } else {
      angle.AB <- (acos(COS.AB)/pi)*180
      return(angle.AB)
    }
    ##################
  }
  #################

}

################################################################################
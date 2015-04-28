################################################################################
# Copyright (C) 2009+ Aleksandr B. Sahakyan (aleksahak[at]cantab.net).         #
#                                                                              #
# License: You may redistribute this source code (or its components) and/or    #
#   modify/translate it under the terms of the GNU General Public License      #
#   as published by the Free Software Foundation; version 2 of the License     #
#   (GPL2). You can find the details of GPL2 in the follwing link:             #
#   https://www.gnu.org/licenses/gpl-2.0.html                                  #
################################################################################
##   This function takes the beginning and endpoint coordinates of a          ##
##  vector and the NewB new begining coordinates. It returns the new          ##
##    ending coordinates of the vector translated to the enterd new           ##
##                               beginnig.                                    ##
################################################################################

Vector.translate <- function(Vec1B, Vec1E, NewB) {
  
  L.x <- Vec1E[1] - Vec1B[1]
  L.y <- Vec1E[2] - Vec1B[2]
  L.z <- Vec1E[3] - Vec1B[3]

  New.x <- NewB[1]+L.x
  New.y <- NewB[2]+L.y
  New.z <- NewB[3]+L.z

  return(c(New.x, New.y, New.z))

}

################################################################################
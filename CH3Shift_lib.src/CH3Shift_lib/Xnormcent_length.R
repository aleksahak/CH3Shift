################################################################################
# Copyright (C) 2009+ Aleksandr B. Sahakyan (aleksahak[at]cantab.net).         #
#                                                                              #
# License: You may redistribute this source code (or its components) and/or    #
#   modify/translate it under the terms of the GNU General Public License      #
#   as published by the Free Software Foundation; version 2 of the License     #
#   (GPL2). You can find the details of GPL2 in the follwing link:             #
#   https://www.gnu.org/licenses/gpl-2.0.html                                  #
################################################################################
##   This function calculates the normalized and centered to 0 vector         ##
##  showing the direction. It takes as an argument the Cart1B, Cart1E         ##
## beginning and ending coordinates of the vector, centers the vector         ##
## translating the beginning to the 0,0,0 coordinate and normalizes by        ##
##   setting the length to a gien argfument Length. As a result, the          ##
##     program returns the xyz coordinates of the end point of the            ##
##                         transformed vector.                                ##
################################################################################

Xnormcent.length <- function(Vec1B, Vec1E, Length) {
 L.x <- Vec1E[1] - Vec1B[1]
 L.y <- Vec1E[2] - Vec1B[2]
 L.z <- Vec1E[3] - Vec1B[3]
 L <- Xdist(Vec1B, Vec1E)
 normcent.xyz <- c((L.x/L)*Length, (L.y/L)*Length, (L.z/L)*Length)
 return(normcent.xyz)
}

################################################################################
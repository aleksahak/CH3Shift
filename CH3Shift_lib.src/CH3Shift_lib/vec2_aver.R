################################################################################
# Copyright (C) 2009+ Aleksandr B. Sahakyan (aleksahak[at]cantab.net).         #
#                                                                              #
# License: You may redistribute this source code (or its components) and/or    #
#   modify/translate it under the terms of the GNU General Public License      #
#   as published by the Free Software Foundation; version 2 of the License     #
#   (GPL2). You can find the details of GPL2 in the follwing link:             #
#   https://www.gnu.org/licenses/gpl-2.0.html                                  #
################################################################################
##  This function takes 2 centered and normalized vectors and returns         ##
##           the ending coordinates of the 3D averaged vector                 ##
################################################################################

vec2.aver <- function(CNVec1, CNVec2) {
  aver.x <- (CNVec1[1] + CNVec2[1])/2
  aver.y <- (CNVec1[2] + CNVec2[2])/2
  aver.z <- (CNVec1[3] + CNVec2[3])/2
  aver <- c(aver.x, aver.y, aver.z)
  return(aver)
}

################################################################################
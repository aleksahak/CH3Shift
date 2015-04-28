################################################################################
# Copyright (C) 2009+ Aleksandr B. Sahakyan (aleksahak[at]cantab.net).         #
#                                                                              #
# License: You may redistribute this source code (or its components) and/or    #
#   modify/translate it under the terms of the GNU General Public License      #
#   as published by the Free Software Foundation; version 2 of the License     #
#   (GPL2). You can find the details of GPL2 in the follwing link:             #
#   https://www.gnu.org/licenses/gpl-2.0.html                                  #
################################################################################
## This function takes a character line and decomposes it cutting the         ##
##                                 spaces.                                    ##
################################################################################

linesplit <- function(line) {
  Line <- unlist(strsplit(line," "))
  Line <- Line[which(Line!="")]
  return(Line)
}

################################################################################
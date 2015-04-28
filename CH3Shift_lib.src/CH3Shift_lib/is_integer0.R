################################################################################
# Copyright (C) 2009+ Aleksandr B. Sahakyan (aleksahak[at]cantab.net).         #
#                                                                              #
# License: You may redistribute this source code (or its components) and/or    #
#   modify/translate it under the terms of the GNU General Public License      #
#   as published by the Free Software Foundation; version 2 of the License     #
#   (GPL2). You can find the details of GPL2 in the follwing link:             #
#   https://www.gnu.org/licenses/gpl-2.0.html                                  #
################################################################################
## This script takes an object and checks whether it is and integer(0)        ##
## or character(0). The result is TRUE/FALSE. If TRUE, the object does        ##
## not hold an information, and therefore cannot be further processed.        ##
################################################################################

is.integer0 <- function(object){

  if(length(c(1,object))>1) {
    result <- FALSE  # not integer(0)
  } else {
    result <- TRUE
  }
  return(result)

}

################################################################################
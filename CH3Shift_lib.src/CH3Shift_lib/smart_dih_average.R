################################################################################
# Copyright (C) 2009+ Aleksandr B. Sahakyan (aleksahak[at]cantab.net).         #
#                                                                              #
# License: You may redistribute this source code (or its components) and/or    #
#   modify/translate it under the terms of the GNU General Public License      #
#   as published by the Free Software Foundation; version 2 of the License     #
#   (GPL2). You can find the details of GPL2 in the follwing link:             #
#   https://www.gnu.org/licenses/gpl-2.0.html                                  #
################################################################################
#The number of angles is even => there is a danger of improper
# averaging of angles (such as -175, 180). To this end, we will
# add a new value to make the numbers odd, thus median will
# return a really recorded value, rather than false averaging.
# i -- character name of the angle ("PHI")

smart.dih.average <- function(list.row){
  eval(parse(text=paste("angle.set <- (",da,"[[list.row]])",sep=""))) 
  if((length(angle.set)%%2)==0) {
    if(length(which(angle.set>0))!=0) {
      return(median(c(angle.set, mean(angle.set[which(angle.set>0)]))))
    } else {
      if(length(which(angle.set<0))!=0) {
        return(median(c(angle.set, mean(angle.set[which(angle.set<0)]))))
      } else {  # all the data are 0s
        return(0)
      }
    }
  } else {
    return(median(angle.set))
  }
}

################################################################################

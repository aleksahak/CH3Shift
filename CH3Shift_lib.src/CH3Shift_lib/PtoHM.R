################################################################################
# Copyright (C) 2009+ Aleksandr B. Sahakyan (aleksahak[at]cantab.net).         #
#                                                                              #
# License: You may redistribute this source code (or its components) and/or    #
#   modify/translate it under the terms of the GNU General Public License      #
#   as published by the Free Software Foundation; version 2 of the License     #
#   (GPL2). You can find the details of GPL2 in the follwing link:             #
#   https://www.gnu.org/licenses/gpl-2.0.html                                  #
################################################################################

# # # # # # # # # # # # # #
PtoHM6 <- function(G.P) {
 if(G.P==0){ 
   G.HM <- 0
 } else {
   G.HM <- ((1.7433792394778*G.P) + 0.00046612200072)/
                 (0.325964+(2.39111*G.P))
 }
 return(G.HM)
}
PtoHM5 <- function(G.P) {
 if(G.P==0){ 
   G.HM <- 0
 } else {
   G.HM <- ((3.52574*G.P) + 0.00014576114308)/
                 (1.00024284001406+(5.87393*G.P))
 }
 return(G.HM)
}
# # # # # # # # # # # # # #
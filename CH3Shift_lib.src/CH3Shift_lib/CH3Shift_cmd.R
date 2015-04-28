################################################################################
# Copyright (C) 2009+ Aleksandr B. Sahakyan (aleksahak[at]cantab.net).         #
#                                                                              #
# License: You may redistribute this source code (or its components) and/or    #
#   modify/translate it under the terms of the GNU General Public License      #
#   as published by the Free Software Foundation; version 2 of the License     #
#   (GPL2). You can find the details of GPL2 in the follwing link:             #
#   https://www.gnu.org/licenses/gpl-2.0.html                                  #
################################################################################

CH3Shift.cmd <- function(  pdbname,
                           pdbtype      ="complex",
                           title        ="Not Specified",
                           examine      =0,
                           seqshift     =0,
                           experdata    =NULL,
                           outputname   ="out.txt",
                           outorder     ="byseq",
                           xlim         =NULL,
                           ylim         =NULL,
                           rereference  =FALSE,
                           pointlabel   =TRUE,
                           linelabel    =TRUE,
                           plotexper    =TRUE,
                           zooming      =TRUE,
                           interactive  =TRUE,   # supresses viewplot and saveplot!!!
                           viewplot     =FALSE,  # supresses saveplot!!!
                           saveplot     =FALSE,
                           plotheight   =550,
                           plotwidth    =550,
                           plotname     ="hsqc.jpg",
                           colALA       =NULL, # if NULL, default will be used!
                           colVAL       =NULL,
                           colLEU       =NULL,
                           colILE       =NULL,
                           colTHR       =NULL,
                           colMET       =NULL,
                           expCOL       =NULL,
                           colALAexp    =NULL,
                           colVALexp    =NULL,
                           colTHRexp    =NULL,
                           colLEUexp    =NULL,
                           colILEexp    =NULL, #"olive"
                           colMETexp    =NULL,
                           noconstraints=NULL, # if NULL, default will be used!
                           Cmargin      =NULL,
                           Hmargin      =NULL,
                           default.csCrange=NULL,
                           default.csHrange=NULL,
                           minRerefNum  =NULL,
                           cex1=NULL, lwd1=NULL,
                           cex2=NULL, lwd2=NULL,
                           cex3=NULL, lwd3=NULL,
                           bias=2  ) {

  save(pdbname, pdbtype, title, examine, seqshift, experdata, outputname, outorder, xlim, ylim, rereference, pointlabel, linelabel, plotexper, zooming, interactive, viewplot, saveplot, plotheight, plotwidth, plotname, colALA, colVAL, colLEU, colILE, colTHR, colMET, expCOL, colALAexp, colVALexp, colTHRexp, colLEUexp,  colILEexp, colMETexp, noconstraints, Cmargin, Hmargin, default.csCrange, default.csHrange, minRerefNum, cex1, lwd1, cex2, lwd2, cex3, lwd3, bias, file="CH3Shift.cmd")
}

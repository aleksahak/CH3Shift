################################################################################
# Copyright (C) 2009+ Aleksandr B. Sahakyan (aleksahak[at]cantab.net).         #
#                                                                              #
# License: You may redistribute this source code (or its components) and/or    #
#   modify/translate it under the terms of the GNU General Public License      #
#   as published by the Free Software Foundation; version 2 of the License     #
#   (GPL2). You can find the details of GPL2 in the follwing link:             #
#   https://www.gnu.org/licenses/gpl-2.0.html                                  #
################################################################################

CH3.filter.violation <- function(pr.lm, ncl, resid){

  # "ALA" maxC.ALA    maxH.ALA
  # "THR" maxC.THR    maxH.THR
  # "VAL" maxCg1.VAL  maxHg1.VAL
  # "VAL" maxCg2.VAL  maxHg2.VAL
  # "LEU" maxCd1.LEU  maxHd1.LEU
  # "LEU" maxCd2.LEU  maxHd2.LEU
  # "ILE" maxCg.ILE   maxHg.ILE
  # "ILE" maxCd.ILE   maxHd.ILE
  # "MET" maxC.MET    maxH.MET

  if(resid=="ALA" & ncl=="CB"){
    pr.lm$fit[which(pr.lm$fit > maxC.ALA | pr.lm$fit < minC.ALA)] <- NA
  }
  if(resid=="ALA" & ncl=="HB1"){
    pr.lm$fit[which(pr.lm$fit > maxH.ALA | pr.lm$fit < minH.ALA)] <- NA
  }
  if(resid=="THR" & ncl=="CG2"){
    pr.lm$fit[which(pr.lm$fit > maxC.THR | pr.lm$fit < minC.THR)] <- NA
  }
  if(resid=="THR" & ncl=="HG21"){
    pr.lm$fit[which(pr.lm$fit > maxH.THR | pr.lm$fit < minH.THR)] <- NA
  }
  if(resid=="VAL" & ncl=="CG1"){
    pr.lm$fit[which(pr.lm$fit > maxCg1.VAL | pr.lm$fit < minCg1.VAL)] <- NA
  }
  if(resid=="VAL" & ncl=="CG2"){
    pr.lm$fit[which(pr.lm$fit > maxCg2.VAL | pr.lm$fit < minCg2.VAL)] <- NA
  }
  if(resid=="VAL" & ncl=="HG11"){
    pr.lm$fit[which(pr.lm$fit > maxHg1.VAL | pr.lm$fit < minHg1.VAL)] <- NA
  }
  if(resid=="VAL" & ncl=="HG21"){
    pr.lm$fit[which(pr.lm$fit > maxHg2.VAL | pr.lm$fit < minHg2.VAL)] <- NA
  }
  if(resid=="LEU" & ncl=="CD1"){
    pr.lm$fit[which(pr.lm$fit > maxCd1.LEU | pr.lm$fit < minCd1.LEU)] <- NA
  }
  if(resid=="LEU" & ncl=="CD2"){
    pr.lm$fit[which(pr.lm$fit > maxCd2.LEU | pr.lm$fit < minCd2.LEU)] <- NA
  }
  if(resid=="LEU" & ncl=="HD11"){
    pr.lm$fit[which(pr.lm$fit > maxHd1.LEU | pr.lm$fit < minHd1.LEU)] <- NA
  }
  if(resid=="LEU" & ncl=="HD21"){
    pr.lm$fit[which(pr.lm$fit > maxHd2.LEU | pr.lm$fit < minHd2.LEU)] <- NA
  }
  if(resid=="ILE" & ncl=="CG2"){
    pr.lm$fit[which(pr.lm$fit > maxCg.ILE | pr.lm$fit < minCg.ILE)] <- NA
  }
  if(resid=="ILE" & ncl=="CD"){
    pr.lm$fit[which(pr.lm$fit > maxCd.ILE | pr.lm$fit < minCd.ILE)] <- NA
  }
  if(resid=="ILE" & ncl=="HG21"){
    pr.lm$fit[which(pr.lm$fit > maxHg.ILE | pr.lm$fit < minHg.ILE)] <- NA
  }
  if(resid=="ILE" & ncl=="HD1"){
    pr.lm$fit[which(pr.lm$fit > maxHd.ILE | pr.lm$fit < minHd.ILE)] <- NA
  }
  if(resid=="MET" & ncl=="CE"){
    pr.lm$fit[which(pr.lm$fit > maxC.MET | pr.lm$fit < minC.MET)] <- NA
  }
  if(resid=="MET" & ncl=="HE1"){
    pr.lm$fit[which(pr.lm$fit > maxH.MET | pr.lm$fit < minH.MET)] <- NA
  }

  return(pr.lm)
}

################################################################################

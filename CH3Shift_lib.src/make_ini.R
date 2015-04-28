################################################################################
# Copyright (C) 2009+ Aleksandr B. Sahakyan (aleksahak[at]cantab.net).         #
#                                                                              #
# License: You may redistribute this source code (or its components) and/or    #
#   modify/translate it under the terms of the GNU General Public License      #
#   as published by the Free Software Foundation; version 2 of the License     #
#   (GPL2). You can find the details of GPL2 in the follwing link:             #
#   https://www.gnu.org/licenses/gpl-2.0.html                                  #
################################################################################

PARTRIM  = TRUE
compiled = TRUE
if(compiled==TRUE){ suppressPackageStartupMessages(library(compiler)) }
partrimmer <- function(lmfit){
  lmfit$effects <- NULL
  lmfit$fitted.values <- NULL
  lmfit$assign <- NULL
  lmfit$df.residual <- NULL
  lmfit$model <- NULL
  return(lmfit)
}
###############################################
# Making sure the existing folders are removed
cur.folders <- dir("..")
delete <- which(cur.folders=="CH3Shift_exe")
if(length(delete)!=0){ system("rm -r ../CH3Shift_exe") }
delete <- which(cur.folders=="CH3Shift_srv")
if(length(delete)!=0){ system("rm -r ../CH3Shift_srv") }
###############################################
# reading the CH3Shift.R script:
CH3Shift.R <- readLines("CH3Shift_lib/CH3Shift.R")
system("mkdir ../CH3Shift_exe")
system("mkdir ../CH3Shift_exe/CH3Shift_lib")
write(c("IsThisWebServer = FALSE", CH3Shift.R), file="../CH3Shift_exe/CH3Shift.R")
system("cp CH3Shift_lib/example.pdb ../CH3Shift_exe/example.pdb")
system("cp CH3Shift_lib/example.exp ../CH3Shift_exe/example.exp")
system("cp CH3Shift_lib/command.cmd ../CH3Shift_exe/command.cmd")
###############################################
# Preparing the joint parameter object:
load(paste("CH3Shift_par/ALA_CB_all.methcs",sep=""))
if(PARTRIM==TRUE){ lmfit <- partrimmer(lmfit=lmfit) }
ALA_CB_all.methcs  = lmfit
load(paste("CH3Shift_par/ALA_HB1_all.methcs",sep=""))
if(PARTRIM==TRUE){ lmfit <- partrimmer(lmfit=lmfit) }
ALA_HB1_all.methcs = lmfit
load(paste("CH3Shift_par/ILE_CD_all.methcs",sep=""))
if(PARTRIM==TRUE){ lmfit <- partrimmer(lmfit=lmfit) }
ILE_CD_all.methcs  = lmfit
load(paste("CH3Shift_par/ILE_CG2_all.methcs",sep=""))
if(PARTRIM==TRUE){ lmfit <- partrimmer(lmfit=lmfit) }
ILE_CG2_all.methcs = lmfit
load(paste("CH3Shift_par/ILE_HD1_all.methcs",sep=""))
if(PARTRIM==TRUE){ lmfit <- partrimmer(lmfit=lmfit) }
ILE_HD1_all.methcs = lmfit
load(paste("CH3Shift_par/ILE_HG21_all.methcs",sep=""))
if(PARTRIM==TRUE){ lmfit <- partrimmer(lmfit=lmfit) }
ILE_HG21_all.methcs = lmfit
load(paste("CH3Shift_par/LEU_CD1_all.methcs",sep=""))
if(PARTRIM==TRUE){ lmfit <- partrimmer(lmfit=lmfit) }
LEU_CD1_all.methcs = lmfit
load(paste("CH3Shift_par/LEU_CD2_all.methcs",sep=""))
if(PARTRIM==TRUE){ lmfit <- partrimmer(lmfit=lmfit) }
LEU_CD2_all.methcs = lmfit
load(paste("CH3Shift_par/LEU_HD11_all.methcs",sep=""))
if(PARTRIM==TRUE){ lmfit <- partrimmer(lmfit=lmfit) }
LEU_HD11_all.methcs = lmfit
load(paste("CH3Shift_par/LEU_HD21_all.methcs",sep=""))
if(PARTRIM==TRUE){ lmfit <- partrimmer(lmfit=lmfit) }
LEU_HD21_all.methcs = lmfit
load(paste("CH3Shift_par/MET_CE_all.methcs",sep=""))
if(PARTRIM==TRUE){ lmfit <- partrimmer(lmfit=lmfit) }
MET_CE_all.methcs = lmfit
load(paste("CH3Shift_par/MET_HE1_all.methcs",sep=""))
if(PARTRIM==TRUE){ lmfit <- partrimmer(lmfit=lmfit) }
MET_HE1_all.methcs = lmfit
load(paste("CH3Shift_par/THR_CG2_all.methcs",sep=""))
if(PARTRIM==TRUE){ lmfit <- partrimmer(lmfit=lmfit) }
THR_CG2_all.methcs = lmfit
load(paste("CH3Shift_par/THR_HG21_all.methcs",sep=""))
if(PARTRIM==TRUE){ lmfit <- partrimmer(lmfit=lmfit) }
THR_HG21_all.methcs = lmfit
load(paste("CH3Shift_par/VAL_CG1_all.methcs",sep=""))
if(PARTRIM==TRUE){ lmfit <- partrimmer(lmfit=lmfit) }
VAL_CG1_all.methcs = lmfit
load(paste("CH3Shift_par/VAL_CG2_all.methcs",sep=""))
if(PARTRIM==TRUE){ lmfit <- partrimmer(lmfit=lmfit) }
VAL_CG2_all.methcs = lmfit
load(paste("CH3Shift_par/VAL_HG11_all.methcs",sep=""))
if(PARTRIM==TRUE){ lmfit <- partrimmer(lmfit=lmfit) }
VAL_HG11_all.methcs = lmfit
load(paste("CH3Shift_par/VAL_HG21_all.methcs",sep=""))
if(PARTRIM==TRUE){ lmfit <- partrimmer(lmfit=lmfit) }
VAL_HG21_all.methcs = lmfit

save(ALA_CB_all.methcs,   ALA_HB1_all.methcs,  ILE_CD_all.methcs,
     ILE_CG2_all.methcs,  ILE_HD1_all.methcs,  ILE_HG21_all.methcs,
     LEU_CD1_all.methcs,  LEU_CD2_all.methcs,  LEU_HD11_all.methcs,
     LEU_HD21_all.methcs, MET_CE_all.methcs,   MET_HE1_all.methcs,
     THR_CG2_all.methcs,  THR_HG21_all.methcs, VAL_CG1_all.methcs,
     VAL_CG2_all.methcs,  VAL_HG11_all.methcs, VAL_HG21_all.methcs,
     file="../CH3Shift_exe/CH3Shift_lib/CH3Shift.par")
rm( list=ls()[which(ls()!="compiled")] )

############################# Moving the defaults file:
system("cp CH3Shift_par/Defaults.R ../CH3Shift_exe/CH3Shift_lib/Defaults.R")

# READING FUNCTIONS:
source("CH3Shift_lib/CH3Shift_cmd.R"            )
source("CH3Shift_lib/pdbparser_complex.R"       )
source("CH3Shift_lib/pdbparser_almost.R"        )
source("CH3Shift_lib/pdbparser_medium.R"        )
source("CH3Shift_lib/pdbparser_simple.R"        )
source("CH3Shift_lib/pdbProc.R"                 )
source("CH3Shift_lib/get_amac_types.R"          )
source("CH3Shift_lib/convert_topology.R"        )
source("CH3Shift_lib/amac_find.R"               )
source("CH3Shift_lib/is_integer0.R"             )
source("CH3Shift_lib/all_dihedral.R"            )
source("CH3Shift_lib/get_coord.R"               )
source("CH3Shift_lib/get_torsion.R"             )
source("CH3Shift_lib/methyl_name.R"             )
source("CH3Shift_lib/Xnormcent.R"               )
source("CH3Shift_lib/Vector_translate.R"        )
source("CH3Shift_lib/Xdist.R"                   )
source("CH3Shift_lib/getarea.R"                 )
source("CH3Shift_lib/CH3_Merge_Same_Type_dist.R")
source("CH3Shift_lib/CH3_getEF.R"               )
source("CH3Shift_lib/Xangle.R"                  )
source("CH3Shift_lib/CH3_Ring_AmAc.R"           )
source("CH3Shift_lib/PlaneCurrent_ARG.R"        )
source("CH3Shift_lib/PlaneCurrent.R"            )
source("CH3Shift_lib/CH3_filter_violation.R"    )
source("CH3Shift_lib/getP_ch3.R"                )
source("CH3Shift_lib/uniqizer.R"                )
source("CH3Shift_lib/Aniso_Plane.R"             )
source("CH3Shift_lib/Aniso_Pept.R"              )
source("CH3Shift_lib/Aniso_Arg.R"               )
source("CH3Shift_lib/RingCurrent.R"             )
source("CH3Shift_lib/normal_vec.R"              )
source("CH3Shift_lib/vec2_aver.R"               )
source("CH3Shift_lib/Xnormcent_length.R"        )
source("CH3Shift_lib/addCos.R"                  )
source("CH3Shift_lib/addMergeDist.R"            )
source("CH3Shift_lib/ResidueName.R"             )
source("CH3Shift_lib/zoom_rev.R"                )
source("CH3Shift_lib/isNMRpdb.R"                )
source("CH3Shift_lib/linesplit.R"               )
source("CH3Shift_lib/topol_retrieve.R"          )
source("CH3Shift_lib/predict_lmold.R"           ) # predict.lm from R 2.11.1 for CH3Shift only
# source("CH3Shift_lib/PtoHM.R")
# source("CH3Shift_lib/smart_dih_average.R")
# BIT-COMPILING THE FUNCTIONS:
if(compiled==TRUE){
  is.integer0        <- cmpfun(is.integer0, options=list(suppressUndefined=TRUE))
  linesplit          <- cmpfun(linesplit,   options=list(suppressUndefined=TRUE))
  Xangle             <- cmpfun(Xangle,      options=list(suppressUndefined=TRUE))
  Xnormcent          <- cmpfun(Xnormcent,   options=list(suppressUndefined=TRUE))
  Vector.translate   <- cmpfun(Vector.translate, options=list(suppressUndefined=TRUE))
  Xdist              <- cmpfun(Xdist,       options=list(suppressUndefined=TRUE))
  uniqizer           <- cmpfun(uniqizer, options=list(suppressUndefined=TRUE))
  get.coord          <- cmpfun(get.coord,   options=list(suppressUndefined=TRUE))
  get.torsion        <- cmpfun(get.torsion, options=list(suppressUndefined=TRUE))
  convert.topology   <- cmpfun(convert.topology, options=list(suppressUndefined=TRUE))
  topol.retrieve     <- cmpfun(topol.retrieve, options=list(suppressUndefined=TRUE))
  getarea            <- cmpfun(getarea, options=list(suppressUndefined=TRUE))
  CH3Shift.cmd       <- cmpfun(CH3Shift.cmd, options=list(suppressUndefined=TRUE))
  pdbparser.complex  <- cmpfun(pdbparser.complex, options=list(suppressUndefined=TRUE))
  pdbparser.almost   <- cmpfun(pdbparser.almost, options=list(suppressUndefined=TRUE))
  pdbparser.medium   <- cmpfun(pdbparser.medium, options=list(suppressUndefined=TRUE))
  pdbparser.simple   <- cmpfun(pdbparser.simple, options=list(suppressUndefined=TRUE))
  pdbProc            <- cmpfun(pdbProc, options=list(suppressUndefined=TRUE))
  get.amac.types     <- cmpfun(get.amac.types, options=list(suppressUndefined=TRUE))
  normal.vec         <- cmpfun(normal.vec, options=list(suppressUndefined=TRUE))
  vec2.aver          <- cmpfun(vec2.aver, options=list(suppressUndefined=TRUE))
  Xnormcent.length   <- cmpfun(Xnormcent.length, options=list(suppressUndefined=TRUE))
  addCos             <- cmpfun(addCos, options=list(suppressUndefined=TRUE))
  addMergeDist       <- cmpfun(addMergeDist, options=list(suppressUndefined=TRUE))
  amac.find          <- cmpfun(amac.find, options=list(suppressUndefined=TRUE))
  all.dihedral       <- cmpfun(all.dihedral, options=list(suppressUndefined=TRUE))
  methyl.name        <- cmpfun(methyl.name, options=list(suppressUndefined=TRUE))
  RingCurrent        <- cmpfun(RingCurrent, options=list(suppressUndefined=TRUE))
  Aniso.Plane        <- cmpfun(Aniso.Plane, options=list(suppressUndefined=TRUE))
  Aniso.Pept         <- cmpfun(Aniso.Pept, options=list(suppressUndefined=TRUE))
  Aniso.Arg          <- cmpfun(Aniso.Arg, options=list(suppressUndefined=TRUE))
  CH3.Merge.Same.Type.dist  <- cmpfun(CH3.Merge.Same.Type.dist, options=list(suppressUndefined=TRUE))
  CH3.getEF          <- cmpfun(CH3.getEF, options=list(suppressUndefined=TRUE))
  CH3.Ring.AmAc      <- cmpfun(CH3.Ring.AmAc, options=list(suppressUndefined=TRUE))
  PlaneCurrent.ARG   <- cmpfun(PlaneCurrent.ARG, options=list(suppressUndefined=TRUE))
  PlaneCurrent       <- cmpfun(PlaneCurrent, options=list(suppressUndefined=TRUE))
  CH3.filter.violation  <- cmpfun(CH3.filter.violation, options=list(suppressUndefined=TRUE))
  getP.ch3           <- cmpfun(getP.ch3, options=list(suppressUndefined=TRUE))
  ResidueName        <- cmpfun(ResidueName, options=list(suppressUndefined=TRUE))
  zoom.rev           <- cmpfun(zoom.rev, options=list(suppressUndefined=TRUE))
  isNMRpdb           <- cmpfun(isNMRpdb, options=list(suppressUndefined=TRUE))
  predict.lmold      <- cmpfun(predict.lmold, options=list(suppressUndefined=TRUE))  
}

load("CH3Shift_par/er_data.Rdata")   # object for P calculations
readlib.dih <- readLines("CH3Shift_lib/dihedral.lib")

# Processing the topology file for further accelerated usage:
proc.topol <- readLines( "CH3Shift_lib/topology.lib" )
proc.topol <- proc.topol[-grep("#", proc.topol)]                
proc.topol <- lapply(proc.topol, linesplit)                    
# # #

# Utility function for P calculations
fun5 <- function(i){
  if(i=="xxxxxx"){
    return(NA)
  } else {
    return(as.numeric(i))
  }
}
# # # # # # # # # # # # # # # # # # # 

save(list=ls(), file="../CH3Shift_exe/CH3Shift_lib/CH3Shift.ini")
system("cp CH3Shift_manual/CH3Shift_manual.pdf ../CH3Shift_exe/README.pdf")

startdir <- getwd()
setwd("..")
system("tar czvf CH3Shift_exe.tar.gz CH3Shift_exe")
setwd(startdir)


# # # # # Generating the Web Server version of CH3Shift:
# reading the CH3Shift.R script:
CH3Shift.R <- readLines("CH3Shift_lib/CH3Shift.R")
system("mkdir ../CH3Shift_srv")
system("cp -r CH3Shift_srv_lib/CH3Shift ../CH3Shift_srv")
system("cp -r ../CH3Shift_exe/CH3Shift_lib ../CH3Shift_srv/CH3Shift/WEB-INF/CH3Shift_lib")
system("cp -r CH3Shift_manual/CH3Shift_manual.pdf ../CH3Shift_srv/CH3Shift/CH3Shift_manual.pdf")
system("mv  ../CH3Shift_exe.tar.gz ../CH3Shift_srv/CH3Shift/CH3Shift_exe.tar.gz")
write(c("IsThisWebServer = TRUE", CH3Shift.R), file="../CH3Shift_srv/CH3Shift/WEB-INF/CH3Shift.R")
setwd("../CH3Shift_srv/CH3Shift")
system("jar cf CH3Shift.war . ")
system("mv CH3Shift.war ..")
setwd("..")
system("rm -r CH3Shift")
setwd("../CH3Shift_lib.src")

print("DONE")


# # VARIABLES ### VARIABLES ### VARIABLES ### VARIABLES ### VARIABLES ###
# - sign should be put to account the fact that my G.P and G.HM
# are for nuclear shielding difference, not for chemical shift dif.
#             i    B    
#Case.Phe  <- -1.46*5.455 #Ref. rce_95_1
#Case.Tyr  <- -1.24*5.455 #Ref. rce_95_1
#Case.His  <- -1.35*5.455 #Ref. rce_95_1
#Case.Trp5 <- -1.32*5.455 #Ref. rce_95_1
#Case.Trp6 <- -1.24*5.455 #Ref. rce_95_1
#Case.DX   <- -5.1        #Ref. 36 of rce_91_1
#Case.Aef  <-  0          # -2 in Ref. 21 of rce_91_1  at present DEACTIVATED
# # VARIABLES ### VARIABLES ### VARIABLES ### VARIABLES ### VARIABLES ###

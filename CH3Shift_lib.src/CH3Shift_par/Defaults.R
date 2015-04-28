noconstraints.def=FALSE

### RE-REFERENCING DEFAULT
minRerefNum.def = 10

### PLOTTING DEFAULTS:
Cmargin.def=0.5
Hmargin.def=0.1
default.csCrange.def=c(15, 27)
default.csHrange.def=c(-0.7, 2.2)
cex1.def=1.7; lwd1.def=1.0
cex2.def=1.0; lwd2.def=1.0
cex3.def=0.5; lwd3.def=1.0 

### DEFAULT COLOR SCHEME:
colALA.def    ="navy"
colVAL.def    ="orange"
colTHR.def    ="purple"
colLEU.def    ="#33CC33"
colILE.def    ="#808000"   # "olive"
colMET.def    ="yellow"
expCOL.def    =  NULL      # the colXXXexp will be read
colALAexp.def ="#00008050"
colVALexp.def ="#FF990050"
colTHRexp.def ="#80008050"
colLEUexp.def ="#33CC3350"
colILEexp.def ="#80800050" # "olive"
colMETexp.def ="#FFFF0050"

### INPUT CORRECTION:
if(experdata==""){experdata=NULL}
if(title==""){title="Not specified."}
if(pdbname==""){stop("The PDB file is not uploaded")}
if(length(colALA)==0){colALA=colALA.def} else {if(colALA==""){colALA=colALA.def}}
if(length(colVAL)==0){colVAL=colVAL.def} else {if(colVAL==""){colVAL=colVAL.def}}
if(length(colTHR)==0){colTHR=colTHR.def} else {if(colTHR==""){colTHR=colTHR.def}}
if(length(colLEU)==0){colLEU=colLEU.def} else {if(colLEU==""){colLEU=colLEU.def}}
if(length(colILE)==0){colILE=colILE.def} else {if(colILE==""){colILE=colILE.def}}
if(length(colMET)==0){colMET=colMET.def} else {if(colMET==""){colMET=colMET.def}}
if(length(expCOL)==0){expCOL=expCOL.def} else {if(expCOL==""){expCOL=expCOL.def}}
if(length(colALAexp)==0){colALAexp=colALAexp.def} else {if(colALAexp==""){colALAexp=colALAexp.def}}
if(length(colVALexp)==0){colVALexp=colVALexp.def} else {if(colVALexp==""){colVALexp=colVALexp.def}}
if(length(colTHRexp)==0){colTHRexp=colTHRexp.def} else {if(colTHRexp==""){colTHRexp=colTHRexp.def}}
if(length(colLEUexp)==0){colLEUexp=colLEUexp.def} else {if(colLEUexp==""){colLEUexp=colLEUexp.def}}
if(length(colILEexp)==0){colILEexp=colILEexp.def} else {if(colILEexp==""){colILEexp=colILEexp.def}}
if(length(colMETexp)==0){colMETexp=colMETexp.def} else {if(colMETexp==""){colMETexp=colMETexp.def}}
if(length(noconstraints)==0)   {noconstraints=noconstraints.def}
if(length(Cmargin)==0)         {Cmargin=Cmargin.def}
if(length(Hmargin)==0)         {Hmargin=Hmargin.def}
if(length(default.csCrange)==0){default.csCrange=default.csCrange.def}
if(length(default.csHrange)==0){default.csHrange=default.csHrange.def}
if(length(cex1)==0)            {cex1=cex1.def}
if(length(lwd1)==0)            {lwd1=lwd1.def}
if(length(cex2)==0)            {cex2=cex2.def}
if(length(lwd2)==0)            {lwd2=lwd2.def}
if(length(cex3)==0)            {cex3=cex3.def}
if(length(lwd3)==0)            {lwd3=lwd3.def}
if(length(minRerefNum)==0)     {minRerefNum=minRerefNum.def}

### CONSTRAINTS:
 if(noconstraints==TRUE){
  # Wider filtering windows
  minC.ALA   = 10; maxC.ALA   = 50
  minC.THR   = 10; maxC.THR   = 50
  minCg1.VAL = 10; maxCg1.VAL = 50
  minCg2.VAL = 10; maxCg2.VAL = 50
  minCd1.LEU = 10; maxCd1.LEU = 50
  minCd2.LEU = 10; maxCd2.LEU = 50
  minCg.ILE  = 10; maxCg.ILE  = 50
  minCd.ILE  = 10; maxCd.ILE  = 50
  minC.MET   = 10; maxC.MET   = 50

  minH.ALA   = -2; maxH.ALA   = 3
  minH.THR   = -2; maxH.THR   = 3
  minHg1.VAL = -2; maxHg1.VAL = 3
  minHg2.VAL = -2; maxHg2.VAL = 3
  minHd1.LEU = -2; maxHd1.LEU = 3
  minHd2.LEU = -2; maxHd2.LEU = 3
  minHg.ILE  = -2; maxHg.ILE  = 3
  minHd.ILE  = -2; maxHd.ILE  = 3
  minH.MET   = -2; maxH.MET   = 3
 } else {
  # Filtering windows
  minC.ALA   = 14; maxC.ALA   = 25
  minC.THR   = 18; maxC.THR   = 25
  minCg1.VAL = 18; maxCg1.VAL = 25
  minCg2.VAL = 17; maxCg2.VAL = 26
  minCd1.LEU = 20; maxCd1.LEU = 29
  minCd2.LEU = 20; maxCd2.LEU = 29
  minCg.ILE  = 14; maxCg.ILE  = 21
  minCd.ILE  =  9; maxCd.ILE  = 19
  minC.MET   = 15; maxC.MET   = 20

  minH.ALA   =  0.3; maxH.ALA   = 2.0
  minH.THR   =  0.4; maxH.THR   = 1.7
  minHg1.VAL =  0.1; maxHg1.VAL = 1.6
  minHg2.VAL = -0.1; maxHg2.VAL = 1.4
  minHd1.LEU = -0.1; maxHd1.LEU = 1.5
  minHd2.LEU = -0.5; maxHd2.LEU = 1.5
  minHg.ILE  = -0.2; maxHg.ILE  = 1.6
  minHd.ILE  = -0.4; maxHd.ILE  = 1.6
  minH.MET   =  0.5; maxH.MET   = 2.7
 }

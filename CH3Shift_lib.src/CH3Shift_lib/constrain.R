
 if(noconstraints==TRUE){
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
# Created by MDeith on April 21, 2018 to create a sheep OM for DLMtool for FISH 505
# Uses seal OM example but generates OM from scratch
# see http://www.datalimitedtoolkit.org/Case_Studies_Table/Grey_Seal_5ZJM_DFO/Grey_Seal_5ZJM_DFO.html)
# Last modified on April 21, 2018

library(DLMtool)
# library(DLMdata)
setup()

dir.create('baseCaseOM')
setwd('baseCaseOM/')
OMinit('WMU42_StonesSheep_baseCase')

# Then, after populating parameters in WMU42_StonesSheep.xlsx 
# AND documenting changes in markdown in file WMU42_StonesSheep.rmd

OMdoc('WMU42_StonesSheep_baseCase') # This looks for the file 
# WMU42_StonesSheep_baseCase.rmd and populates an HTML based off of it

# Then 
stonesSheepOM <- XL2OM("WMU42_StonesSheep.xlsx")

plot(stonesSheepOM)

mps <- c('!!!LIST OF RELEVANT MPS HERE!!!')
sheepMSE <- runMSE(stonesSheepOM, MPs) #, parallel=T) # remove # if successful


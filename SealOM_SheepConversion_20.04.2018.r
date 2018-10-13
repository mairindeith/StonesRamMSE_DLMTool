# Created by MDeith on April 20, 2018 to learn DLMtool for FISH 505
# Uses seal OM example 
# see http://www.datalimitedtoolkit.org/Case_Studies_Table/Grey_Seal_5ZJM_DFO/Grey_Seal_5ZJM_DFO.html)
# Follows instructions from PDF lessons from Murdoch for FISH 505
# Last modified on April 20, 2018

library(DLMtool)
# library(DLMdata)
setup()

sealOM <- readRDS('E://Mairin/Fish505/DLMToolProject/OM.rdata')
haddockOM <- readRDS('E://Mairin/Fish505/DLMToolProject/OMhaddock.rdata')

avail('Fleet')
avail('Stock') # No grey seal in pre-loaded stock list

sealOM@nsim <- 20 # lower than 80 (original OM) to investigate convergence
sealTest <- runMSE(sealOM, MPs = c('AvC','DCAC','FMSYref','curE'))

# VOI and convergence -----------------------------------------------------

Converge(sealTest)
VOI(sealTest)
 
# Very high VOI for the curE MP, particularly for the operating model parameters
# SizeLimSD, Depletion, FMSY, B0, N0, SSB0 

# Perhaps due to the observation model being assumed perfect (more or less)?


# Custom performance metrics ----------------------------------------------

# The MSE object has a number of slots:
slotNames(sealTest)
# The OM slot of the MSE object contains all of the simulated parameter values 
# of the operating model (e.g. RefY, M, ageM, SizeLimSD, etc.)
names(sealTest@OM)
sealTest@OM

# In addition to the OM slot, there is also an Obs slot that contains the 
# observed parameters (e.g. Cbias, Csd, CAA_ESS, Linfbias, etc.)
names(sealTest@Obs)
sealTest@Obs

# SSB:
sealTest@SSB # In this case, I assume this is numbers?
# Mean SSB by MP
apply(sealTest@SSB,2,mean)
# 659882.1 661680.2 388264.1 632109.3
sealTest@MPs
# "AvC"     "DCAC"    "FMSYref" "curE"

# Probability that SSB is over 5% SSBMSY:
apply(sealTest@B_BMSY>0.05, 2, mean)
# 1 1 1 1  # sick

# Mean catch relative to MSY
apply(sealTest@C/sealTest@OM$MSY, 2, mean)
# 0.0461170 0.0396728 0.9748201 0.1569015

# Custom trade-off plot:
muSSB <- apply(sealTest@SSB,2,mean)
CrelMSY <- apply(sealTest@C/sealTest@OM$MSY,2,mean)

plot(muSSB, CrelMSY, col='white')
text(muSSB, CrelMSY, sealTest@MPs,col='blue')

# In my analysis, I would like to have access to the 'length' of adults caught
# Maximize horn value by maximizing horn length would be an appropriate metric


# The 'Data' class --------------------------------------------------------
slotNames('Data')
# Can also read in data as .csvs
# e.g. <- new('Data',"C:/Data/Pacific_WM.csv")

# Otherwise you can just make a new Data object, just like Stock, Fleet, Obs, 
#   and Imp objects
myData <- new('Data')
myData@Year = 2008:2017
myData@Cat = matrix(
  c(3.36,4.29,4.11,4.63,3.03,3.77,4.01,3.25,2.89,2.87),
  nrow=1)
myData@Dep = 0.33
myData@CV_Dep = 0.2

# Cheatsheets for objects at /Help/Cheat sheets/

# Running MPs -------------------------------------------------------------
# In many data limited fisheries, it is likely that data prohibits some MPs
# !!! DLMtool has a series of functions to check which MPs can or cannot be used
avail('Data')

# Let's try: 
Can(Cobia) # MPs that can be run with the available data
Cant(Cobia) # MPs that cannot
slotNames(Cobia) # Name of the variable slots available in the dataset

Needed(Cobia) # Returns the MPs that can't be applied and the data needed

# Can calculate TACs for a Data object:
TACs <- TAC(Cobia)
boxplot(TACs)
plot(TACs)

# Can also calculate input recommendations:
Inputs <- Input(Cobia)

# Sensitivity analysis:
Sense1 <- Sense(Cobia, "CC1")
Sense2 <- Sense(Cobia, "BK_CC")

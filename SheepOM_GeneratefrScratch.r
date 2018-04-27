# Created by MDeith on April 21, 2018 to create a sheep OM for DLMtool for FISH 505
# Uses seal OM example but generates OM from scratch
# see http://www.datalimitedtoolkit.org/Case_Studies_Table/Grey_Seal_5ZJM_DFO/Grey_Seal_5ZJM_DFO.html)
# Last modified on April 24, 2018

library(DLMtool)
# library(DLMdata)
setup()

### Only need to run once
# dir.create('baseCaseOM')
setwd("~/Documents/UBC/Classes/FISH505/DLMToolProject/baseCaseOM/")

### Initialize a blank operating model
# OMinit('WMU42_StonesSheep_baseCase2')

### Then, after populating parameters in WMU42_StonesSheep.xlsx
### and documenting changes in markdown in file WMU42_StonesSheep.rmd:
OMdoc('WMU42_StonesSheep_baseCase')
### This generates WMU42_StonesSheep_baseCase.html, a summary of the OM

### Then read it in
stonesSheepOM <- XL2OM("WMU42_StonesSheep_baseCase.xlsx")
# hakeOM <- XL2OM("Example_Chile_Hake.xlsx")
stonesSheepOM

plot(stonesSheepOM)

mps1 <- c('AvC', # Status-quo harvest
#         'curE', # Keep fishing at current effort levels
         'NFref', # No harvesting scenario
         'ITM', # Harvest based on natural mortality
         'matlenlim', # Retention set according to maturity curve
         'CompSRA', # Age-composition based on current estimate of stock depletion; catch-at-age
         'Fdem', #FMSY set to r/2
         'Ltarget4', # Incrementally adjusts the TAC to reach a target mean length in catches
         'slotlim' # Set max and min size limits
)

# mps2 <- c( # Demographic based mortality rate
#          'slotlim', # Set max and min size limits
#          'LstepCE1', # Adjusts TAC based on mean length of recent catches
#          'L95target',
#          'FMSYref',
#          'IT5',
#          'DD',
#          'MCD'
#          )

# sheepMSE_allMP <- runMSE(stonesSheepOM, MPs = c(mps1,mps2), parallel=T)
sheepMSE_baseOM <- runMSE(stonesSheepOM, MPs = mps1, parallel=T)
NOAA_plot(sheepMSE_baseOM)
Kplot(sheepMSE_baseOM)
Tplot(sheepMSE_baseOM)

Converge(sheepMSE_baseOM)

# OM2 - Periodic changes to recruitment -----------------------------------
setwd("~/Documents/UBC/Classes/FISH505/DLMToolProject/periodicRecruitment_om2/")
OMdoc('WMU42_StonesSheep_periodicRec')
stonesSheepOM2 <- XL2OM("WMU42_StonesSheep_periodicRecruitment")
plot(stonesSheepOM2)

sheepMSE_om2 <- runMSE(stonesSheepOM2, MPs = mps1, parallel=T)

NOAA_plot(sheepMSE_om2)
Kplot(sheepMSE_om2)
Tplot(sheepMSE_om2)

Converge(sheepMSE_om2) # Converged


# OM3 - Hunting has lead to a selective shift towards shorter horns -------
setwd("~/Documents/UBC/Classes/FISH505/DLMToolProject/")
dir.create('selectiveHorns_om3')
setwd("~/Documents/UBC/Classes/FISH505/DLMToolProject/selectiveHorns_om3/")

### Initialize a blank operating model
OMinit('WMU42_StonesSheep_selective_om3')
stonesSheepOM3 <- XL2OM("WMU42_StonesSheep_selective_om3")

### FIX RMD !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
OMdoc('WMU42_StonesSheep_selective_om3')
plot(stonesSheepOM3)
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
sheepMSE_om3 <- runMSE(stonesSheepOM3, MPs = mps1, parallel=T)

NOAA_plot(sheepMSE_om3)
Kplot(sheepMSE_om3)
Tplot(sheepMSE_om3)

Converge(sheepMSE_om3) # Converged


# OM4a - Selectivity skewed towards younger(A) males ------------------------
# setwd("~/Documents/UBC/Classes/FISH505/DLMToolProject/")
# dir.create('selectivityYounger_om4a')
setwd("~/Documents/UBC/Classes/FISH505/DLMToolProject/selectivityYounger_om4a/")

### Initialize a blank operating model
OMinit('WMU42_StonesSheep_selectivityYounger_om4a')
stonesSheepOM4a <- XL2OM("WMU42_StonesSheep_selectivityYounger_om4a")
plot(stonesSheepOM4a)

OMdoc('WMU42_StonesSheep_selectivityYounger_om4a')

sheepMSE_om4a <- runMSE(stonesSheepOM4a, MPs = mps1, parallel=T)


# OM4b - Selectivity skewed towards older (B) males -------------------------
# setwd("~/Documents/UBC/Classes/FISH505/DLMToolProject/")
# dir.create('selectivityOlder_om4b')
setwd("~/Documents/UBC/Classes/FISH505/DLMToolProject/selectivityOlder_om4b/")

### Initialize a blank operating model
# OMinit('WMU42_StonesSheep_selectivityOlder_om4b')
stonesSheepOM4b <- XL2OM("WMU42_StonesSheep_selectivityOlder_om4b")
plot(stonesSheepOM4b)

OMdoc('WMU42_StonesSheep_selectivityOlder_om4b')




# List of available MPs and descriptions ----------------------------------

# AvC - maintain average catch, status-quo option
# curE - Fishing at current effort levels
# DCAC - Depletion Corrected Average Catch
# FMSYref - calculate FMSY
# matlenlim - fishing retention is set according to the maturity curve 
# BK and BK_CC - calculates overfishing limit (OFL)
#    OFL = acceptable biological catch
# CC1/4 - TAC based on average catch over last yrsmth years
#    yrsmth = years over which to calculate mean catches 
#    TAC is multiplied by (1-xx), default=0, CC4 reduces by 0.3
# CompSRA - Age-composition based estimate of current stock depl. given constant
#    Z linked to an FMSY estimate to provide OFL
# DAAC - depletion adjusted avg catch
# DCAC4010
# DBSRA - Depletion-Based Stock Reduction Analysis
# DD - Delay - Difference Stock Assessment with UMSY and MSY leading
# DD4010 - Delay - Difference Stock Assessment with UMSY and MSY leading coupled with a 40-10 harvest control rule
# DDe - effort control version of delay difference stock assessment with UMSY and MSY leading
# DDe75 - as above but at 75% of FMSY
# DDes - Delay difference (effort searching version)
#     Effort searching version of DD - Delay - Difference Stock Assessment with 
#    UMSY and MSY leading that fishes at 75 per cent of FMSY
#    MP provides a change in effort in the direction of FMSY up to a maximum change of 10 percent
# DepF - Fratio MP with a HCR, reduces F according to production curve @ depletion
# DTe40 - aim for 40% depletion effort searching MP
# DynF - Dynamic Fratio MP changes F according to relationship bn surplusProd and biomass
# !!! EtargetLopt - adjust effort up/down if mean length above/below LTarget
# Fadapt - Adaptive MP uses trajectory in inferred surplus production and 
#    Fishing mortality rate to update a TAC
# Fdem - Demographic FMSY; FMSY=r/2 where r calculated from demographics incl 
#   steepness, coupled with estimate of current abundance that gives OFL
# FMSYref - reference FMSY method (uses perfect information about FMSY)
# Fratio - FMSY/M ratio method; Calculates the OFL based on a fixed ratio of 
#    FMSY to M multiplied by a current estimate of abundance
# GB_CC - A simple MP that aims for average historical catches (as a proxy for MSY) subject to imperfect information.
# GB_slope - MP similar to SBT1 that modifies a time-series of catch recommendations and aims for a stable catch rates
# Gcontrol - Uses trajectory in inferred surplus production to inc/dec TAC
# HDAAC - hybrid depletn adj avg catch; DCAC multipled by 2*depletion and 
#    divided by BMSY/B0 when below BMSY, and DCAC above BMSY
# Islope1/4 - least precautionary of index/CPUE methods; incrementally adjusts TAC to maintain constant CPUE/relative abundance index
# IT10 - Index target 10 - TAC modified according to current index levels (mean over 5 years),
#    max change 10%
# Itarget1/4 - Incrementally adjusts TAC to reach target CPUE/relative abun index
# ITe10 - index target MP, effort modified according to current index levels (mean index 5 yrs)
# ITM - Index target based on natural mortality M
# L95target - adjusts TAC up/down from ref point to reach target mean length of fish caught
# LstepCC1/4 - adjusts TAC according to mean length of recent catches
# LstepCE1/4 - effort-based version of the above
# Ltarget1 - incrementally adjusts TAC to reach target mean L
# LtargetE1 - adjusts effort to reach mean target length catches
# matlenlim (matlenlim2: vulnerability higher than mat curve) - fishing retention set to maturity curve; input control
# MCD (4010: 40/10 HCR) - mean catch depletion; average catch-depletion MP
# minlenLopt1 - minimum length of fish caught to fraction of L that maximizes biomass, Lopt
#    Restrict the catch of small fish to rebuild stock biomass towards the opt length
# MRnoreal - marine reserve in area 1, no spatial reallocation
# NFref - sets annual catch to zero - stock variability with no fishing
# Rcontrol (2) - HCR using prior for r; modifies TAC according to trends in apparent
#   surplus production
# SBT1 - makes incremental adjustments to TAC recommendations based on apparent 
#   trend in CPUE
# slotlim - selectivity at length is set using a slot limit - min/max legal length
#   max limit it set as the 75% between new minimum legal length and asymp length
# SPmod - surplus production based catch-lim modifier - adj. TAC based on trend in surplus production
# SPMSY - predicts K, r, to calculate surplus production + OFL
# SPslope - makes incremental adjustments to TAC based on trend in surplus prod.
# SPSRA - surplus production SRA; surplus production equivalent of DB-SRA; uses \
#   prior for intrinsic rate of increase
# SPslope - makes incremental adjustments to TAC recommendations based on 
#   apparent trend in slope in surplus production
# SPSRA - surplus production SRA; equivalent of DB-SRA that uses a demograph.
#   derived prior for r
# SPSRA_ML - surplus prod. equivalent of DB-SRA that uses a demograph. derived 
#   derived prior for r; prior for depletion is calculated from mean length est.
# YPR - yield-per-recruit analysis to get FMSY proxy F01 ???
# YPR_ML - yield per recruit analysis to get FMSY proxy F01 paired with mean 
#   length of current stock size
# Created by MDeith on April 21, 2018 to create a sheep OM for DLMtool for FISH 505
# Uses seal OM example 
# see http://www.datalimitedtoolkit.org/Case_Studies_Table/Grey_Seal_5ZJM_DFO/Grey_Seal_5ZJM_DFO.html)
# Follows instructions from PDF lessons from Murdoch for FISH 505
# Last modified on April 21, 2018

library(DLMtool)
# library(DLMdata)
setup()

sealOM <- readRDS('E://Mairin/Fish505/DLMToolProject/OM.rdata')

# Harvest and conservation objectives -------------------------------------
# Harvest objective: maximize the number of full-adult males available for
#   for harvest
# Harvest objective: maximize the average horn size of harvested males
# Conservation objective: keep male population above 1/20 of B0 female pop'n


# Identify and list types of information available to make OM -------------
#   Catch-at-age data
#   Mark-recapture studies to estimate natural mortality rates
#   Biological surveys that describe horn-length and age relationships
# 



# Applicable MPs ----------------------------------------------------------
# Input controls:
MPtype(avail('MP'))


# MPs to use in this analysis ---------------------------------------------
# How do I determine the data necessary to run an MP?
newData <- new('Data')
Can(newData)

# 
length(avail('MP'))

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
# Load Seal OM as an example:
sealOM <- readRDS('OM.rdata')
sheepInput <- XL2OM("DLMTool/StonesSheep_WMU42.xlsx")

summary(sealOM)
sealOM@DR
myMSE = runMSE( sealOM, MPs = c('AvC','Fratio','DD','Gcontrol','DCAC', 'DBSRA') )

sealCPars <- sealOM@cpars
sheepOM <- sealOM

# Change stock characteristics:
sheepOM@maxage = 15
sheepOM@R0 = 294.04635
sheepOM@M = c(0.543,0.0736465,0.0315,0.041,0.051, 0.063,0.098,0.154,0.256,0.412,0.766,1.204,1.204,1.204,1.204)
sheepOM@M2 = sheepOM@M+0.1

sheepOM@Msd = c(0.05,0.15)
sheepOM@h = c(0.75,0.9)
sheepOM@Perr
sheepOM@AC = c(0.25,0.65) # Autocorrelation in recruits can be variable
sheepOM@Linf = c(100,135)
sheepOM@K = c(0.32,0.42)
sheepOM@t0 = c(-0.1, 0.42)
sheepOM@LenCV = c(0.1,0.12)
sheepOM@L50 = c(65,80)
sheepOM@L50_95 = c(10,30)
sheepOM@D = c(0.65,0.75)
sheepOM@EffYears = sheepInput@EffYears
sheepOM@EffLower = sheepInput@EffLower
sheepOM@EffUpper = sheepInput@EffUpper
# sheepOM@isRel = sealOM@isRel

# cpars for maturity at age (Mat_age):
# Dim = 80x36x89
# nsim = 80, maxage=36, total simyears=89 (recorded+projected)

mySheepMSE <- runMSE(sheepOM, parallel = T)

##########################
# !!!!!!!!!!!!!!!!!!!!!!!
# !!!!!!!!!!!!!!!!!!!!!!!
#  ... not completed ...
# !!!!!!!!!!!!!!!!!!!!!!!
# !!!!!!!!!!!!!!!!!!!!!!!
# Alternatively:

sheepMSE1 <- runMSE(sheepInput, parallel = T)

sealInput <- XL2OM("DLMTool/Grey_Seal_5ZJM_DFO.xlsx")
sealInput@cpars <- sealOM@cpars
sealMSE1 <- runMSE(sealInput, parallel = T)

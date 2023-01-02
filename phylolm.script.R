##############################################################################################
########################## Prune tree to a list of taxa ##############################
# ML big tree foorm IQ-TREE as input tree
library(phytools)
#library(ape)

# Set working dir
setwd("~/path/to/Files")

# read tree
treefile <- read.nexus('Orthoptera_big_timecalibrated.tree')
is.ultrametric(treefile)
plot(treefile)
View(treefile)
treefile$tip.label
a <- treefile$tip.label
#write.table(a, file = "Orthoptera_big_timecalibrated.tree.tip.labels.txt", quote = FALSE)
View(treefile$tip.label)
b <- c("TRIGONIDIIDAE|MGOCF183-16|Eunemobius_carolinus|COI-5P",
       "GRYLLIDAE|GBUPS010-14|Gryllus_assimilis|COI-5P",
       "TETTIGONIIDAE|FBORT413-10|Phaneroptera_falcata|COI-5P|HQ955740",
       "RHAPHIDOPHORIDAE|CDBLM024-19|Diestrammena_japonica|COI-5P",
       "STENOOPELMATIDAE|GBMNF33800-22|Stenopelmatus_piceiventris|COI-5P|MZ313381",
       "ANOSTOSTOMATIDAE|GBMH5440-09|Hemideina_crassidens|COI-5P|EU676738",
       "GRYLLOTALPIDAE|GBMOR1657-15|Gryllotalpa_orientalis|COI-5P|KM362677",
       "TETRIGIDAE|GBMH5250-09|Tetrix_japonica|COI-5P|EU414808",
       "MORABIDAE|GBMH5780-09|Warramaba_virgo|COI-5P|FJ361854",
       "PYRGOMORPHIDAE|GBMH5062-08|Pyrgomorpha_conica|COI-5P|EU031777",
       "PAMPHAGIDAE|GBMOR7322-19|Glyphotmethis_adaliae|COI-5P|MG895901",
       "ACRIDIDAE|GBMH0128-06|Schistocerca_gregaria|COI-5P|AF260532",
       "ROMALEIDAE|GBMOR7493-19|Zoniopoda_tarsata|COI-5P|MF682225",
       "TRIDACTYLIDAE|GBMIN40407-13|Tridactylus_sp.|COI-5P|FJ545412",
       "SCHIZODACTYLIDAE|GBMOR4173-19|Comicus_campestris|COI-5P|KJ889606")

# We create the pruned tree with one command using the list of taxa
pruned.tree <- drop.tip(treefile, treefile$tip.label[-na.omit(match(b, treefile$tip.label))])
pruned.tree$tip.label
plot(pruned.tree)
View(pruned.tree)
is.ultrametric(pruned.tree)
write.tree(pruned.tree, file = "~/path/to/Files/pruned.treefile") #this for saving the file with th rooted trees in .tre format

############################### Package ‘phylolm’ ###############################################
# Provides functions for fitting phylogenetic linear models and 
# phylogenetic generalized linear models. The computation uses an algorithm that is linear in 
# the number of tips in the tree. The package also provides functions for simulating continuous 
# or binary traits along the tree. Other tools include functions to test the adequacy of a 
# population tree.
#################################################################################################
library("phylolm")
library("datapasta")

# Input tree
plotTree(pruned.tree,fsize = 0.5, ftype="i")
taxa = pruned.tree$tip.label
taxa

# Speciation rate is the response variable (= trait)
trait <- c(0.0431, 0.0392, 0.032, 0.0409, 0.0379, 0.0206, 0.0358, 0.0355, 0.0937, 0.0235, 0.0629, 0.0486, 0.0421, 0.0474, 0.0108)
trait <- log(trait)

# Rate of karyotype evolution is the predictor (= pred)
pred <- c(0.2528, 0.2896, 0.1922, 0.8522, 0.3395, 0.3676, 0.6297, 0.0238, 0.2295, 0.0291, 0.0447, 0.0852, 0.0158, 0.1275, 0.1315)
pred <-log(pred)
  
dat1 <- data.frame(trait, pred)
rownames(dat1) <- b
dat1
# Fitting the models: BM, OUfixedRoot, OUrandomRoot, kappa, delta, EB.
# And the best model is kappa
fit1 = phylolm(trait~pred, data = dat1, phy = pruned.tree, 
               model = "kappa", measurement_error = TRUE, boot = 100)
summary(fit1)
vcov(fit1)

# Compute the analysis of variance
res.aov = aov(trait~pred, data = dat1)
summary(res.aov)

#define plot area with tiny bottom margin and huge right margin
par(mfrow = c(3,1), las = 1, bty = "o",
    mar = c(4, 10, 2, 10), 
    cex.axis= 1.4, cex.lab= 2) # mar = bottom, left, top, right
#layout(matrix(c(1,1,2,3), 2, 2, byrow = TRUE))
#p1 <- plot(fit1, col = 'black', pch = 16)
p1 <- plot(pred,jitter(trait,factor=0,amount=0.02),
     xlab= "rate of chromosomal evolution (log changes/sp/My)", 
     ylab="speciation rate (log sp/sp/My)", xlim=c(-4.5,0),
     col = 'black', pch = 16)
abline(fit1)
# this add the labels to the points using their rownames
text(trait~pred, labels=rownames(dat1), data = dat1, cex = 0.5, font = 0.5)

#################################################################################################
# Cladogenetic chromosomal evolution is the response variable (= trait) as % of total chromosomal evolution
trait2 <- c(7.080696203, 9.495856354, 7.339927121, 2.957052335, 6.745213549, 3.618063112, 3.858980467, 30.67226891, 33.59477124, 31.27147766, 35.79418345, 8.802816901, 43.67088608, 17.33333333, 5.247148289)
log(trait2)
dat2 <- data.frame(trait2, pred)
rownames(dat2) <- b
dat2

fit2 = phylolm(trait2~pred, data = dat2, phy = pruned.tree, 
               model = "kappa", measurement_error = TRUE, boot = 100)
summary(fit2)
vcov(fit2)
#p2 <- plot(fit2, col = 'black', pch = 16, xlim =c(0, 45))
p2 <- plot(pred,jitter(trait2,factor = 0,amount = 0.02),
           xlab= "rate of chromosomal evolution (log changes/sp/My)", 
           ylab="cladogenetic chromosomal evolution as % of total chromosomal evolution", 
           xlim=c(-4.5, 0),
           col = 'black', pch = 16)
abline(fit2)
# this add the labels to the points using their rownames
text(trait2~pred, labels=rownames(dat2), data = dat2, cex = 0.5, font = 1)

###############################################################################################
# Rate of chromosomal fission is the response variable (= trait)
trait3 <- c(0.1251, 0.1296, 0.0251, 0.5087, 0.1891, 0.2094, 0.286, 0.0098, 0.0986, 0.0118, 0.0267, 0.0367, 0.0051, 0.0656, 0.057)
trait3 <- log(trait3)

# Rate of chromosomal fusion is the pedictor (= pred)
pred2 <- c(0.1277, 0.16, 0.1671, 0.3435, 0.1504, 0.1582, 0.3437, 0.014, 0.1309, 0.0173, 0.018, 0.0485, 0.0107, 0.0619, 0.0745)
pred2 <- log(pred2)

dat3 <- data.frame(trait3, pred2)
rownames(dat3) <- b
dat3

fit3 = phylolm(trait3~pred2, data = dat3, phy = pruned.tree, model = "kappa",
               measurement_error = TRUE, boot = 100) # Ornstein–Uhlenbeck with fixed root
summary(fit3)
vcov(fit3)
#p3 <- plot(fit3, col = 'black', pch = 16)
p3 <- plot(pred,jitter(trait3,factor = 0,amount = 0.02),
           xlab= "rate of chromosomal fusion (log changes/sp/My)", 
           ylab="rate of chromosomal fission (log changes/sp/My)", 
           xlim=c(-4.5, 0),
           col = 'black', pch = 16)
abline(fit3)
# this add the labels to the points using their rownames
text(trait3~pred2, labels = rownames(dat3), data = dat3, cex = 0.5, font = 1)

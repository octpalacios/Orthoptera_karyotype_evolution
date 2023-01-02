##############################################################################################
########################## Prune tree to a list of taxa ##############################
# ML big tree foorm IQ-TREE as input tree
library(phytools)
#library(ape)

# Set working dir
setwd("/path/to/files")

# read tree
treefile <- read.nexus('Orthoptera_big_timecalibrated.tree')
is.ultrametric(treefile)
plot(treefile)
View(treefile)
treefile$tip.label
a <- treefile$tip.label
write.table(a, file = "Orthoptera_big_timecalibrated.tree.tip.labels.txt", quote = FALSE)
View(treefile$tip.label)

# Read the list of karyotyped species that matched the tree
t <- read.csv("Acrididae.species.file.txt", header = F, quote = "", sep = "")
t <- c(t$V1)
t <- dput(as.character(t))  # a comma separated vector
View(t)
head(t)
summary(t)

# We create the pruned tree with one command using the list of taxa
pruned.tree <- drop.tip(treefile, treefile$tip.label[-na.omit(match(t, treefile$tip.label))])
pruned.tree$tip.label
plot(pruned.tree)
View(pruned.tree)
is.ultrametric(pruned.tree)
plot(pruned.tree)
write.tree(pruned.tree, file = "Acrididae.species.pruned.treefile") #this for saving the file with th rooted trees in .tre format

Karyotype <- read.delim("Acrididae.speciesK2n.file.txt", header = F)
rownames(Karyotype) <- Karyotype[,1]
Karyotype <- setNames(Karyotype$V2, rownames(Karyotype))

# create "contMap" object
Acrididae.contMap <- contMap(pruned.tree, Karyotype, plot = FALSE, res = 100)          

## change color scheme
#Acrididae.contMap <- setMap(Acrididae.contMap,
#                       c("white","#FFFFB2","#FECC5C","#FD8D3C",
#                         "#E31A1C"))
plot(Acrididae.contMap, fsize = c(0.5,0.8),
     leg.txt="")
#par(mar=c(5.1,4.1,4.1,2.1)) ## reset margins to default

# Ancestral character estimation using likelihood
fit.BM <- anc.ML(pruned.tree, Karyotype, model = "kappa") 
print(fit.BM)
  
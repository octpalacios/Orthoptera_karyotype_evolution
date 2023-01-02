##############################################################################################
########################## Prune tree to a list of taxa ##############################
# ML big tree foorm IQ-TREE as input tree
library(phytools)
#library(ape)

# Set working dir
setwd("/path/to/dir")

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
t <- read.csv("Tettigoniidae.species.file.txt", header = F, quote = "", sep = "")
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
write.tree(pruned.tree, file = "Tettigoniidae.species.pruned.treefile") #this for saving the file with th rooted trees in .tre format


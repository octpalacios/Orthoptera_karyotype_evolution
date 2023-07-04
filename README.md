# Karyotype evolution and speciation in Orthoptera
This repository contains data and code to reproduce analyses reported in the manuscript "Speciation and karyotype evolution in Orthoptera".

# Repository structure
Analyses: contains code to reproduce analyses, simulations and figures.

Data: includes the datasets analysed for this manuscript. It contains the aligned molecular DNA sequencing data (bold_systems.COI-5P.dedupe.6.framed.513sp.fasta_large.aln.fasta) used for phylogenetic reconstruction, the Orthoptera calibrated phylogenetic tree (Orthoptera.treePL.trials.dated.rnds5-8.combined.treefile), the pruned trees for each family (.species.pruned.treefiles), the haploid karyotype number for each species (.kn.male.txt files) within family used to run ChromoSSE model1 and model2 (this excluding clado_fusion and clado_fission) models with RevBayes, and the out files of the ChromoSSE analysis summarizing the values from the traces over the phylogeny for each family (model1 and model2 .log files).

The names of all other files should be self-explanatory. If they are not, please open an issue in this repository.

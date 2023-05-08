# Orthoptera karyotype evolution
It contains the scripts to run ChromoSSE model with RevBayes, and the related scripts used for the analysis of karyotype evolution, speciation rate and phylogenetic linear regression (phylogenyplot.R, ChromoSSE_simple.Rev, phylolm.R, and contMap.R).

# Repository structure
Analyses: contains the aligned molecular DNA sequencing data (bold_systems.COI-5P.dedupe.6.framed.513sp.fasta_large.aln.fasta) used for phylogenetic reconstruction, the Orthoptera calibrated phylogenetic tree (Orthoptera.treePL.trials.dated.rnds5-8.combined.treefile), the pruned trees for each family (*.species.pruned.treefile), the karyotyped species (haploid number) for each family (*.kn.file.txt) used to run ChromoSSE model with RevBayes, and the out files of the ChromoSSE analysis summarizing the values from the traces over the phylogeny for each family (*.ChromoSSE_model.log)

Data: includes the datasets analysed for this manuscript.

The names of all other files should be self-explanatory. If they are not, please open an issue in this repository.

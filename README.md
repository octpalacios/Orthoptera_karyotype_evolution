# Karyotype evolution and speciation in Orthoptera
This repository contains data and code to reproduce analyses reported in the manuscript "Karyotype evolution and speciation in Orthoptera".

# Repository structure
Analyses: contains code to reproduce analyses, simulations and figures.

Data: includes the datasets analysed for this manuscript. It contains the aligned molecular DNA sequencing data (bold_systems.COI-5P.dedupe.6.framed.513sp.fasta_large.aln.fasta) used for phylogenetic reconstruction, the output tree file of IQ-TREE (bold_systems.COI-5P.dedupe.6.framed.513sp.fasta_large.aln.fasta.treefile), the Orthoptera calibrated phylogenetic tree (Orthoptera.treePL.trials.dated.rnds5-8.combined.treefile), the pruned trees for each family (.species.pruned.treefiles), the haploid karyotype number for each species (.kn.male.txt files) within family used to run ChromoSSE model1 and model2 (this excluding clado_fusion and clado_fission) models with RevBayes, the out files of the ChromoSSE analysis summarising the values from the traces over the phylogeny for each family (model1 and model2 .log files), the data matrix representing both the observed haploid n chromosome counts and the observed phenotype (Orthoptera.kn.male_phenotype_24_04_2024_matrix.BiChroM.txt and Orthoptera.kn.male_phenotype_24_04_2024_raw.txt) and the out log file of the BiChroM analysis (BiChroM_model.log).

The names of all other files should be self-explanatory. If they are not, please open an issue in this repository.

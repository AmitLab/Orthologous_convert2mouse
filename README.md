# Orthologous_convert2mouse
---------------------------------------------------------------
Ortholog gene selection
---------------------------------------------------------------
To compare between species, we first created a gene ortholog table using the mouse genome as the reference gene list. We performed gene homology search, using ensemble multiple species comparison tool (http://www.ensembl.org/biomart/martview). Briefly, each specie was compared to mouse and high-quality orthologues genes list was extracted (gene order conservation score above 75, whole genome alignment score above 75 and minimum sequence identity above 80%). To account for gene paralogues and gene-duplication events, an aggregated table of “meta-genes” was created. Each meta-gene may include all gene symbols homologous to one mouse gene. For each organism, read counts were aggregated across all manifestations of each meta-gene. (For example, if zebrafish’s actb1 had 2 read, and actb2 3 read, the Actb meta-gene named acta1_acta2 received 5 total reads). Missing genes in species were given NaN value.


perl convert2mouse.pl mouse2sheep.txt sheep_exons_oa3_raw.txt > mouseof_sheep.txt

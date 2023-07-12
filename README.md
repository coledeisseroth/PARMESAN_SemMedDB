<h1>PARMESAN-SemMedDB Combination</h1>
This repository is designed to combine the relationship extractions of PARMESAN and SemMedDB.

<h1>Data files required</h1>
PARMESAN:
Literature-based predictions of treatments for genetic disease pathology
Cole A. Deisseroth, Won-Seok Lee, Ji-Yoen Kim, Hyun-Hwan Jeong, Julia Wang, Huda Y. Zoghbi, Zhandong Liu
bioRxiv 2022.09.08.506253; doi: https://doi.org/10.1101/2022.09.08.506253 
The code used to generate the needed data files can be downloaded here:
https://github.com/coledeisseroth/PARMESAN

SemMedDB:
Halil Kilicoglu and others, SemMedDB: a PubMed-scale repository of biomedical semantic predications, Bioinformatics, Volume 28, Issue 23, December 2012, Pages 3158–3160, https://doi.org/10.1093/bioinformatics/bts591 
The data can be accessed here:
https://lhncbc.nlm.nih.gov/ii/tools/SemRep_SemMedDB_SKR.html

Unified Medical Language System (UMLS) Metathesaurus:
Bodenreider O. The Unified Medical Language System (UMLS): integrating biomedical terminology. Nucleic Acids Res. 2004 Jan 1;32(Database issue):D267-70. doi: 10.1093/nar/gkh061. PMID: 14681409; PMCID: PMC308795.
The data can be accessed here:
https://www.nlm.nih.gov/research/umls/knowledge_sources/metathesaurus/index.html


To run the SemMedDB-PARMESAN integration, you must first acquire the needed data.
1. Add the UMLS Metathesaurus file ("umls-2022AB-full.zip") to the "umls/raw/" directory
2. Run the BUILD script ("bash BUILD") in the umls directory
3. Add the SemMedDB predication file ("semmedVER43_2023_R_PREDICATION.116080.csv.gz") to "semmeddb/raw/" directory
4. Upon running the default PARMESAN pipeline ("github.com/coledeisseroth/PARMESAN"), and within that repository, find the folder "PARMESAN/semmeddb_comparison_export/". Copy the contents of this folder to a folder here titled "parmesan_import"
5. In the "semmeddb" directory, run "bash BUILD"
6. In the "precision_recall" directory, run "bash BUILD"

All genes are indexed by Entrez ID and all drugs by PubChem ID

Upon completion, gene modifier extractions for SemMedDB alone will be here:
semmeddb/extractions/gene_consensus_directionality.txt
The format is:
Modifier	Target	Directionality score

The accuracy values for SemMedDB extractions at each directionality score threshold will be here:
semmeddb/extractions/gene_reactome_scoretable.txt
The format is:
Score threshold	No. correct extractions in the ground-truth comparison	No. incorrect extractions in the ground-truth comparison	Accuracy

Gene modifier predictions for SemMedDB alone will be here:
semmeddb/predictions/gene_hypotheses.txt
The format is:
Modifier        Target  Directionality score

The accuracy values for predictions at each directionality score threshold will be here:
semmeddb/predictions/reactome_raw_scoretable.txt
The format is:
Score threshold        No. correct predictions in the ground-truth comparison  No. incorrect predictions in the ground-truth comparison	Accuracy

Gene modifier extractions for PARMESAN + SemMedDB will be here:
semmeddb/parmesan_combined/gene_consensus_directionality.txt
The format is:
Modifier        Target  Directionality score

Gene modifier predictions for PARMESAN + SemMedDB will be here:
semmeddb/parmesan_combined_predictions/gene/pergene
For each target gene, there will be a file whose name is the entrez ID of that gene. For example, the predicted modifiers of MeCP2 will be in the file titled "4204".
The format for each table is:
Modifier        Target  Directionality score

The accuracy values for predictions at each directionality score threshold will be here:
semmeddb/parmesan_combined_predictions/gene/reactome_raw_scoretable.txt
The format is:
Score threshold        No. correct predictions in the ground-truth comparison  No. incorrect predictions in the ground-truth comparison Accuracy

Drug modifier extractions for SemMedDB alone will be here:
semmeddb/extractions/drug_consensus_directionality.txt
The format is:
Modifier        Target  Directionality score

The accuracy values for SemMedDB extractions at each directionality score threshold will be here:
semmeddb/extractions/drug_dgidb_scoretable.txt
The format is:
Score threshold No. correct extractions in the ground-truth comparison  No. incorrect extractions in the ground-truth comparison        Accuracy

Drug modifier predictions for SemMedDB alone will be here:
semmeddb/predictions/no_dgidb_drug_hypotheses.txt
The format is:
Modifier        Target  Directionality score

The accuracy values for predictions at each directionality score threshold will be here:
semmeddb/predictions/dgidb_raw_scoretable.txt
The format is:
Score threshold        No. correct predictions in the ground-truth comparison  No. incorrect predictions in the ground-truth comparison Accuracy

Drug modifier extractions for PARMESAN + SemMedDB will be here:
semmeddb/parmesan_combined/drug_consensus_directionality.txt
The format is:
Modifier        Target  Directionality score

Drug modifier predictions for PARMESAN + SemMedDB will be here:
semmeddb/parmesan_combined_predictions/no_dgidb/pergene
For each target gene, there will be a file whose name is the entrez ID of that gene. For example, the predicted modifiers of MeCP2 will be in the file titled "4204".
The format for each table is:
Modifier        Target  Directionality score

The accuracy values for predictions at each directionality score threshold will be here:
semmeddb/parmesan_combined_predictions/no_dgidb/dgidb_raw_scoretable.txt
The format is:
Score threshold        No. correct predictions in the ground-truth comparison  No. incorrect predictions in the ground-truth comparison Accuracy



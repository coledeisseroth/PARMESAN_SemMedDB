<h1>PARMESAN-SemMedDB Combination</h1>
This repository is designed to combine the relationship extractions of PARMESAN and SemMedDB.

<h1>Data files required</h1>
<h2>PARMESAN</h2>

Literature-based predictions of treatments for genetic disease pathology
Cole A. Deisseroth, Won-Seok Lee, Ji-Yoen Kim, Hyun-Hwan Jeong, Julia Wang, Huda Y. Zoghbi, Zhandong Liu
bioRxiv 2022.09.08.506253; doi: https://doi.org/10.1101/2022.09.08.506253 

The code used to generate the needed data files can be downloaded here:

https://github.com/coledeisseroth/PARMESAN

<h2>SemMedDB</h2>

Halil Kilicoglu and others, SemMedDB: a PubMed-scale repository of biomedical semantic predications, Bioinformatics, Volume 28, Issue 23, December 2012, Pages 3158–3160, https://doi.org/10.1093/bioinformatics/bts591 

The data can be accessed here:

https://lhncbc.nlm.nih.gov/ii/tools/SemRep_SemMedDB_SKR.html

<h2>Unified Medical Language System (UMLS) Metathesaurus</h2>

Bodenreider O. The Unified Medical Language System (UMLS): integrating biomedical terminology. Nucleic Acids Res. 2004 Jan 1;32(Database issue):D267-70. doi: 10.1093/nar/gkh061. PMID: 14681409; PMCID: PMC308795.

The data can be accessed here:

https://www.nlm.nih.gov/research/umls/knowledge_sources/metathesaurus/index.html

<h1>Setup</h1>
To run the SemMedDB-PARMESAN integration, you must first acquire the needed data.
1. Add the UMLS Metathesaurus file <code>umls-2022AB-full.zip</code> to the <code>umls/raw/</code> directory
2. Run the BUILD script <code>bash BUILD</code> in the <code>umls</code> directory
3. Add the SemMedDB predication file <code>semmedVER43_2023_R_PREDICATION.116080.csv.gz</code> to <code>semmeddb/raw/</code> directory
4. Upon running the default PARMESAN pipeline (<a href="//github.com/coledeisseroth/PARMESAN">github.com/coledeisseroth/PARMESAN</a>), and within that repository, find the folder <code>PARMESAN/semmeddb_comparison_export/</code>. Copy the contents of this folder to a folder here titled <code>parmesan_import</code>
5. In the <code>semmeddb</code> directory, run <code>bash BUILD</code>
6. In the <code>precision_recall</code> directory, run <code>bash BUILD</code>

All genes are indexed by Entrez ID and all drugs by PubChem ID

<h1>Output</h1>
<h2>Gene modifiers</h2>
<h3>SemMedDB alone</h3>
<h4>Extracted known relationships</h4>
Upon completion, gene modifier extractions for SemMedDB alone will be here:

<code>semmeddb/extractions/gene_consensus_directionality.txt</code>

The format is:

Modifier[tab]Target[tab]Directionality score

The accuracy values for SemMedDB extractions at each directionality score threshold will be here:

<code>semmeddb/extractions/gene_reactome_scoretable.txt</code>

The format is:

Score threshold[tab]No. extractions consistent with the manually curated database[tab]No. extractions contradicted by the manually curated database[tab]Accuracy

<h4>Predicted relationships</h4>
Gene modifier predictions for SemMedDB alone will be here:

<code>semmeddb/predictions/gene_hypotheses.txt</code>

The format is:

Modifier[tab]Target[tab]Directionality score

The accuracy values for predictions at each directionality score threshold will be here:

<code>semmeddb/predictions/reactome_raw_scoretable.txt</code>

The format is:

Score threshold[tab]No. extractions consistent with the manually curated database[tab]No. extractions contradicted by the manually curated database[tab]Accuracy

<h3>PARMESAN-SemMedDB combination</h3>
<h4>Extracted known relationships</h4>
Gene modifier extractions for PARMESAN + SemMedDB will be here:

<code>semmeddb/parmesan_combined/gene_consensus_directionality.txt</code>

The format is:

Modifier[tab]Target[tab]Directionality score

<h4>Predicted relationships</h4>
Gene modifier predictions for PARMESAN + SemMedDB will be here:

<code>semmeddb/parmesan_combined_predictions/gene/pergene</code>

For each target gene, there will be a file whose name is the entrez ID of that gene. For example, the predicted modifiers of MeCP2 will be in the file titled "4204".

The format for each table is:

Modifier[tab]Target[tab]Directionality score

The accuracy values for predictions at each directionality score threshold will be here:

<code>semmeddb/parmesan_combined_predictions/gene/reactome_raw_scoretable.txt</code>

The format is:

Score threshold[tab]No. extractions consistent with the manually curated database[tab]No. extractions contradicted by the manually curated database[tab]Accuracy

<h2>Drug modifiers</h2>
<h3>SemMedDB alone</h3>
<h4>Extracted known relationships</h4>
Drug modifier extractions for SemMedDB alone will be here:

<code>semmeddb/extractions/drug_consensus_directionality.txt</code>

The format is:

Modifier[tab]Target[tab]Directionality score

The accuracy values for SemMedDB extractions at each directionality score threshold will be here:

<code>semmeddb/extractions/drug_dgidb_scoretable.txt</code>

The format is:

Score threshold[tab]No. extractions consistent with the manually curated database[tab]No. extractions contradicted by the manually curated database[tab]Accuracy

<h4>Predicted relationships</h4>
Drug modifier predictions for SemMedDB alone will be here:

<code>semmeddb/predictions/no_dgidb_drug_hypotheses.txt</code>

The format is:

Modifier[tab]Target[tab]Directionality score

The accuracy values for predictions at each directionality score threshold will be here:

<code>semmeddb/predictions/dgidb_raw_scoretable.txt</code>

The format is:

Score threshold[tab]No. extractions consistent with the manually curated database[tab]No. extractions contradicted by the manually curated database[tab]Accuracy

<h3>PARMESAN-SemMedDB combination</h3>
<h4>Extracted known relationships</h4>
Drug modifier extractions for PARMESAN + SemMedDB will be here:

<code>semmeddb/parmesan_combined/drug_consensus_directionality.txt</code>

The format is:

Modifier[tab]Target[tab]Directionality score

<h4>Predicted relationships</h4>
Drug modifier predictions for PARMESAN + SemMedDB will be here:

<code>semmeddb/parmesan_combined_predictions/no_dgidb/pergene</code>

For each target gene, there will be a file whose name is the entrez ID of that gene. For example, the predicted modifiers of MeCP2 will be in the file titled "4204".

The format for each table is:

Modifier[tab]Target[tab]Directionality score

The accuracy values for predictions at each directionality score threshold will be here:

<code>semmeddb/parmesan_combined_predictions/no_dgidb/dgidb_raw_scoretable.txt</code>

The format is:

Score threshold[tab]No. extractions consistent with the manually curated database[tab]No. extractions contradicted by the manually curated database[tab]Accuracy

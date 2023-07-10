zcat ../raw/semmedVER43_2023_R_PREDICATION.116080.csv.gz | sed 's/","/\t/g' | cut -d'"' -f2- | rev | cut -d'"' -f2- | rev | awk 'BEGIN {FS = "\t"} ($11 == "gngm" || $11 == "aapp") && ($7 == "gngm" || $7 == "aapp" || $7 == "orch" || $7 == "phsu")' | cut -f3,4,5,6,7,9,10,11 > raw_umls_relationships.txt
cat raw_umls_relationships.txt | sort -t$'\t' -k2,2 | join -t$'\t' -1 1 -2 2 <(cat ../predicate_direction.txt | sort -t$'\t' -k1,1) - | cut -f2- > directionality.txt

cat ../../umls/id_maps/concept_id_mappings.txt | sed 's/|/\t/g' | awk 'BEGIN {FS = "\t"} $3 == "HGNC"' | cut -f1,4 | sort -u > umls_to_hgnc.txt

python3 ../../src/separate_entities.py directionality.txt > directionality_separated.txt

(cat umls_to_hgnc.txt | sort -k2,2 | join -t$'\t' -1 2 -2 1 - <(cat ../../parmesan_import/hgnc_to_entrez.txt | sort -k1,1) | cut -f2- | sort -u; cat ../../parmesan_import/human_genes.txt | awk '{print $1 "\t" $1}') > semmeddb_gene_entrez_map.txt

cat directionality_separated.txt | sort -t$'\t' -k3,3 | join -t$'\t' -1 3 -2 1 - <(cat semmeddb_gene_entrez_map.txt | sort -t$'\t' -k1,1) | cut -f2- | sort -t$'\t' -k5,5 | join -t$'\t' -1 5 -2 1 - <(cat semmeddb_gene_entrez_map.txt | sort -t$'\t' -k1,1) | cut -f2- | awk 'BEGIN {FS = "\t"} {print $2 "\t" $7 "\t" $8 "\t" $1}' | sort -u > gene_gene_extractions.txt

cat directionality_separated.txt | awk 'BEGIN {FS = "\t"} {key = tolower($4); gsub(" ", "", key); gsub("-", "", key); gsub(";", "", key); gsub(",", "", key); print key "\t" $0}' | sort -t$'\t' -k1,1 | join -t$'\t' <(cat ../../parmesan_import/filtered_id_maps.txt | sort -t$'\t' -k1,1) - | cut -f2,3,4,8 | sort -u | sort -t$'\t' -k4,4 | join -t$'\t' -1 4 -2 1 - <(cat semmeddb_gene_entrez_map.txt | sort -t$'\t' -k1,1) | cut -f2- | awk 'BEGIN {FS = "\t"} {print $3 "\t" $1 "\t" $4 "\t" $2}' | sort -u > drug_gene_extractions.txt

for prefix in gene drug; do
cat ${prefix}_gene_extractions.txt | cut -f2- | awk 'BEGIN {FS = "\t"} {print $1 "_" $2 "\t" $3}' | sort -k1,1 | awk 'BEGIN {rel = ""; pos = 0; neg = 0} {if($1 != rel && rel != ""){print rel "\t" pos "\t" neg; pos = 0; neg = 0} rel = $1; if($2 > 0){pos += $2} if($2 < 0){neg -= $2}} END {print rel "\t" pos "\t" neg}' | sed 's/_/\t/g' > ${prefix}_consensus_sums.txt
cat ${prefix}_consensus_sums.txt | awk '{print $1 "\t" $2 "\t" ($3 - $4) * sqrt(($3 - $4) ^ 2) / ($3 + $4)}' | awk '$3 != 0' | awk '$1 != $2' > ${prefix}_consensus_directionality.txt
done

for i in $(seq 0 100); do cat gene_consensus_directionality.txt | awk 'sqrt($3 ^ 2) > '$i | cut -f1,2 | sort -u | wc -l | awk '{print "'$i'\t" $0}'; done > gene_score_to_count.txt
for i in $(seq 0 100); do cat drug_consensus_directionality.txt | awk 'sqrt($3 ^ 2) > '$i | cut -f1,2 | sort -u | wc -l | awk '{print "'$i'\t" $0}'; done > drug_score_to_count.txt

cat gene_consensus_directionality.txt | awk '{print $1 "_" $2 "\t" $3}' | sort -k1,1 | join -t$'\t' - <(cat ../../parmesan_import/reactome_entrez.txt | awk '{print $1 "_" $2 "\t" $3}' | sort -k1,1) > gene_reactome_comparison.txt
for i in $(seq 0 100); do cat gene_reactome_comparison.txt | awk 'BEGIN {FS = "\t"; p = 0; n = 0} sqrt($2 ^ 2) > '$i' {if($2 * $3 > 0){p += 1} else if($2 * $3 < 0){n += 1}} END {print "'$i'\t" p "\t" n "\t" p / (p + n)}'; done > gene_reactome_scoretable.txt
for i in $(cat gene_reactome_scoretable.txt | cut -f1); do cat gene_reactome_scoretable.txt | awk '$1 <= '$i | cut -f4 | sort -gr | head -1 | awk '{print "'$i'\t" $0}'; done | sort -k1,1 | join -t$'\t' - <(cat gene_score_to_count.txt | sort -k1,1) | cut -f2- | sort -k2,2gr | sort -k1,1gr -u > gene_accuracy_distribution.txt



cat drug_consensus_directionality.txt | awk '{print $1 "_" $2 "\t" $3}' | sort -k1,1 | join -t$'\t' - <(cat ../../parmesan_import/mod_to_entrez.txt | awk '{print $1 "_" $2 "\t" $3}' | sort -k1,1) > drug_dgidb_comparison.txt
for i in $(seq 0 100); do cat drug_dgidb_comparison.txt | awk 'BEGIN {FS = "\t"; p = 0; n = 0} sqrt($2 ^ 2) > '$i' {if($2 * $3 > 0){p += 1} else if($2 * $3 < 0){n += 1}} END {print "'$i'\t" p "\t" n "\t" p / (p + n)}'; done > drug_dgidb_scoretable.txt
for i in $(cat drug_dgidb_scoretable.txt | cut -f1); do cat drug_dgidb_scoretable.txt | awk '$1 <= '$i | cut -f4 | sort -gr | head -1 | awk '{print "'$i'\t" $0}'; done | sort -k1,1 | join -t$'\t' - <(cat drug_score_to_count.txt | sort -k1,1) | cut -f2- | sort -k2,2gr | sort -k1,1gr -u > drug_accuracy_distribution.txt


cd no_dgidb
bash BUILD
cd ..

cd pre_2012
bash BUILD
cd ..

cd pre_2022
bash BUILD
cd ..


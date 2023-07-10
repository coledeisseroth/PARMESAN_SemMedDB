cp -r ../parmesan_import/raw_comparison/ .
cp -r ../parmesan_import/minscore_to_no_genes/ .
cp ../semmeddb/predictions/gene_minscore_to_no_genes.txt minscore_to_no_genes/smdb_gene.txt
cp ../semmeddb/predictions/drug_minscore_to_no_genes.txt minscore_to_no_genes/smdb_drug.txt
cp ../semmeddb/parmesan_combined_predictions/gene/minscore_to_no_genes.txt minscore_to_no_genes/parm_smdb_gene.txt
cp ../semmeddb/parmesan_combined_predictions/no_dgidb/minscore_to_no_genes.txt minscore_to_no_genes/parm_smdb_drug.txt

cp ../semmeddb/predictions/raw_reactome_comparison.txt raw_comparison/smdb_gene.txt
cp ../semmeddb/predictions/raw_dgidb_comparison.txt raw_comparison/smdb_drug.txt
cp ../semmeddb/parmesan_combined_predictions/gene/raw_reactome_comparison.txt raw_comparison/parm_smdb_gene.txt
cp ../semmeddb/parmesan_combined_predictions/no_dgidb/raw_dgidb_comparison.txt raw_comparison/parm_smdb_drug.txt

totalgenes=$(cat minscore_to_no_genes/* | cut -f2 | sort -gr | head -1)
mkdir raw_curves
mkdir curves
for file in $(ls raw_comparison); do
(for entry in $(cat minscore_to_no_genes/$file | sed 's/\t/,/g'); do minscore=$(echo $entry | cut -d, -f1); recall=$(echo $entry | cut -d, -f2 | awk '{print $1 / '$totalgenes'}'); precision=$(cat raw_comparison/$file | awk 'BEGIN {FS = "\t"; p = 0; n = 0} sqrt($2 ^ 2) >= '$minscore' {if($2 * $3 > 0){p += 1} else if($2 * $3 < 0){n += 1}} END {print p / (p + n)}'); echo $precision$'\t'$recall; done > raw_curves/$file
cat raw_curves/$file | sort -k2,2gr | awk 'BEGIN {FS = "\t"; pprev = ""; rprev = ""} pprev == "" || ($1 > pprev || $2 > rprev) {print; pprev = $1; rprev = $2}' > curves/$file) &
done
while [ $(jobs | grep Running | wc -l) -gt 0 ]; do jobs; sleep 1; done

for file in $(ls curves); do
echo $file
(cat curves/$file | sort -k1,1gr | head -1 | awk '{print $1 "\t" 0}'; cat curves/$file | sort -k2,2g; cat curves/$file | sort -k2,2gr | head -1 | awk '{print 0 "\t" $2}') | awk '{print $2 "\t" $1}' | sort -k1,1g -k2,2gr | awk 'BEGIN {FS = "\t"; rprev = ""; pprev = ""; auc = 0} {if(pprev != ""){rectangle = $2 * ($1 - rprev); triangle = 0.5 * ($1 - rprev) * ($2 - pprev); auc += rectangle + triangle} rprev = $1; pprev = $2} END {print auc}'
done


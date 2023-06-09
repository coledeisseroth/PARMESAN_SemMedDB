cat ../extractions/gene_gene_extractions.txt ../../parmesan_import/parmesan_gene_directionality.txt | awk 'BEGIN {FS = "\t"} {print sqrt($4 ^ 2) "\t" $4 / sqrt($4 ^ 2) "\t" $0}' | sort -k1,1gr | sort -k2,2 -k3,3 -k4,4 -k5,5 -u | cut -f3- > gene_directionality.txt

cat ../extractions/drug_gene_extractions.txt ../../parmesan_import/parmesan_drug_directionality.txt | awk 'BEGIN {FS = "\t"} {print sqrt($4 ^ 2) "\t" $4 / sqrt($4 ^ 2) "\t" $0}' | sort -k1,1gr | sort -k2,2 -k3,3 -k4,4 -k5,5 -u | cut -f3- > drug_directionality.txt

for prefix in gene drug; do
cat ${prefix}_directionality.txt | cut -f2- | awk 'BEGIN {FS = "\t"} {print $1 "_" $2 "\t" $3}' | sort -k1,1 | awk 'BEGIN {rel = ""; pos = 0; neg = 0} {if($1 != rel && rel != ""){print rel "\t" pos "\t" neg; pos = 0; neg = 0} rel = $1; if($2 > 0){pos += $2} if($2 < 0){neg -= $2}} END {print rel "\t" pos "\t" neg}' | sed 's/_/\t/g' > ${prefix}_consensus_sums.txt
cat ${prefix}_consensus_sums.txt | awk '{print $1 "\t" $2 "\t" ($3 - $4) * sqrt(($3 - $4) ^ 2) / ($3 + $4)}' | awk '$3 != 0' | awk '$1 != $2' > ${prefix}_consensus_directionality.txt
done

cd no_dgidb
bash BUILD
cd ..



cat ../drug_directionality.txt | cut -f1 | sort -u | comm -23 - <(cat ../../../parmesan_import/dgidb_pmids.txt | sort -u) | sort -u | join -t$'\t' - <(cat ../drug_directionality.txt | sort -t$'\t' -k1,1) | sort -u > drug_directionality.txt
cat drug_directionality.txt | cut -f2- | awk 'BEGIN {FS = "\t"} {print $1 "_" $2 "\t" $3}' | sort -k1,1 | awk 'BEGIN {rel = ""; pos = 0; neg = 0} {if($1 != rel && rel != ""){print rel "\t" pos "\t" neg; pos = 0; neg = 0} rel = $1; if($2 > 0){pos += $2} if($2 < 0){neg -= $2}} END {print rel "\t" pos "\t" neg}' | sed 's/_/\t/g' > drug_consensus_sums.txt
cat drug_consensus_sums.txt | awk '{print $1 "\t" $2 "\t" ($3 - $4) * sqrt(($3 - $4) ^ 2) / ($3 + $4)}' | awk '$3 != 0' | awk '$1 != $2' > drug_consensus_directionality.txt



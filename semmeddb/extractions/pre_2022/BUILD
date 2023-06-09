for prefix in gene drug; do
cat ../../../parmesan_import/pmid_to_date.txt | awk 'BEGIN {FS = "\t"} $2 < 2022' | cut -f1 | sort -u | join -t$'\t' - <(cat ../${prefix}_gene_extractions.txt | sort -t$'\t' -k1,1) | sort -u > ${prefix}_gene_extractions.txt
cat ${prefix}_gene_extractions.txt | cut -f2- | awk 'BEGIN {FS = "\t"} {print $1 "_" $2 "\t" $3}' | sort -k1,1 | awk 'BEGIN {rel = ""; pos = 0; neg = 0} {if($1 != rel && rel != ""){print rel "\t" pos "\t" neg; pos = 0; neg = 0} rel = $1; if($2 > 0){pos += $2} if($2 < 0){neg -= $2}} END {print rel "\t" pos "\t" neg}' | sed 's/_/\t/g' > ${prefix}_consensus_sums.txt
cat ${prefix}_consensus_sums.txt | awk '{print $1 "\t" $2 "\t" ($3 - $4) * sqrt(($3 - $4) ^ 2) / ($3 + $4)}' | awk '$3 != 0' | awk '$1 != $2' > ${prefix}_consensus_directionality.txt
done

for prefix in gene drug; do
cat ../../../parmesan_import/${prefix}_timecapsule_hypotheses/* | awk 'BEGIN {FS = "\t"} {print $1 "_" $2 "\t" $3}' | sort -k1,1 | join -t$'\t' - <(cat ${prefix}_consensus_directionality.txt | awk 'BEGIN {FS = "\t"} {print $1 "_" $2 "\t" $3}' | sort -k1,1) > ${prefix}_parmesan_comparison.txt
for i in 0 $(seq 100); do cat ${prefix}_parmesan_comparison.txt | awk 'sqrt($2 ** 2) > '$i | awk '{print $2 * $3}' | awk 'BEGIN {p = 0; n = 0} {if($1 > 0){p += 1} else{n += 1}} END {print "'$i'\t" p "\t" n "\t" p / (p + n)}'; done > ${prefix}_parmesan_scoretable.txt
done



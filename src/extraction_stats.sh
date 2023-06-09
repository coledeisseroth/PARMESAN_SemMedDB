consensusfile=$1
directionalityfile=$2

echo -n 'Positive modifiers: '; cat $consensusfile | awk 'BEGIN {FS = "\t"} $3 > 0' | cut -f1 | sort -u | wc -l
echo -n 'Positive targets: '; cat $consensusfile | awk 'BEGIN {FS = "\t"} $3 > 0' | cut -f2 | sort -u | wc -l
echo -n 'Positive relationships: '; cat $consensusfile | awk 'BEGIN {FS = "\t"} $3 > 0' | cut -f1,2 | sort -u | wc -l
echo -n 'Positive articles: '; cat $consensusfile | awk 'BEGIN {FS = "\t"} $3 > 0' | cut -f1,2 | sed 's/\t/_/g' | sort -u | join -t$'\t' - <(cat $directionalityfile | awk 'BEGIN {FS = "\t"} {print $2 "_" $3 "\t" $1}' | sort -k1,1) | cut -f2 | sort -u | wc -l
echo -n 'Negative modifiers: '; cat $consensusfile | awk 'BEGIN {FS = "\t"} $3 < 0' | cut -f1 | sort -u | wc -l
echo -n 'Negative targets: '; cat $consensusfile | awk 'BEGIN {FS = "\t"} $3 < 0' | cut -f2 | sort -u | wc -l
echo -n 'Negative relationships: '; cat $consensusfile | awk 'BEGIN {FS = "\t"} $3 < 0' | cut -f1,2 | sort -u | wc -l
echo -n 'Negative articles: '; cat $consensusfile | awk 'BEGIN {FS = "\t"} $3 < 0' | cut -f1,2 | sed 's/\t/_/g' | sort -u | join -t$'\t' - <(cat $directionalityfile | awk 'BEGIN {FS = "\t"} {print $2 "_" $3 "\t" $1}' | sort -k1,1) | cut -f2 | sort -u | wc -l


import sys
import os
from collections import defaultdict

for line in open(sys.argv[1]):
    line = line.strip().split("\t")
    subjectIds = line[2].split("|")
    subjectNames = line[3].split("|")
    objectIds = line[5].split("|")
    objectNames = line[6].split("|")
    for s in range(len(subjectIds)):
        for o in range(len(objectIds)):
            line[2] = subjectIds[s]
            line[3] = subjectNames[s]
            line[5] = objectIds[o]
            line[6] = objectNames[o]
            print("\t".join(line))


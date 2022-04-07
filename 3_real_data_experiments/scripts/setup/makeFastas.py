#!/usr/bin/env python3
# Name: Bryan Thornlow

import sys
import os
import datetime
import numpy
from numpy import random
import gzip
import math
import re

##########################
##### MAIN FUNCTIONS #####
##########################

def makeFastas():
	sampleToBatch = {}
	batchToOutString = {}
	for i in range(1,5):
		batchToOutString[i] = ''
		with open('BATCH_SAMPLES/'+str(i)+'_samples.txt') as f:
			for line in f:
				sampleToBatch[line.strip()] = i

	myBatch = ''
	with open('publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.samples.fasta') as f:
		for line in f:
			l = line.strip()
			if l.startswith('>'):
				if l[1:] in sampleToBatch:
					myBatch = sampleToBatch[l[1:]]
					batchToOutString[myBatch] += l+'\n'
				else:
					myBatch = ''
			else:
				if myBatch != '':
				    batchToOutString[myBatch] += l+'\n'

	for i in range(1,5):
		open('BATCH_FASTAS/'+str(i)+'_samples.fasta','w').write(batchToOutString[i])


##########################
#### HELPER FUNCTIONS ####
##########################

def joiner(entry):
    newList = []
    for k in entry:
        newList.append(str(k))
    return('\t'.join(newList))

def main():
	makeFastas()

if __name__ == "__main__":
    """
    Calls main when program is run by user.
    """
    main();
    raise SystemExit




                






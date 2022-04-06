#!/usr/bin/env python3
# Name: Bryan Thornlow
# Date: 2/1/2018
# compareDatabases.py

import sys
import os
import datetime
import numpy
from numpy import random
import gzip
import math

##########################
##### MAIN FUNCTIONS #####
##########################

def getTable():
	myOutString = 'sample\tACGT\tN\tother\n'
	myOutFa = ''
	toPrune = ''
	with gzip.open('tmp/28000_samples.fa.gz') as f:
		for line in f:
			l = (line.decode('utf8').strip())
			if l.startswith('>'):
				mySampleName = l[1:]
			else:
				l = l.upper()
				ACGT = l.count('A')+l.count('C')+l.count('G')+l.count('T')
				N = l.count('N')
				myOutString += mySampleName+'\t'+str(ACGT)+'\t'+str(N)+'\t'+str(len(l)-(ACGT+N+l.count('-')))+'\n'
				if len(l)-(ACGT+N+l.count('-')) < 2:
					myOutFa += '>'+mySampleName+'\n'+l+'\n'
				else:
					toPrune += mySampleName+'\n'

	open('tmp/28000_samples.tsv','w').write(myOutString)
	open('tmp/28000_samples_less_than_2_ambiguities.fa','w').write(myOutFa)
	open('tmp/prune_ambiguities.txt','w').write(toPrune)

##########################
#### HELPER FUNCTIONS ####
##########################

def replaceSymbols(myEntry):
    myEntry = myEntry.replace('|', '_')
    myEntry = myEntry.replace('/', '_')
    return(myEntry)

def joiner(entry):
    newList = []
    for k in entry:
        newList.append(str(k))
    return '\t'.join(newList)

def main():
   getTable()

if __name__ == "__main__":
    """
    Calls main when program is run by user.
    """
    main();
    raise SystemExit




                



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

def makeFa():
	mySamples = {'NC_045512v2':True}
	with open('publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.samples.tsv') as f:
		for line in f:
			splitLine = (line.strip()).split('\t')
			mySamples[splitLine[0]] = True

	keep = False
	myOutString = ''
	with open('28000_samples_less_than_2_ambiguities_with_ref.fa') as f:
		for line in f:
			l = line.strip()
			if l.startswith('>'):
				if l[1:] in mySamples:
					keep = True
					myOutString += l+'\n'
				else:
					keep = False
			else:
				if keep == True:
					myOutString += l+'\n'
	open('publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.samples.fasta','w').write(myOutString)


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
   makeFa()

if __name__ == "__main__":
    """
    Calls main when program is run by user.
    """
    main();
    raise SystemExit




                



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
import re

##########################
##### MAIN FUNCTIONS #####
##########################

def breakDownFasta():
    batchToSamples = {}
    batchToOutString = {}
    for i in range(1,7):
        batchToSamples[i] = {}
        batchToOutString[i] = ''
        with open('tmp/SAMPLES_LISTS/'+str(i)+'_samples.samples_list.txt') as f:
            for line in f:
                splitLine = (line.strip()).split('\t')
                if not splitLine[0] == 'sample':
                    (batchToSamples[i])[splitLine[0]] = True

    mySample = ''
    with open('tmp/cut'+str(sys.argv[1])+'.fasta') as f:
        for line in f:
            l = line.strip()
            if l.startswith('>'):
                mySample = l[1:]
            elif mySample != '':
                for i in range(1,7):
                    if mySample in batchToSamples[i]:
                        batchToOutString[i] += '>'+mySample+'\n'+l+'\n'

    for i in range(1,7):
        open('tmp/CUMULATIVE_FASTAS/'+str(i)+'_cut'+str(sys.argv[1])+'.fasta','w').write(batchToOutString[i])

##########################
#### HELPER FUNCTIONS ####
##########################

def toTwo(entry):
    if len(str(entry)) == 1:
        return('0'+str(entry))
    else:
        return(str(entry))

def replaceSymbols(myEntry):
    myEntry = myEntry.replace('|', '_')
    myEntry = myEntry.replace('/', '_')
    return(myEntry)

def joinerN(entry):
    newList = []
    for k in entry:
        newList.append(str(k))
    return('\n'.join(newList))

def joiner(entry):
    newList = []
    for k in entry:
        newList.append(str(k))
    return '\t'.join(newList)


#########################
##### FUNCTION CALL #####
#########################

def main():
    breakDownFasta()

if __name__ == "__main__":
    """
    Calls main when program is run by user.
    """
    main();
    raise SystemExit

    

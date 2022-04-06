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

def getFaCount():
    problematicSites = {}
    with open('input/problematic_sites_sarsCov2.v4.vcf') as f:
        for line in f:
            splitLine = (line.strip()).split('\t')
            if not splitLine[0].startswith('#'):
                problematicSites[int(splitLine[1])] = True

    with open('input/wuhan.ref.fa') as f:
        for line in f:
            l = line.strip()
            if not l.startswith('>'):
                myIgnores = [k.start() for k in re.finditer('N', l.upper())]

    keepSamples = {}
    with open('tmp/samples.tsv') as f:
        for line in f:
            splitLine = (line.strip()).split('\t')
            if splitLine[0] != 'sample':
                keepSamples[splitLine[0]] = True

    mySample = ''
    myString = ''
    sampleToString = {}
    sampleToCount = {}
    with gzip.open('input/publicMsa.2021-03-18.masked.fa.gz') as f:
        for line in f:
            l = (line.decode('utf8').strip())
            if l.startswith('>'):
                if mySample in keepSamples:
                    myList = list(myString.upper())
                    for k in problematicSites:
                        myList[k-1] = 'N'
                    newString = ''.join(myList)
                    for k in myIgnores[::-1]:
                        myList.pop(k)
                    if len(myList)-myList.count('N') >= 28000:
                        sampleToString[mySample] = newString
                    sampleToCount[mySample] = len(myList)-myList.count('N') 
                mySample = l[1:]
                myString = ''
            else:
                myString += l.upper()

    myOutString = ''
    myOutCount = ''
    for s in sampleToCount:
        myOutCount += s+'\t'+str(sampleToCount[s])+'\n'
        if s in sampleToString:
            myOutString += '>'+s+'\n'+sampleToString[s]+'\n'
    open('tmp/28000_samples.fa','w').write(myOutString)
    open('tmp/sample_to_count.txt','w').write(myOutCount)




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
   getFaCount()

if __name__ == "__main__":
    """
    Calls main when program is run by user.
    """
    main();
    raise SystemExit




                


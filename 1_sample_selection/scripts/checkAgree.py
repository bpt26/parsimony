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

def checkAgreement():
    mutPaths = {}
    with open('mutation_paths.txt') as f:
        for line in f:
            splitLine = (line.strip()).split('\t')
            if len(splitLine) > 1:# and ',' in splitLine[1]:
                myMuts = (splitLine[1]).count(',')+1
                #if (splitLine[0].isdigit() and myMuts > 29) or (not splitLine[0].isdigit() and myMuts > 5):
                mutPaths[splitLine[0]] = myMuts

    matSum = {}
    with open('high_pars_samples.txt') as f:
        for line in f:
            splitLine = (line.strip()).split('\t')
            if not splitLine[0] == 'sample':
                if (splitLine[0].isdigit() and int(splitLine[1]) > 29) or (not splitLine[0].isdigit() and int(splitLine[1]) > 5):
                    if int(splitLine[1]) != mutPaths[splitLine[0]]:
                        print(splitLine[0], splitLine[1], mutPaths[splitLine[0]])


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
   checkAgreement()

if __name__ == "__main__":
    """
    Calls main when program is run by user.
    """
    main();
    raise SystemExit




                

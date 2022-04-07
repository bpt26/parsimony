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

def getMetadata():
    mySamples = {}
    with open('input/publicMsa.2021-03-18.masked.retain_samples.save.minus_parsimony.samples.tsv') as f:
        for line in f:
            splitLine = (line.strip()).split('\t')
            if splitLine[0] != 'sample':
                mySamples[splitLine[0]] = True

    doubleCheck = {}
    sampleToDate = {}
    sampleToLocation = {}
    with gzip.open('input/public-2021-03-18.metadata.tsv.gz') as f:
        for line in f:
            splitLine = (line.strip()).split('\t')
            if splitLine[0] in mySamples:
                sampleToDate[splitLine[0]] = splitLine[2]
                sampleToLocation[splitLine[0]] = splitLine[3]
            elif splitLine[1] in mySamples:
                sampleToDate[splitLine[1]] = splitLine[2]
                sampleToLocation[splitLine[1]] = splitLine[3]
            elif splitLine[0].split('|')[0] in mySamples:
                sampleToDate[splitLine[0].split('|')[0]] = splitLine[2]
                sampleToLocation[splitLine[0].split('|')[0]] = splitLine[3]
            #else:
                #print(splitLine)

    samples2019 = 0
    samples2020 = 0
    samples2021 = 0
    myMonthYears = ['12-2019','01-2020','02-2020','03-2020','04-2020','05-2020','06-2020','07-2020','08-2020','09-2020','10-2020','11-2020','12-2020']
    myMonthYears += ['01-2021','02-2021','03-2021','04-2021','05-2021']
    monthYearToSamples = {}
    ymdToSamples = {}
    sampleToYMD = {}
    for m in myMonthYears:
        monthYearToSamples[m] = {}
        myMonth = m.split('-')[0]
        myYear = m.split('-')[1]
        for i in range(1,32):
            myYMD = str(myYear)+'-'+str(myMonth)+'-'+toTwo(i)
            ymdToSamples[myYMD] = {}
    for k in sampleToDate:
        if '-' in sampleToDate[k]:
            myDate = sampleToDate[k].split('-')
            if len(myDate) >= 1:
                myYear = int(myDate[0])
                if len(myDate) >= 2:
                    myMonth = int(myDate[1])
                    if len(myDate) == 3:
                        myDay = int(myDate[2])
                        (ymdToSamples[sampleToDate[k]])[k] = True
                        sampleToYMD[k] = sampleToDate[k]
                    myMonthYear = str(myDate[1])+'-'+str(myDate[0])
                    print(myDate)
                    (monthYearToSamples[myMonthYear])[k] = True
    print(samples2019, samples2020, samples2021, samples2019+samples2020+samples2021)

    # for i in range(0,len(myMonthYears)):
    #     print(myMonthYears[i], len(monthYearToSamples[myMonthYears[i]]))

    myOutString = ''
    myOutSample = ''
    for k in sorted(ymdToSamples.keys()):
        myOutString += k+'\t'+str(len(ymdToSamples[k]))+'\n'
        for s in sorted(ymdToSamples[k].keys()):
            myOutSample += s+'\t'+k+'\n'
    open('ymd.tsv','w').write(myOutString)
    open('sampleToYMD.tsv','w').write(myOutSample)

    # for k in mySamples:
    #     if not k in sampleToDate:
    #         print(k)


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

def joiner(entry):
    newList = []
    for k in entry:
        newList.append(str(k))
    return '\t'.join(newList)

def main():
   getMetadata()

if __name__ == "__main__":
    """
    Calls main when program is run by user.
    """
    main();
    raise SystemExit




                




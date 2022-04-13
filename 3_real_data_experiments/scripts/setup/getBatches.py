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

def getBatches():
    with open('sampleToYMD.tsv') as f:
        ymdToSamples = {}
        sampleToYMD = {}
        for line in f:
            splitLine = (line.strip()).split('\t')
            sampleToYMD[splitLine[0]] = splitLine[1]
            if not splitLine[1] in ymdToSamples:
                ymdToSamples[splitLine[1]] = []
            ymdToSamples[splitLine[1]].append(splitLine[0])

    with open('ymd.tsv') as f:
        myStart = '2019-12-23'
        startToCount = {'2019-12-23':0}
        startToEnd = {}
        for line in f:
            splitLine = (line.strip()).split('\t')
            if startToCount[myStart] > 4000:
                startToEnd[myStart] = myDate
                myStart = splitLine[0]
                startToCount[myStart] = 0
            myDate = splitLine[0]
            startToCount[myStart] += int(splitLine[1])
        startToEnd[myStart] = myDate

    myBatches = ''
    for k in sorted(startToCount.keys()):
        myBatches += str(k)+'\t'+str(startToCount[k])+'\t'+str(startToEnd[k])+'\n'
    open('sampleBatches.txt','w').write(myBatches)



def getSampleFiles():
    myStartDates = {}
    with open('sampleBatches.txt') as f:
        for line in f:
            splitLine = (line.strip()).split('\t')
            myStartDates[splitLine[0]] = True

    dateToBatch = {}
    batchNum = 0
    myBatchDate = '2019-12-23'
    for year in ['2019','2020','2021']:
        for month in ['01','02','03','04','05','06','07','08','09','10','11','12']:
            for day in ['01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31']:
                myDate = year+'-'+month+'-'+day
                if myDate in myStartDates:
                    myBatchDate = myDate
                    batchNum += 1
                dateToBatch[myDate] = batchNum
                    

    batchToSamples = {}
    with open('sampleToYMD.tsv') as f:
        for line in f:
            splitLine = (line.strip()).split('\t')
            myBatch = dateToBatch[splitLine[1]]
            if not myBatch in batchToSamples:
                batchToSamples[myBatch] = []
            batchToSamples[myBatch].append(splitLine[0])


    for k in batchToSamples.keys():
        open('BATCH_SAMPLES/'+str(k)+'_samples.txt','w').write('\n'.join(batchToSamples[k])+'\n')

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

def main():
   getBatches()
   getSampleFiles()

if __name__ == "__main__":
    """
    Calls main when program is run by user.
    """
    main();
    raise SystemExit




                




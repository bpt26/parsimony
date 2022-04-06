#!/usr/bin/env python3
# Name: Bryan Thornlow
# Date: 2/16/2018
# extendBed.py

import sys
import os
import time
import random
import numpy
import gzip
import math

"""
For each species:
-- columns going across for how many genes per anticodon type, and unique genes per anticodon
-- end with average genes per anticodon and average unique genes per anticodon
"""


##########################
##### MAIN FUNCTIONS #####
##########################

def checkSites():
    mySites = {}
    with open('input/problematic_sites_sarsCov2.v4.vcf') as f:
        for line in f:
            splitLine = (line.strip()).split('\t')
            if not splitLine[0].startswith('#'):
                mySites[int(splitLine[1])] = True

    myOutVcf = ''
    with open('tmp/28000_samples_less_than_2_ambiguities.vcf') as f:
        for line in f:
            splitLine = (line.strip()).split('\t')
            if not splitLine[0].startswith('#'):
                if len(splitLine) > 10:
                    if int(splitLine[1]) not in mySites:
                        myOutVcf += line.strip()+'\n'
                    else:
                        print(splitLine[:10])
                else:
                    myOutVcf += line.strip()+'\n'
            else:
                myOutVcf += line.strip()+'\n'
    open('tmp/fixedVCF.vcf','w').write(myOutVcf)
                    





########################
### HELPER FUNCTIONS ###
########################

def joiner(entry):
    newList = []
    for k in entry:
        newList.append(str(k))
    return('\t'.join(newList))

def toInt(myList):
    myReturn = []
    for k in myList:
        myReturn.append(int(k))
    return(myReturn)


#######################
#### FUNCTION CALL ####
#######################

def main():
   checkSites()

if __name__ == "__main__":
    """
    Calls main when program is run by user.
    """
    main();
    raise SystemExit





            







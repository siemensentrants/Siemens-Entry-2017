#We enter the "midpoint" levels of each metabolite for the training set as described in our methods
meanHarmalol =
meanGM2 =
meanDOPAL =

#We enter the metabolite levels for the testing set alternating between harmalol and GM2 for each of the 17 samples
metabolites = [
]

#We calculate the final diagnostic algorithm value for all 17 samples in the testing set as described in our methods
def diagnose(metabolites):
    counter1 = 0
    counter1 = counter1 - ((metabolites[0] - meanHarmalol)/meanHarmalol)
    counter1 = counter1 - ((metabolites[1] - meanGM2)/meanGM2)
    counter1 = counter1 + ((metabolites[2] - meanDOPAL)/meanDOPAL)
    print (counter1)
    counter2 = 0
    counter2 = counter2 - ((metabolites[3] - meanHarmalol) / meanHarmalol)
    counter2 = counter2 - ((metabolites[4] - meanGM2) / meanGM2)
    counter2 = counter2 + ((metabolites[5] - meanDOPAL) / meanDOPAL)
    print (counter2)
    counter3 = 0
    counter3 = counter3 - ((metabolites[6] - meanHarmalol) / meanHarmalol)
    counter3 = counter3 - ((metabolites[7] - meanGM2) / meanGM2)
    counter3 = counter3 + ((metabolites[8] - meanDOPAL) / meanDOPAL)
    print(counter3)
    counter4 = 0
    counter4 = counter4 - ((metabolites[9] - meanHarmalol) / meanHarmalol)
    counter4 = counter4 - ((metabolites[10] - meanGM2) / meanGM2)
    counter4 = counter4 + ((metabolites[11] - meanDOPAL) / meanDOPAL)
    print(counter4)
    counter5 = 0
    counter5 = counter5 - ((metabolites[12] - meanHarmalol) / meanHarmalol)
    counter5 = counter5 - ((metabolites[13] - meanGM2) / meanGM2)
    counter5 = counter5 + ((metabolites[14] - meanDOPAL) / meanDOPAL)
    print(counter5)
    counter6 = 0
    counter6 = counter6 - ((metabolites[15] - meanHarmalol) / meanHarmalol)
    counter6 = counter6 - ((metabolites[16] - meanGM2) / meanGM2)
    counter6 = counter6 + ((metabolites[17] - meanDOPAL) / meanDOPAL)
    print(counter6)
    counter7 = 0
    counter7 = counter7 - ((metabolites[18] - meanHarmalol) / meanHarmalol)
    counter7 = counter7 - ((metabolites[19] - meanGM2) / meanGM2)
    counter7 = counter7 + ((metabolites[20] - meanDOPAL) / meanDOPAL)
    print(counter7)
    counter8 = 0
    counter8 = counter8 - ((metabolites[21] - meanHarmalol) / meanHarmalol)
    counter8 = counter8 - ((metabolites[22] - meanGM2) / meanGM2)
    counter8 = counter8 + ((metabolites[23] - meanDOPAL) / meanDOPAL)
    print(counter8)
    counter9 = 0
    counter9 = counter9 - ((metabolites[24] - meanHarmalol) / meanHarmalol)
    counter9 = counter9 - ((metabolites[25] - meanGM2) / meanGM2)
    counter9 = counter9 + ((metabolites[26] - meanDOPAL) / meanDOPAL)
    print(counter9)
    counter10 = 0
    counter10 = counter10 - ((metabolites[27] - meanHarmalol) / meanHarmalol)
    counter10 = counter10 - ((metabolites[28] - meanGM2) / meanGM2)
    counter10 = counter10 + ((metabolites[29] - meanDOPAL) / meanDOPAL)
    print(counter10)
    counter11 = 0
    counter11 = counter11 - ((metabolites[30] - meanHarmalol) / meanHarmalol)
    counter11 = counter11 - ((metabolites[31] - meanGM2) / meanGM2)
    counter11 = counter11 + ((metabolites[32] - meanDOPAL) / meanDOPAL)
    print(counter11)
    counter12 = 0
    counter12 = counter12 - ((metabolites[33] - meanHarmalol) / meanHarmalol)
    counter12 = counter12 - ((metabolites[34] - meanGM2) / meanGM2)
    counter12 = counter12 + ((metabolites[35] - meanDOPAL) / meanDOPAL)
    print(counter12)
    counter13 = 0
    counter13 = counter13 - ((metabolites[36] - meanHarmalol) / meanHarmalol)
    counter13 = counter13 - ((metabolites[37] - meanGM2) / meanGM2)
    counter13 = counter13 + ((metabolites[38] - meanDOPAL) / meanDOPAL)
    print(counter13)
    counter14 = 0
    counter14 = counter14 - ((metabolites[39] - meanHarmalol) / meanHarmalol)
    counter14 = counter14 - ((metabolites[40] - meanGM2) / meanGM2)
    counter14 = counter14 + ((metabolites[41] - meanDOPAL) / meanDOPAL)
    print(counter14)
    counter15 = 0
    counter15 = counter15 - ((metabolites[42] - meanHarmalol) / meanHarmalol)
    counter15 = counter15 - ((metabolites[43] - meanGM2) / meanGM2)
    counter15 = counter15 + ((metabolites[44] - meanDOPAL) / meanDOPAL)
    print(counter15)
    counter16 = 0
    counter16 = counter16 - ((metabolites[45] - meanHarmalol) / meanHarmalol)
    counter16 = counter16 - ((metabolites[46] - meanGM2) / meanGM2)
    counter16 = counter16 + ((metabolites[47] - meanDOPAL) / meanDOPAL)
    print(counter16)
    counter17 = 0
    counter17 = counter17 - ((metabolites[48] - meanHarmalol) / meanHarmalol)
    counter17 = counter17 - ((metabolites[49] - meanGM2) / meanGM2)
    counter17 = counter17 - ((metabolites[50] - meanDOPAL) / meanDOPAL)
    print(counter17)
diagnose(metabolites)
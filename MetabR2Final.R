# Set the working directory to import the mapping file
setwd("/Users/Farmer/Desktop")
#We import the mapping file, which contains file name (e.g. "DW_140904_013"	), sample ID (e.g. "CR0059_01"	),
#and batch (e.g. "1") 
PDmapping <- read.table("sampleID_mapping_pos.txt", sep="\t", header=T)
#We convert the file name to a character so it's in the same class as it is in other locations
PDmapping$FileName <- as.character(PDmapping$FileName)
#We convert the sample ID to a character so it's in the same class as it is in other locations 
PDmapping$SampleID <- as.character(PDmapping$SampleID)
####
#Make sampleIDs identical in format as in PDdata, rename so the variable names are consistent
#First, we split the sample ID column into two columns, one containing the part of the ID before the underscore
#(e.g. CR0059) and the other containing the part of the ID after the underscore (e.g. 01) 
PDmapping$SampleID <- unlist(lapply(strsplit(PDmapping$SampleID, "_"), function(i) i[1]))
#We rename the sample ID column to CR00 so it's consistent with the demographic table
names(PDmapping)[2] <- "CR00"
##

########
#Now we import the data we're actually using for t tests, which already has been filtered by CV, has zeroes
#imputed with half minimum value for each row, and has clinical status 
MetabDataCV <- read.csv("Feature table with mins replaced with half value per row.csv")
#We merge the mz and time columns
MetabDataCV[,1] <- paste0(MetabDataCV$mz, "/", MetabDataCV$time)
#We remove the time only column
MetabDataCV <- MetabDataCV[,-2]
#We add label to the top, so that this formatted nicely
MetabDataCV[1,1] <- "Label"
#We name the column "Sample"
names(MetabDataCV)[1] <- "Sample"
#Here's the part where we do the glog transformation.  We first create a separate data frame to be transformed.
#Since we want everything to be numeric, we remove the character info 
Metab2 <- as.data.frame(MetabDataCV[2:9072, 2:35])
#We make sure that the data is all numeric
Metab2[] <- lapply(Metab2, function(x) {
  if(is.factor(x)) as.numeric(as.character(x)) else x
})
Metab2[] <- lapply(Metab2, as.numeric)

#Here we define the generalized log function 
glog <- function (i) {
  log2((i+sqrt((i^2)+1))/2)
}

#We apply the generalized log function to the data
Metab2[,1:34] <- lapply (Metab2[,1:34], glog)
#We re-bind the character data 
Metab2 <- cbind (MetabDataCV[-1,1], Metab2)
names(Metab2)[1] <- "Sample"
#We convert the data into character form
MetabDataCV[] <- lapply(MetabDataCV, function(x) {
  if(is.factor(x)) (as.character(x)) else x
})
MetabDataCV[1,] <- lapply(MetabDataCV[1,], as.character)
class(MetabDataCV[1,7])
Metab2 <- rbind(MetabDataCV[1,], Metab2)

#Now, we make our data the log transformed data
MetabDataCV <- Metab2

#We transpose the data, which makes t tests easier
tdata <- t(MetabDataCV)
#We delete the sample names so they don't interfere with the t tests    
tdata <- tdata[-1,]
#We make sure the tdata is expressed as a data frame
tdata <- as.data.frame(tdata)

#We give the column names the sample names so they are excluded from the t tests 
names(tdata) <- MetabDataCV$Sample

#We name the tdata column with Diagnosis "Diagnosis"
names(tdata)[1] <- "Diagnosis"

#We ensure tdata is numeric 
tdata[,-1] <- lapply(tdata[,-1], function(x) {
  if(is.factor(x)) as.numeric((as.character(x))) else x
})
tdata[,-1] <- lapply(tdata[,-1], as.numeric)

#We create a data frame with results
Ttestresult <- data.frame(MetabDataCV$Sample)
#We add a column for the p value
Ttestresult$pval <- NA
#We run the t-test loop!
for (i in 1:ncol(tdata)){if (i == 1){next}
  if (i > 1){
    ttest <- t.test(tdata[[i]]~tdata$Diagnosis,var.equal=T)
    Ttestresult$pval[[i]] <- ttest$p.value
  }
}

#We rename the data frame with results 
MetabResults <- Ttestresult


#We add a column with adjusted p value (with FDR correction) 
MetabResults$padj <- p.adjust(MetabResults$pval, method = c("fdr"))

#Here we are using the full demographic data to create linear models for different metabolites against some data
#First, we import the full demographic table

#Set working directory
setwd("/Users/Farmer/Downloads")

#Import
FullPDData <- read.csv("Master PD Control Dataset.csv")

#We create a subset that excludes Alzheimer's patients
Fulldata_subset <- subset (FullPDData, caco == "PD"| caco=="control")
#We make sure it is all in the right form (as character, etc)
Fulldata_subset$CR00 <- as.character(Fulldata_subset$CR00)
Fulldata_subset$CR00 <- gsub(" ", "", Fulldata_subset$CR00)


#We merge the demographic table with the mapping as we saw earlier

#We use this merge for the L-DOPA correlations
PDmappingdopa <- merge(PDmapping, Fulldata_subset[,c(3, 5, 19)], by="CR00")

#We use this merge for the updrs correlation
PDmappingupdrs <- merge(PDmapping, Fulldata_subset[,c(3, 5, 20)], by="CR00")

#Subset of IDs in the metabolomics dataset
#We make sure that we're only looking at patients with metabolomics data 
names(MetabDataCV) <- unlist(lapply(strsplit(names(MetabDataCV), ".cdf"), function(i) i[1]))
PDmappingdopa<- PDmappingdopa[(PDmappingdopa$FileName %in% names(MetabDataCV)),]
PDmappingupdrs <- PDmappingupdrs[(PDmappingupdrs$FileName %in% names(MetabDataCV)),]
#We make sure the data is in the right form (as.character, remove .cdf)
PDmappingdopa$caco <- as.character(PDmappingdopa$caco)
PDmappingupdrs$caco <- as.character(PDmappingupdrs$caco)
gsubcdf <- function (i ) {gsub(".cdf","",i)} 
rownames(tdata) <- lapply(rownames(tdata),gsubcdf)

##Here we are running the UPDRS correlation
#Add all the tdata to the clinical stuff
PDmappingupdrs <- merge(PDmappingupdrs, tdata, by.x = "FileName", by.y = "row.names")
#Create a data frame that contains the metabolites
UPDRSresult <- data.frame(MetabDataCV$Sample)
#Create a a column in the data frame that will contain the UPDRS correlation value
UPDRSresult$UPDRS <- NA
#Remove the row with "label"
UPDRSresult <- UPDRSresult[-1,]
#Run the correlation!
for (i in 7:ncol(PDmappingupdrs)) {
  UPDRSresult$UPDRS[[i-6]] <- cor(PDmappingupdrs[,i], PDmappingupdrs[,5], use = "complete.obs")
 
}

#Here we are running the L-DOPA correlations

#We add a column with the metabolic data for DOPAL
PDmappingdopa <- merge(PDmappingdopa, tdata[1170], by.x="FileName", by.y = "row.names")
#We name the column "DOPAL"
names(PDmappingdopa)[6] <- "DOPAL"
#We create a linear model (which contains the R2 value) and examine the results
lmdopal <- lm(PDmappingdopa$levodopa_eq ~ PDmappingdopa$DOPAL)
summary(lmdopal)

#We add a column with the metabolic data for Harmalol
PDmappingdopa <- merge(PDmappingdopa, tdata[2865], by.x="FileName", by.y ="row.names" )
#We name the column "Harmalol"
names(PDmappingdopa)[7] <- "Harmalol" 
#We create a linear model and examine the results
lmharmalol <- lm(PDmappingdopa$levodopa_eq ~ PDmappingdopa$Harmalol)
summary(lmharmalol)

#We add a column with the metabolic data for GM2 
PDmappingdopa <- merge(PDmappingdopa, tdata[8828], by.x = "FileName", by.y = "row.names")
#We name the column "GM2"
names(PDmappingdopa)[8] <- "GM2"
#We create a linear model and examine the results
lmGM2 <- lm(PDmappingdopa$levodopa_eq ~ PDmappingdopa$GM2)
summary(lmGM2)

#We add a column with the metabolic data for the glycerophospholipids at m/z of 294.846
PDmappingdopa <- merge (PDmappingdopa, tdata[3961], by.x = "FileName", by.y = "row.names")
#We name the column "Glycerophospholipid"
names(PDmappingdopa)[9] <- "Glycerophospholipid"
#We create a linear model and examine the results
lmglyc <- lm(PDmappingdopa$levodopa_eq ~ PDmappingdopa$Glycerophospholipid)
summary(lmglyc)

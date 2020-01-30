hd <- read.csv("Hunter Douglas Quality Data.csv", na.strings = c("NULL",""))
df <- as.data.frame(hd)
sil <- df[df$PRODUCT_CATEGORY == '02 Silhouette/Nantucket' & df$ORIGINAL_PLANT == 'G',]
sil <- sil[sil$ORDER_REASON_ID!='PAR',] #get rid of PAR
sil <- sil[!is.na(sil$ORIGINAL_ORDER),] #get rid of NULL original orders
sil <- sil[!is.na(sil$FABRIC_ID),] #get rid of NULL fabric IDs
sil <- sil[(sil$ORIGINAL_ORDER %in% sil$SALES_ORDER),] # drop rep/rem/crr orders with no og order
sil <- sil[sil$ORDER_REASON_ID=="STD" | sil$ORDER_REASON_ID=="REM" | sil$ORDER_REASON_ID=="REP" |sil$ORDER_REASON_ID=="CON" ,]
sil <- sil[!is.na(sil$OPERATING_SYSTEM_ID),]
sil <- sil[!is.na(sil$SOLD_TO_ID),]
sil$ORDER_REASON_ID <- factor(sil$ORDER_REASON_ID)
sil$RESPONSIBILITY_CODE_ID <- as.character(sil$RESPONSIBILITY_CODE_ID)
sil$RESPONSIBILITY_CODE_ID[is.na(sil$RESPONSIBILITY_CODE_ID)] <- "NULL"
sil$REASON_CODE_ID <- as.character(sil$REASON_CODE_ID)
sil$REASON_CODE_ID[is.na(sil$REASON_CODE_ID)] <- "NULL"
sil$REASON_CODE <- as.character(sil$REASON_CODE)
sil$REASON_CODE[is.na(sil$REASON_CODE)] <- "NULL"
sil$ALLIANCE_LEVEL_ID <- NULL
sil$SLAT_SIZE <- NULL

colSums(is.na(sil)) # returns all NA values in each column

# NOTE: There are still 25 NULL values in REGION_STATE_ID that may or may not be relevant to your model

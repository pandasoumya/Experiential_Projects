hd <- read.csv("Hunter Douglas Quality Data.csv", na.strings = c("NULL",""))
df <- as.data.frame(hd)
sil <- df[df$PRODUCT_CATEGORY == '02 Silhouette/Nantucket' & df$ORIGINAL_PLANT == 'G',]
colSums(is.na(sil)) # returns all NA values in each column
sil <- sil[sil$ORDER_REASON_ID!='PAR',] #get rid of PAR
sil <- sil[!is.na(sil$ORIGINAL_ORDER),] #get rid of NULL original orders
sil <- sil[!is.na(sil$FABRIC_ID),] #get rid of NULL fabric IDs
sil <- sil[(sil$ORIGINAL_ORDER %in% sil$SALES_ORDER),] # drop rep/rem/crr orders with no og order
#boulder <- subset(boulder, select = -c(SALE.TYPE, CITY, STATE, STATUS,FAVORITE, INTERESTED, IS.SHORT.SALE))
sil <- sil[sil$ORDER_REASON_ID=="STD" | sil$ORDER_REASON_ID=="REM" | sil$ORDER_REASON_ID=="REP" |sil$ORDER_REASON_ID=="CON" ,]
sil$ORDER_REASON_ID <- factor(sil$ORDER_REASON_ID)
missing.height <- sil[is.na(sil$HEIGHT),]
missing.std <- sil[!sil$ORDER_REASON_ID=="STD"&is.na(sil$REASON_CODE),]
incor.std <- sil[is.na(sil$REASON_CODE_ID) & sil$ORDER_REASON_ID != "STD" ,]
incor.std <- incor.std[incor.std$ORDER_REASON_ID!="CON",]

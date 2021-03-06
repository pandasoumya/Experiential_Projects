rm(list = ls())

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

# Find frequency of value : data.frame(with(sil, table(SOLD_TO_ID)[SOLD_TO_ID]))


######################Code below need to be verified############

sil$ORIGINAL_ORDER1 <- paste0(sil$ORIGINAL_ORDER,sil$ORIGINAL_ORDER_LINE)
#combine sales order and sales order line
sil$SALES_ORDER1 <- paste0(sil$SALES_ORDER,sil$SALES_ORDER_LINE)
sil <- sil[(sil$ORIGINAL_ORDER %in% sil$SALES_ORDER),] # drop rep/rem/crr orders with no og order
sil <- sil[!sil$NET_SALES_UNITS<0,]
dupes <- sil[duplicated(sil$SALES_ORDER1),]
good_stuff <- sil[!(sil$SALES_ORDER1 %in% dupes$SALES_ORDER1 & sil$NET_SALES_UNITS == 0),]
sil <- good_stuff[!duplicated(good_stuff$SALES_ORDER1),]
sil.cp <- sil
sil1<-merge(sil,sil.cp,by.x='ORIGINAL_ORDER1',by.y='SALES_ORDER1')
sil[(sil$ORDER_REASON_ID=="REP" | sil$ORDER_REASON_ID=="REM")&!(sil$ORIGINAL_ORDER1 %in% sil$SALES_ORDER1),]
head(sil1)

library('plyr')
COLOR_ID_COUNT<- count(sil$COLOR_ID)
color_sort<-sort(COLOR_ID_COUNT$freq, decreasing = T)
top50<- head(color_sort, 50)
top50
top50_colors <- sil[sil$COLOR_ID %in% top50, ]
top50_colors$COLOR_ID <- sil[!sil$COLOR_ID %in% top50, ]
COLOR_ID_TOP50 <- COLOR_ID_COUNT[COLOR_ID_COUNT$freq ]

hunter_douglas_50k <- read.csv("~/Desktop/Spring Term/Project Course/Hunter Douglas Quality Data 50K.csv")
hunter_douglas_main <- read.csv("~/Desktop/Spring Term/Project Course/Hunter Douglas Quality Data.csv")

table(hunter_douglas_main$PRODUCT_CATEGORY, hunter_douglas_main$ORIGINAL_PLANT)

# selected: 02 Silhouette/Nantucket, Plant: G
hunter_sil <- hunter_douglas_main[hunter_douglas_main$PRODUCT_CATEGORY == '02 Silhouette/Nantucket' & hunter_douglas_main$ORIGINAL_PLANT == 'G', ]
summary(hunter_sil)


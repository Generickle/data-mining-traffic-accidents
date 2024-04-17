# Adding libraries
install.packages("readxl")
install.packages("haven")

library(readxl)
library(haven)

# Get current working directory
getwd()  

# Set working directory
setwd("/Users/macbookpro/Developer/GitHub/Generickle/data-mining-traffic-accidents") 

# Verify access to files
list.files("data")

# Loading data
data1 <- read_excel("data/20190606220307YRSvO7OHib0rQxKDCTAl2fkXMl05g9Uz.xlsx")
data2 <- read_excel("20200519181155Y1KZ2HK3GnWnOvCP6lkZunmf8PiHYFSH.xlsx")
data3 <- read_excel("20210531230635e7G5K5EZOlGPCBiH4ROtQRgfm5sTifW1.xlsx")
data4 <- read_excel("data/20190606220307YRSvO7OHib0rQxKDCTAl2fkXMl05g9Uz.xlsx")
data5 <- read_excel("data/20190606220307YRSvO7OHib0rQxKDCTAl2fkXMl05g9Uz.xlsx")
data6 <- read_excel("data/20190606220307YRSvO7OHib0rQxKDCTAl2fkXMl05g9Uz.xlsx")
data7 <- read_excel("data/20190606220307YRSvO7OHib0rQxKDCTAl2fkXMl05g9Uz.xlsx")
data8 <- read_excel("data/20190606220307YRSvO7OHib0rQxKDCTAl2fkXMl05g9Uz.xlsx")
data9 <- read_excel("data/20190606220307YRSvO7OHib0rQxKDCTAl2fkXMl05g9Uz.xlsx")

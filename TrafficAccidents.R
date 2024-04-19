# Adding libraries
install.packages("readxl")
install.packages("haven")
install.packages("arules")
install.packages("ggplot2")
install.packages("rpart")
install.packages("rpart.plot")

library(readxl)
library(haven)
library(arules)
library(ggplot2)
library(rpart)
library(rpart.plot)

# Get current working directory
getwd()

# Set working directory
setwd("/Users/macbookpro/Developer/GitHub/Generickle/data-mining-traffic-accidents")

# Verify access to files
list.files("data")

# Loading data
data_2015 <- read_excel("data/fflzORJDQM0tVur8UvU6fz5dR51kogHr.xlsx")
data_2016 <- read_excel("data/MVtI7adfQzZWF5uefXZ4xmZVG0vRik3S.xlsx")
data_2017 <- read_excel("data/201806191110218FciGNFOtT2FJnkTOS0pTzPcDOW8FpLB.xlsx")
data_2018 <- read_excel("data/20190606220307YRSvO7OHib0rQxKDCTAl2fkXMl05g9Uz.xlsx")
data_2019 <- read_excel("data/20200519181155Y1KZ2HK3GnWnOvCP6lkZunmf8PiHYFSH.xlsx")
data_2020 <- read_excel("data/20210531230635e7G5K5EZOlGPCBiH4ROtQRgfm5sTifW1.xlsx")
data_2021 <- read_excel("data/20230911222436xaPevkVgXaNin0L0ZmXiN4fm18JAFoLG.xlsx")
data_2022 <- read_excel("data/20230526200007YRSvO7OHib0rQxKDCTAl2fkXMl05g9Uz.xlsx")
data_2023 <- read_excel("data/20231212173715Yd6FWtyVWNULqHYzwTiXcRaLAl8B8jul.xlsx")
data_sav_1 <- read_sav("data/0NGWpC89u7XxdYqecRmMtNfW9uU9Npxc.sav")
data_sav_2 <- read_sav("data/DX2BmYU5m4JfPRhrFHwDRDEs49V7fN5I.sav")
data_sav_3 <- read_sav("data/gPTFUNJBcdfc5quaJizKEgBWvpjHBM70.sav")
data_sav_4 <- read_sav("data/JHtnT62UiTxEP6AbhA4RcFDN6Nokk4c9.sav")
data_sav_5 <- read_sav("data/LWRcgzU2wzY2XMCyCmupjEFTYoSZiWGy.sav")
data_sav_6 <- read_sav("data/xpN37xrHYYECLYQyVq7EiklsaibU3DM0.sav")

# Explore data
head(data_2016)
head(data_2017)
head(data_2018)
head(data_2019)
head(data_2020)
head(data_2021)
head(data_2022)
head(data_2023)
head(data_sav_1)
head(data_sav_2)
head(data_sav_3)
head(data_sav_4)
head(data_sav_5)

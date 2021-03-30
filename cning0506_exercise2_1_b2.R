# R-Version 4.0.2 "Taking Off Again"

# File Name: "Exercise 2.1.R"

# Case Study Description: Duplicate Analysis 
##                        The goal of this project was to determine the efficacy of wireless sensor networks (WSN) under natural outdoor conditions for collecting high precision environmental data.

# Created by: Conrad Ning 

# Last edited on: 3/12/2021

setwd("C:/Users/Winston_Ning/Desktop/Spring 2021/DATA 330//Module 2/Exercsie2_1/")

######Import Sources #####
source("Utility.R")


# Load all the Dataset using 

id003 <-load_data("https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2003.txt")
id015 <-load_data("https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2015.txt")
id025 <-load_data("https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2025.txt")
id045 <-load_data("https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2045.txt")
id055 <-load_data("https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2055.txt")
id065 <-load_data("https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2065.txt")
id085 <-load_data("https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2085.txt")
id095 <-load_data("https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2095.txt")
id103 <-load_data("https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2103.txt")
id115 <-load_data("https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2115.txt")
id125 <-load_data("https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2125.txt")
id135 <-load_data("https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2135.txt")

listofdf <- list(id003,id015,id025,id045,id055,id065,id085,id095,id103,id115,id125,id135)


ogdf <- aggregate(listofdf)

# De-duplication
duplicateVector = c()
numRow <- length(id003$result_time)




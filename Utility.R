# R-Version 4.0.2 "Taking Off Again"

# File Name: "Utility_Script.R"

# Created by: Conrad Ning, Connor Sughrue, Matt McCormack, Kimya Shirazi, Keagan DeLong, Monica 

# Last edited on: 3/11/2021

###

# Function to load in data

## read.csv("filename",sep=",")
load_data <- function(filename) {
  id0 = read.csv(filename,sep=",")
}

# Function to aggregate data
aggregate <- function(listofdf){
  Reduce(
  function(x, y, ...) merge(x, y, all = TRUE, ...),
  listofdf
  )
}

# Function to Data de-duplication
removeDuplicates <- function(data, timeBoundary = 450){
  
  duplicateVector = c()
  numRow <- length(data$result_time)
  
  duplicateVector = c(duplicateVector, TRUE)
  startTime <- strptime(data$result_time[1], "%Y-%m-%d %H:%M:%S")
  
  for (i in 1:numRow - 1){
    
    nextTime <- strptime(data$result_time[i + 1], "%Y-%m-%d %H:%M:%S")
    timeDifference <- as.numeric(difftime(nextTime, startTime, units = c("secs")))
    
    if (timeDifference > timeBoundary){
      duplicateVector = c(duplicateVector, TRUE)
      startTime <- strptime(data$result_time[i + 1], "%Y-%m-%d %H:%M:%S")
    }
    else{
      duplicateVector = c(duplicateVector, FALSE)
    }
  }
  return(data[duplicateVector,])
}

# Function to calculate arithmetic means based on specified time intervals


# Function to analyze correlation coefficient (Pearson's R), R-squared, RMSE

# Function to reproduce the figures






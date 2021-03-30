# Project 1
#install.packages("dplyr")
#install.packages("lubridate")
#install.packages("data.table")
#install.packages("tswge")
library("tswge")
library(ggplot2)
library(dplyr)
library(lubridate)
library(data.table)

#install.packages('reshape')
library('reshape')

##Oceanic Niño Index (ONI)

# Define the URL, scrub the file name from the URL and download to folder
oni.url <- "https://www.cpc.ncep.noaa.gov/data/indices/oni.ascii.txt"
oni.name <- tail(unlist(strsplit(oni.url, "/")), n=1)
oni.file <- paste("C:/Users/Winston_Ning/Desktop/Spring 2021/DATA 330/Project 1/Data", oni.name, sep="")
download.file(oni.url, oni.file, method = 'auto')

# Read directly to dataframe preserving the header
oni.df <- read.table(oni.file, header = TRUE)
oni.df

# Turn anomalies into a time series object
oni.ts <- ts(oni.df$ANOM, start = c(1964, 1), frequency = 17)
plot(oni.ts, main = "Three-month running average of ONI")

plot.ts(oni.ts)
spectrum(oni.ts)
plotts.sample.wge(oni.ts, lag.max = 55)


# Periodogram 
oni.period <- period.wge(oni.ts, plot=TRUE)

# Reproduce Figure 1 ONI

year <-group_by(oni.df,'YR')
new <- drop(year[year$YR>=1964,])

test<- data %>%
  group_by(YR) %>%
  summarize(four = mean(head(ANOM,4),na.rm=TRUE),
            max_val = max(head(ANOM,4)),
            min_val = min(head(ANOM,4)))



test$max_val_abs = abs(test$max_val)
test$min_val_abs = abs(test$min_val)
test
test$best <- ifelse(0+test$max_val > 0-test$min_val_abs, test$max_val,
                     ifelse(0-test$max_val_abs < 0-test$min_val_abs, test$min_val))


sp <- ggplot(test, aes(x=YR, y=best)) + 
  geom_point(size=2, shape=1)+
  labs(title="ONI in Dec-Feb 1964-2017",
       x="Year", y = "ONI",hjust = 0.5)
sp

sp + theme(
  plot.title = element_text(hjust = 0.5)) +
  geom_hline(yintercept = 0.5, linetype='dashed')+geom_hline(yintercept = -0.5,linetype='dashed') + geom_hline(yintercept = 0)





# Multi-variate ENSO Index (MEI)
# The MEI data (1964-2018) is organized in an HTML file, but examining the page source, we see the data is neatly organized in a <pre> tag buried a bit down in the body of the file. Conveniently, the data are not in an HTML table.

# Define the URL, scrub the file name, and download it to folder
mei.url <- "https://psl.noaa.gov/enso/mei.old/table.html"
mei.name <- tail(unlist(strsplit(mei.url, "/")), n=1)
mei.file <- paste("C:/Users/Winston_Ning/Desktop/Spring 2021/DATA 330/Project 1/Data", mei.name, sep="")
download.file(mei.url, mei.file, method = 'auto')



# Read the column names from the data
a <- readLines(mei.file)
for (my.line in a){
  a <- grep("^YEAR.*", my.line)
  if (length(a) > 0) {
    my.cols <- unlist(strsplit(my.line, "\\s+"))
  }
}

#my.cols

# Create an empty dataframe
n.cols <- length(my.cols)
mei.df <- data.frame(matrix(ncol = n.cols, nrow = 0))
colnames(mei.df) <- my.cols 
str(mei.df)

# Get all the data lines
a <- readLines(mei.file)
for (my.line in a){
  a <- grep("^[0-9].*", my.line)
  if (length(a) > 0) {
    my.data <- unlist(strsplit(my.line, "\\s+"))
    num.data <- length(my.data)
    if (num.data == n.cols) {
      my.values <- c()
      for (d in my.data) {
        my.values <- append(my.values, as.numeric(d))
      }
      mei.df[nrow(mei.df)+1,] = my.values
    }
  }
}

# Slice the dataframe for all rows and not the first column
mei.df[1:17, 2:n.cols]


# Convert the last twelve columns into a row-by-row vector
# then feed that into the time series function
mei.ts <- ts(as.vector(t(mei.df[,2:length(my.cols)])), start = c(1964, 1), frequency = 17)
plot(mei.ts, main = "Two-month running average MEI")
mei.df

# Periodogram and ACF
plotts.sample.wge(mei.ts, lag.max = 55, trunc = 170)



# Reproduce Figure 1 MEI

mei <-group_by(mei.df,'YEAR')
mei.new <- drop(mei[mei$YEAR>=1964,])
keep <- c("YEAR","DECJAN")
mei.data = mei.new[keep]
mei.data

sp1 <- ggplot(mei.data, aes(x=YEAR, y=DECJAN)) + 
  geom_point(size=2, shape=1)+
  labs(title="MEI in Dec-JAN 1964-2017",
       x="Year", y = "MEI",hjust = 0.5)
sp1

sp1 + theme(
  plot.title = element_text(hjust = 0.5)) +
  geom_hline(yintercept = 0.5, linetype='dashed')+geom_hline(yintercept = -0.5,linetype='dashed') + geom_hline(yintercept = 0)



# Find the dominant frequency 
f1 <- mei.df$freq[which.max(mei.df$pgram)]
f2 <- mei.ts$freq[which.max(mei.plot$pgram[c(560:length(mei.plot$pgram))])] # this is the second frequency close to 0.2

cat('Frequency 1: ', f1, '\n')
cat('Period 1: ', 1/f1, '\n')
cat('Frequency 2: ', f2, '\n')
cat('Period 2: ', 1/f2, '\n')



## PAD Data

pad.file <- "C:/Users/Winston_Ning/Desktop/Spring 2021/DATA 330/Project 1/Data/EmDat_public_1964_2017.csv"
pad.df.all <- read.csv(pad.file, header=TRUE, skip=6)

cols.interest <- c("Country", "ISO", "Start.Year", "Start.Month", 
                   "End.Year", "End.Month", "Total.Affected")
pad.df <- pad.df.all[cols.interest]
length(unique(pad.df$ISO))

#wbank.url <- "http://api.worldbank.org/v2/en/indicator/SP.POP.TOTL?downloadformat=csv"
#wbank.name <- "world_bank.zip"
#wbank.file <- paste("C:/Users/Winston_Ning/Desktop/Spring 2021/DATA 330/Project 1/", wbank.name, sep="")
#download.file(wbank.url, wbank.file)

#unzip(zipfile = wbank.file,exdir = "C:/Users/Winston_Ning/Desktop/Spring 2021/DATA 330/Project 1/")

# Convert it to Time Series Data
clean_pad <- na.omit(pad.df)
pad.ts <- ts(clean_pad$Total.Affected, start = c(1964, 1), frequency = 17)
plot(pad.ts, main = "Two-month running average MEI")
pad.ts

# Graph Periodogram and ACF


plotts.sample.wge(pad.ts, lag.max = 55, trunc =50)



## Reproduce PAD Figure 1
pad.df

year.2 <-group_by(pad.df,'End.Year')
new.2 <- drop(year.2[year.2$End.Year<2018,])

new.2

test.3<- new.2 %>%
  group_by(End.Year) %>%
  summarize(ppl = sum((Total.Affected)/1700000,na.rm=TRUE))

test.3


sp2 <- ggplot(test.3, aes(x=End.Year, y=ppl)) + 
  geom_point(size=2, shape=1)+
  labs(title="PAD (per 1000) 1964-2017",
       x="Year", y = "PAD")+
  ylim(0,170)
sp2

sp2 + theme(
  plot.title = element_text(hjust = 0.5)) 


pad.filt <- subset(pad.df, Start.Year > 1963 & Start.Year <2018)
pad.filt

pad.filt$POP[duplicated(pad.filt$POP)] <- 0
pad.filt[is.na(pad.filt)] <-0 

test_pad<- pad.filt %>%
  group_by(End.Year) %>%
  summarize(fixed_pop = sum(Total.Affected)/sum(as.numeric(POP)))

#ppl = sum((Total.Affected)/5171717,na.rm=TRUE))
test_pad

sp3 <- ggplot(pad_graph, aes(x=year_no, y=year_pad)) + 
  geom_point(size=2, shape=1)+
  labs(title="PAD (per 1000) 1964-2017",
       x="Year", y = "PAD")+ ylim(0,125)
sp3

sp3 + theme(
  plot.title = element_text(hjust = 0.5)) 


pad.ts1 <- ts(pad_graph$year_pad, start = c(1964, 1))
plot(pad.ts1)



# Load the data
pad.file <- "C:/Users/Winston_Ning/Desktop/Spring 2021/DATA 330/Project 1/Data/EmDat_public_1964_2017.csv"
pad.df.all <- read.csv(pad.file, header=TRUE, skip=6)
cols.interest <- c("Country", "ISO", "Start.Year", "Start.Month", 
                   "End.Year", "End.Month", "Total.Affected")
pad.df <- pad.df.all[cols.interest]

wb.file <- paste("C:/Users/Winston_Ning/Desktop/Spring 2021/DATA 330/Project 1/", my.file, sep="")
wb.df <- read.csv(wb.file, header = TRUE, skip = 4)

colnames(wb.df)

unique(wb.df$Country.Code)

length(unique(wb.df$Country.Code))
for (i in 1:nrow(pad.df)) {
  # Remember i is the row index in pad.df
  tmp.iso <- pad.df[i, ][['ISO']]
  tmp.year <- pad.df[i, ][['Start.Year']]
  tmp.col <- paste("X", tmp.year, sep="")
  # Match returns "NA" if no match
  a <- match(tmp.iso, wb.df$Country.Code)
  if (!is.na(a)) {
    tmp.pop <- wb.df[,tmp.col][a]
    # We can create new dataframe columns on the fly
    pad.df[i, 'POP'] = tmp.pop
    #print(c(tmp.iso, tmp.year, tmp.pop))
  } else {
    # Make sure to assign missing values, too!
    pad.df[i, 'POP'] = NA
    #print(paste("Could not match", tmp.iso))
  }
}



#calculate the total number of people impacted by disasters in 1700
#filter out NAs 

pad.final <- subset(pad.df, End.Year > 1973 & End.Year <2017)
pad.0 <- 0
for (i in 1:nrow(pad.final)){
  if (!is.na(pad.final$Total.Affected[i]) & !is.na(pad.final$POP[i])) {
    my.ta <- pad.final$Total.Affected[i]
    my.tp <- pad.final$POP[i]
    pad.0 <- pad.0 + my.ta
  }
}

pad.0 * 1700

pad.final

pop.17 <- 0
for (my.iso in unique(my17$ISO)){
  #print(my.iso)
  a <- match(my.iso, my17$ISO)
  tmp.pop <- my17$POP[a]
  if (!is.na(tmp.pop)){
    pop.17 <- pop.17 + tmp.pop
  }
}

pop.17

pad17 <- pad.17/pop.17*1710
pad2172

year_pad = c(pad64,pad65,pad66,pad67,pad68,pad69,
             pad70,pad71,pad72,pad73,pad74,pad75,pad76,pad77,pad78,pad79,
             pad80,pad81,pad82,pad83,pad84,pad85,pad86,pad87,pad88,pad89,
             pad90,pad91,pad92,pad93,pad94,pad95,pad96,pad97,pad98,pad99,
             pad00,pad01,pad02,pad03,pad04,pad05,pad06,pad07,pad08,pad09,
             pad10,pad11,pad12,pad13,pad14,pad15,pad16,pad17)

year_no = c(1964:2017)

pad_graph <- data.frame(year_no,year_pad)


my.17.pad <- subset(pad.df, Start.Year==2017)
pad.17 <- 0
for (i in 1:nrow(my.17.pad)){
  if (!is.na(my.17.pad$Total.Affected[i]) & !is.na(my.17.pad$POP[i])) {
    my.ta <- my.17.pad$Total.Affected[i]
    my.tp <- my.17.pad$POP[i]
    pad.17 <- pad.17 + my.ta
  }
}

pop.17 <- 0
for (my.iso in unique(my.17.pad$ISO)){
  #print(my.iso)
  a <- match(my.iso, my.17.pad$ISO)
  tmp.pop <- my.17.pad$POP[a]
  if (!is.na(tmp.pop)){
    pop.17 <- pop.17 + tmp.pop
  }
}

pad17 <- pad.17/pop.17*1000

#pad.64 * 1710






#calculate the per 1710 pad for 1717
pad64 <- pad.64/pop.64*1710





# Southern Oscillation Index (SOI)


soi.url <- "https://crudata.uea.ac.uk/cru/data/soi/soi.dat"
soi.name <- tail(unlist(strsplit(soi.url, "/")), n=1)
soi.file <- paste("C:/Users/Winston_Ning/Desktop/Spring 2021/DATA 330/Project 1/Data", soi.name, sep="")
download.file(soi.url, soi.file, method = 'auto')


# Read directly to dataframe preserving the header
soi.df <- read.table(soi.file, header = TRUE)
soi.df

# Turn anomalies into a time series object
soi.ts <- ts(soi.df$X.0.16, start = c(1964, 1), frequency = 16)
soi.ts
plot(soi.ts, main = "Three-month running average of SOI")

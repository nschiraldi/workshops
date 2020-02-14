# Setup instructions ----
#
# R and RStudio are separate downloads and installations. R is the underlying
# statistical computing environment, but using R alone is no fun. RStudio is a
# graphical integrated development environment (IDE) that makes using R much
# easier and more interactive. You need to install R before you install RStudio.
# After installing both programs, you will need to install the tidyverse package
# from within RStudio. Follow the instructions below for your operating system,
# and then follow the instructions to install tidyverse. 
# 
# Windows 
# 
#
# If you already have R and RStudio installed Open RStudio, and click on 
# "Help" > "Check for updates". If a new version is available, 
# quit RStudio, and download the latest version for RStudio. To check
# which version of R you are using, start RStudio and the first thing that
# appears in the console indicates the version of R you are running.
# Alternatively, you can type sessionInfo(), which will also display which
# version of R you are running. Go on the CRAN website and check whether a more
# recent version is available. If so, please download and install it. You can
# check here for more information on how to remove old versions from your system
# if you wish to do so.
#
# If you don't have R and RStudio installed
#
# Download R from the CRAN website. Run the .exe file that was just downloaded
# Go to the RStudio download page Under Installers select RStudio x.yy.zzz -
# Windows Vista/7/8/10 (where x, y, and z represent version numbers) Double
# click the file to install it Once it's installed, open RStudio to make sure it
# works and you don't get any error messages.
#
# macOS If you already have R and RStudio installed
#
# Open RStudio, and click on "Help" > "Check for updates". If a new version is
# available, quit RStudio, and download the latest version for RStudio. To check
# the version of R you are using, start RStudio and the first thing that appears
# on the terminal indicates the version of R you are running. Alternatively, you
# can type sessionInfo(), which will also display which version of R you are
# running. Go on the CRAN website and check whether a more recent version is
# available. If so, please download and install it.
#
# If you don't have R and RStudio installed
#
# Download R from the CRAN website. Select the .pkg file for the latest R
# version Double click on the downloaded file to install R It is also a good
# idea to install XQuartz (needed by some packages) Go to the RStudio download
# page Under Installers select RStudio x.yy.zzz - Mac OS X 10.6+ (64-bit) (where
# x, y, and z represent version numbers) Double click the file to install
# RStudio Once it's installed, open RStudio to make sure it works and you don't
# get any error messages.
#
# Linux
#
# Follow the instructions for your distribution from CRAN, they provide
# information to get the most recent version of R for common distributions. For
# most distributions, you could use your package manager (e.g., for
# Debian/Ubuntu run sudo apt-get install r-base, and for Fedora sudo yum install
# R), but we don't recommend this approach as the versions provided by this are
# usually out of date. In any case, make sure you have at least R 3.3.1. Go to
# the RStudio download page Under Installers select the version that matches
# your distribution, and install it with your preferred method (e.g., with
# Debian/Ubuntu sudo dpkg -i rstudio-x.yy.zzz-amd64.deb at the terminal). Once
# it's installed, open RStudio to make sure it works and you don't get any error
# messages.
#
# For everyone
#
# After installing R and RStudio, you need to install the tidyverse and RSQLite
# packages.
#
# After starting RStudio, at the console type: install.packages(c("tidyverse"))
#
# You can also do this by going to Tools -> Install Packages and typing the
# names of the packages separated by a comma.

library(tidyverse)

# Objects ----
9+4
9*pi
4/6
value <- 4/6
value = 4/6
(value)
value
value # this is an important value to me so I'm going to comment on it.
value+4
new_value <- value + 4

# Functions ----
sqrt(new_value)
sqrt_nvalue <- sqrt(new_value)
sqrt_nvalue
round(sqrt(new_value))
round(sqrt_nvalue)

args(sqrt)
args(round)
?round
??rounding

# Vectors ----
vvalues <- c(1,5,6,7)
vvalues

vstrings <- c("goldman", "kropotkin", "bookchin")
vstrings

length(vvalues)
length(vstrings)

class(vvalues)
class(vstrings)

str(vvalues)
str(vstrings)

vstrings2<- c(vstrings, "stewart")
vstrings2

vmixed <- c(vvalues, vstrings2)
class(vmixed)
str(vmixed)

vvalues[2]
vvalues[c(1,4)]
vvalues[c(TRUE,FALSE,T,F)]
vvalues>5
vvalues[vvalues>5]
vvalues[vvalues>5|vvalues<3]
vvalues[vvalues>5|vvalues==1]
vvalues[vvalues==0]

vstrings2[vstrings2=="goldman"|vstrings2=="bookchin"]
vstrings2 %in% c("goldman")
vstrings2[vstrings2 %in% c("goldman")]

# Missing Data ----
vvalues2 <- c(1,2,9,NA)
mean(vvalues2)
max(vvalues2)
mean(vvalues2, na.rm=T)

vvalues2[is.na(vvalues2)]
vvalues2[!is.na(vvalues2)]

na.omit(vvalues2)

vvalues2[complete.cases(vvalues2)]

# Inspecting Data Frames ----
dim(dp_data)
nrow(dp_data)
ncol(dp_data)
head(dp_data)
tail(dp_data)

names(dp_data)
str(dp_data)
summary(dp_data)



# Death Penalty Data ----
dp_data_ak <-read_csv("https://gitlab.rit.albany.edu/ns742711/python-workshop/raw/master/python/data/espyAK-AL-OR/espyAK.csv")
dp_data_al <- read_csv("https://gitlab.rit.albany.edu/ns742711/python-workshop/raw/master/python/data/espyAK-AL-OR/espyAL.csv")
dp_data_or <- read_csv("https://gitlab.rit.albany.edu/ns742711/python-workshop/raw/master/python/data/espyAK-AL-OR/espyOR.csv")
dp_data <- rbind(dp_data_ak, dp_data_al, dp_data_or)
dp_data_list <- lapply(list("https://gitlab.rit.albany.edu/ns742711/python-workshop/raw/master/python/data/espyAK-AL-OR/espyAK.csv",
            "https://gitlab.rit.albany.edu/ns742711/python-workshop/raw/master/python/data/espyAK-AL-OR/espyAL.csv",
            "https://gitlab.rit.albany.edu/ns742711/python-workshop/raw/master/python/data/espyAK-AL-OR/espyOR.csv"), read.csv)
names(dp_data_list) <- c("Alaska", "Alabama", "Oregon")
dp_data <- bind_rows(dp_data_list)
lapply(dp_data_list, function(x) class(x$date_crime))
dp_data_list$Alaska$date_crime <- as.character(dp_data_list$Alaska$date_crime)
dp_data <- bind_rows(dp_data_list)

dp_data_ss<- dp_data %>%
  filter(state_abbreviation=="AL")%>%
  dplyr::select(state_abbreviation,date_execution,age,gender_assigned,
                race,enslaved,owner_name,jurisdiction,county_name,county_code)%>%
  mutate(date_execution_year=as.numeric(substring(date_execution,1,4)))

View(dp_data)
head(dp_data)
class(dp_data)

# Inspecting Data Frames ----
dim(dp_data)
nrow(dp_data)
ncol(dp_data)
head(dp_data)
tail(dp_data)

names(dp_data)
str(dp_data)
summary(dp_data)

# Indexing and subsetting ----
dp_data[1,1]
dp_data[3,4]
dp_data[[1]]
dp_data[1]
dp_data[1:3, 1]
dp_data[6,]
important_case <- dp_data
dp_data[,-3]
dp_data["race"]
dp_data[,"race"]
dp_data[["race"]]
dp_data$jurisdiction


# Executions per year ----
## Table and a plot
table(dp_data_ss$date_execution_year)
al_executions_year <- dp_data_ss %>%
  group_by(state_abbreviation, date_execution_year)%>%
  summarise(executions=n())

ggplot(data=al_executions_year, aes(x=date_execution_year, y=executions))+
  geom_line()

# Executions by enslaved by Year ----
## Table and a plot
table(dp_data_ss$date_execution_year, dp_data_ss$enslaved)
al_executions_year_enslaved <- dp_data_ss %>%
  group_by(state_abbreviation, date_execution_year, enslaved)%>%
  summarise(executions=n())%>%
  filter(!is.na(date_execution_year))

ggplot(data=al_executions_year_enslaved, aes(x=date_execution_year, y=executions, color=enslaved))+
  geom_line()

ggplot(data=al_executions_year_enslaved, aes(x=date_execution_year, y=executions))+
  geom_line()+
  facet_wrap(~enslaved)

# Executions by race by Year
## Data Transformation white v non-white
unique(dp_data_ss$race)
dp_data_ss <- dp_data_ss %>%
  mutate(white=ifelse(race=="White", "White",
                      ifelse(race=="",NA,"Non-White")))

al_executions_year_race <- dp_data_ss %>%
  group_by(date_execution_year, white)%>%
  summarize(executions=n())%>%  
  filter(!is.na(date_execution_year),!is.na(white))

ggplot(data=al_executions_year_race, aes(x=date_execution_year, y=executions, color=white))+
  geom_line()

ggplot(data=al_executions_year_race, aes(x=date_execution_year, y=executions))+
  geom_line()+
  facet_wrap(~white)


### Table and a plot
# Race and Executions by Year
al_executions_year_race_enslaved <- dp_data_ss %>%
  group_by(date_execution_year, white, enslaved)%>%
  summarize(executions=n())%>%  
  filter(!is.na(date_execution_year),!is.na(white))

## Table and a plot
ggplot(data=al_executions_year_race_enslaved, aes(x=date_execution_year, y=executions, color=white))+
  geom_line()+
  facet_wrap(~enslaved)

al_executions_year_race_enslaved <- al_executions_year_race_enslaved %>%
  mutate(enslaved=ifelse(enslaved=="true","Enslaved", "Not Enslaved"),
         race_enslaved=paste(white, enslaved, sep="-"))

ggplot(data=al_executions_year_race_enslaved, aes(x=date_execution_year, y=executions, color=race_enslaved))+
  geom_line()

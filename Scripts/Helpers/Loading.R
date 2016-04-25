#libraries in correct order
library('R6')
library('data.table')
library('plyr')
library('dplyr')
library('stringr')
library('png')
library('grid')
library('ggplot2')

#custom items

source(paste(getwd(),"Scripts/HelperFunctions/helperFunctions.R",sep="/"))
source_folder(paste(getwd(),"Scripts/Helpers/",sep="/"))
source_folder(paste(getwd(),"Scripts/Analysis/",sep="/"))
source_folder(paste(getwd(),"Scripts/Classes/",sep="/"))
source_folder(paste(getwd(),"Scripts/Preprocessing/", sep="/"))

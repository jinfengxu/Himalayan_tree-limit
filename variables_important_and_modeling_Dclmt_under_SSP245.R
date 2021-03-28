rm(list=ls())
library(randomForest)
#devtools::install_github("MI2DataLab/randomForestExplainer")
library(randomForestExplainer)
library(kernlab)
library(caret)
#install.packages('caret', dependencies = TRUE)
library(CORElearn)
library(e1071)
library(forestFloor)
library(hypervolume)
library(hypervolume)

###################################### begin training ###########################
setwd("D:/Fig3/")
input_varOrig <-
  read.table(paste("tree_limit_variables.csv",sep = ""), sep = ",", header = TRUE)
head(input_varOrig)
input_var <- subset(input_varOrig, select = c(Dclmt,
                                              CWD,
											  Human.footprint.int,
                                              Vapor.pressure,
											  Summer.Desiccation,
											  Cloudcover,
											  Tmin))
input_var <- data.frame(input_var)
set.seed(1182)
pow <- function(x,n){
  return(x^n)
}
index = which(input_var$Human.footprint.int < 5)
input_human = input_var[index,]
input_var4RCP = input_human[, 1:dim(input_human)[2]]
input_var4RCP <- subset(input_var4RCP, select = -c(Human.footprint.int)) 
input_var4HFP  <- subset(input_var, select = -c(Human.footprint.int)) 
#######################################  RF  ##################################################
# 10 fold cross validation
fitControl <-
  trainControl(
    method = "repeatedcv",
    number = 10,
    repeats = 10,
    returnResamp = "all"
  )
#################################################################################################
response <- input_var4RCP[, 1]
predictors <- input_var4RCP[,2:length(input_var4RCP)]
pre_names <-colnames(predictors)
hv = hypervolume(predictors,method = "gaussian")
plot(hv,show.3d = FALSE)
forest <- randomForest(Dclmt ~ ., data = input_var4RCP, mtry=2,ntree=500, importance=T)
imp <- importance(forest, type=1, scale = T)
################################    Pred      ###########################
pathRCP = "D:/SSP245/"  
input_varpredorig <-
  read.table(paste(pathRCP,"CMIP6_SSP245.csv",sep = ""), sep = ",", header = TRUE)
input_varpred1 <-cbind(input_varpredorig$SSP.CWD,
                       input_varpredorig$SSP.VPD,
                       input_varpredorig$SSP.Summer.desiccation,
                       input_varpredorig$SSP.Cloudcover,
                       input_varpredorig$SSP.Tmin)

input_varpred1 <- data.frame(input_varpred1)
colnames(input_varpred1) = pre_names
rm(input_varpredorig)
#############################################################
input_varpredHFP <- input_var
input_varpredHFP <-cbind(input_var$CWD,
                         input_var$VPD,
                         input_var$Summer.desiccation,
                         input_var$Cloudcover,
						 input_var$Tmin)
input_varpredHFP <- data.frame(input_varpredHFP)
colnames(input_varpredHFP) = pre_names
alldata <-rbind(predictors,input_varpred1,input_varpredHFP)
################################ scale  ################################
alldata <- scale(alldata, center=TRUE, scale=TRUE)
alldata <- data.frame(alldata)
predictors <- alldata[1:1469,]
RCP245 <-alldata[1470:6260,]
HFP <-alldata[6261:11051,]
colnames(predictors) <- c("CWD","VPD","desiccation","Cloudcover","Tmin")
predictors <- data.frame(predictors)
colnames(RCP245) =colnames(predictors)
RCP245 <- data.frame(RCP245)
colnames(HFP) =colnames(predictors)
HFP <- data.frame(HFP)
rfFit <-
  train(predictors,response,method = "rf",
        trControl = fitControl,importance = TRUE,
        preProcess=c("center","scale"))
rfFit$results
rfPredOutAll245 <- predict(rfFit,RCP245,inf.rm=TRUE,na.rm=TRUE)
rfPredOutAllHFP <- predict(rfFit,HFP,inf.rm=TRUE,na.rm=TRUE)
change245 = (rfPredOutAll245-rfPredOutAllHFP)
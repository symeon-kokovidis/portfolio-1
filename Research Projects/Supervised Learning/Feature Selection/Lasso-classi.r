##############################

#EXPORT DATA FRAME TO CSV
write.table(dataset, file="ddd.csv", sep=",")

##################

DATA CLEANSING FOR BIG DATASET

#combine datasets
dataset <-merge(x = dataset, y = MEAN, by = "Area Name", all = TRUE)



#on the final test dataset
dataset$`Area Name` <- NULL
dataset=na.omit(dataset)
colnames(dataset)[453] <- "house_prices_mean"
dataset = data.frame(dataset)

as.data.frame
  dataset=na.omit(dataset)

frame <-data.frame(matrix(NA, nrow=100, ncol=3))
NUM<- ncol(dataset)-2


#N/A COLUMMNS

na.test <-  function (x) {
    w <- sapply(x, function(x)all(is.na(x)))
    if (any(w)) {
        stop(paste("All NA in columns", paste(which(w), collapse=", ")))
    }
}

na.test(dataset)


#loop delete
for(i in 40:61) {
    dataset[40] <- NULL
}


#loop seed
for(i in 1:100) {
  set.seed(i)

  frame[i,"X1"] <- sqrt(TestMseWithLambaOfOneStandardErrorTrainMse)
  frame[i,"X2"] <- sum(!lasso.coef.1se == 0)
  frame[i,"X3"] <- oneselam
}





#################################

library(glmnet)

#set seed number
SNUM=1
set.seed(SNUM)

#set number of folds for Shrinkage methods
NFOLDS=10

#variable count
NUM<- ncol(dataset)-2
#create an expression of response-predictor - in case of all use dot (.)
EXP =  class1 ~ .
RES = dataset$class1
  #MATRIX TO STORE OUR PLOTS
  par(mfrow=c(2,1))


    #BLOCK 1
          #DATA - LAMBDA MODIFICATIONS
          #EXTENDED LAMBDA VALUES
          grid=10^seq(10,-2,length=100)

          #DATA PREPARATION
          #assign x & y
          x= model.matrix(as.formula(EXP) ,dataset)[,-1]
          y= RES
            # CV - DATA PREPARATION
            train=sample(1:nrow(x), nrow(x)/2)
            test=(-train)
            y.test=y[test]

    #BLOCK 2
          #CV ON TRAIN DATA - MSE ESTIMATION
          lasso.mod=glmnet(x[train ,],y[train],alpha=1,lambda=grid , family="binomial")
          plot(lasso.mod, xvar="lambda", label=TRUE, ,main="Lambda-Coefficients plot - TRAIN DATA")

          set.seed (SNUM)
          cv.out=cv.glmnet(x[train ,],y[train],alpha=1, , nfolds=NFOLDS)
          plot(cv.out, main="Lambda - MSE Error - TRAIN DATA")

        #BLOCK 2.1
              # LOWEST MSE
              bestlam=cv.out$lambda.min
              bestlam
              lasso.pred=predict(lasso.mod,s=bestlam ,newx=x[test,])
              TestMseWithLambaOfLowTrainMse=mean((lasso.pred-y.test)^2)
              format(TestMseWithLambaOfLowTrainMse, big.mark=".", decimal.mark="," , scientific=FALSE)
              #coeff for every variable
              out=glmnet(x,y,alpha=1,lambda=grid)
              lasso.coef.lmse=predict(out,type="coefficients",s=bestlam)[1:NUM+2,]

              #exclude all zero coeff variables
              lasso.coef.lmse[lasso.coef.lmse!=0]


          #BLOCK 2.2
              #ONE STANDARD ERROR RULE
              oneselam=cv.out$lambda.1se
              oneselam
              lasso.pred=predict(lasso.mod,s=oneselam ,newx=x[test,])
              TestMseWithLambaOfOneStandardErrorTrainMse=mean((lasso.pred-y.test)^2)
              format(TestMseWithLambaOfOneStandardErrorTrainMse, big.mark=".", decimal.mark="," , scientific=FALSE)
              #coeff for every variable
              out=glmnet(x,y,alpha=1,lambda=grid)
              lasso.coef.1se=predict(out,type="coefficients",s=oneselam)[1:NUM+2,]

              #exclude all zero coeff variables





          ##########################################################
          ############### LASSO with LOWEST MSE ####################
          bestlam
          format(TestMseWithLambaOfLowTrainMse, big.mark=".", decimal.mark="," , scientific=FALSE)
          ##########################################################
          #Coefficients for lowestMSE
          lasso.coef.lmse[lasso.coef.lmse!=0]

          ##########################################################
          ############### LASSO with 1SE RULE   ####################
          oneselam
          format(TestMseWithLambaOfOneStandardErrorTrainMse, big.mark=".", decimal.mark="," , scientific=FALSE)
          ##########################################################
          #Coeeficients for 1 st error rule
          lasso.coef.1se[lasso.coef.1se!=0]


          ##########################################
          ############### LASSO ####################
          ##########################################
          TestMseWithLambaOfLowTrainMse
          sqrt(TestMseWithLambaOfLowTrainMse)
          format(TestMseWithLambaOfLowTrainMse, big.mark=".", decimal.mark="," , scientific=FALSE)      #we use format() to seperate numbers by dot
          #number of total selected variables
          sum(!lasso.coef.lmse == 0)

          TestMseWithLambaOfOneStandardErrorTrainMse
          format(TestMseWithLambaOfOneStandardErrorTrainMse, big.mark=".", decimal.mark="," , scientific=FALSE)      #we use format() to seperate numbers by dot
          #Coefficients for 1 st error rule
          sqrt(TestMseWithLambaOfOneStandardErrorTrainMse)
          #number of total selected variables
          onesevar <-   lasso.coef.1se[lasso.coef.1se!=0]


#coeff
glm.fits=glm(class1~ c,data=dataset,family=binomial)
summary(glm.fits)
coef(glm.fits)




glm.probs=predict(glm.fits,type="response")
glm.pred=rep("Down",5897)
glm.pred[glm.probs>.5]="Up"
table(glm.pred,dataset$class1)



train = sample(5897, 4000, replace = FALSE)
class.test=dataset[!train,]

#create a dataset only with the selected variables from lasso
varnames <- names(dataset)
lassoselect<-names(lasso.coef.1se[lasso.coef.1se!=0])
shrinked_dataset<- dataset[, which(varnames %in% lassoselect)]


data.test = shrinked_dataset[-train,]
dim <- dim(data.test)
#we need to keep the response
#glm.fits=glm(class1 ~ . ,data=shrinked_dataset, subset=train, family=binomial)
glm.probs=predict(glm.fits, data.test, type="response")
glm.pred=rep("NO",dim)
glm.pred[glm.probs>.5]="YES"






Error in contrasts(dataset$class1) : contrasts apply only to factors
classone <- as.binary(dataset$class1)
Error in as.binary(dataset$class1) : could not find function "as.binary"
classone <- as.factor(dataset$class1)
contrasts(classone)
  1
0 0
1 1
glm.pred=rep("Down",5897)
glm.pred=rep("NO",5897)
glm.pred[glm.probs>.5]="YES"
table(glm.pred,Direction)
Error in table(glm.pred, Direction) : object 'Direction' not found
glm.pred[glm.probs>.5]="YES"
table(glm.pred,classone)
        classone
glm.pred    0    1
     NO  3436  521
     YES  351 1589
> (3436+1589)/5897

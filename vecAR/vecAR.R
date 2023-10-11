#Andrew Man
library(tseries)
library(vars) 
# 
# ##Import, clean, format data 
# #data between 1973-2021, quarterly
# rgdpDta =read.table("rgdp_newZealand_quarterly.csv",header=T,sep=",")
# rgdp=ts(rgdpDta[,2],start=1973,frequency=4)
# dlrgdp = 400*diff(log(rgdp))
# dlrgdp = window(dlrgdp,start= c(1987,2),end=c(2021,2))
# 
# #data between 1987-2021, monthly
# intDta=read.table("srIntRates_newZealand_monthly.csv",header=T,sep=',')
# srInt=ts(intDta[,2],frequency=12,start=c(1987, 12))
# srInt=aggregate(srInt,nfrequency=4, mean)
# srInt= window(srInt, start= c(1987,2),end=c(2021,2))

data.gdp=read.table("rgdp_newZealand_quarterly.csv",header=T,sep=",")
rgdp=ts(data.gdp[,2],start=c(1987,2),frequency=4) #[fix]

data.ff=read.table("srIntRates_newZealand_monthly.csv",header=T,sep=',')
ffrate=ts(data.ff[2:nrow(data.ff),2],frequency=12,start=c(1974, 1)) #[fix]
int=aggregate(ffrate,nfrequency=4,mean)
# compute quarterly real GDP growth rate
dlrgdp = 400*diff(log(rgdp))

# ensure data is of same length and COVID period is excluded
#rgdpGrowth = ts(window(dlrgdp,start= c(1987,2),end=c(2021,2),start=1987,frequency=4))
rgdpGrowth = window(dlrgdp,start= c(1987,2),end=c(2021,2))
srInt = window(int,start= c(1987,2),end=c(2021,2))

##plot data
dev.new()
plot(rgdpGrowth,col="black",lwd=2)
lines(srInt,col="blue",lwd=2)

#VAR analysis begins here
#bind data (pay attention to order)
bindedDta<-ts(cbind(rgdpGrowth,srInt))
bindedDta<-window(bindedDta, start=2, end=137)

#compute information criteria and select order of VAR
VARselect(bindedDta,lag.max=16,type="const") 

s#run VAR estimation and report summary
varModel = VAR(bindedDta,p=2)
summary(varModel)

#diagnostic: fit and residuals
#dev.new()
#plot(varModel) 

#Structural Impulse Response using Sims (1980) solution (Cholesky decomposition)
irf.y.int<-irf(varModel,ortho=TRUE,ci=0.95,runs=100,n.ahead=16)
plot(irf.y.int,lwd=2)

#####
###w/o covid data
rgdpGrowth = window(dlrgdp,start= c(1987,2),end=c(2020,1))
srInt = window(int,start= c(1987,2),end=c(2020,1))

##plot data
dev.new()
plot(rgdpGrowth,col="black",lwd=2)
lines(srInt,col="blue",lwd=2)

#VAR analysis begins here
#bind data (pay attention to order)
bindedDta<-ts(cbind(rgdpGrowth,srInt))
bindedDta<-window(bindedDta, start=2, end=137)

#compute information criteria and select order of VAR
VARselect(bindedDta,lag.max=16,type="const") 

#run VAR estimation and report summary
varModel = VAR(bindedDta,p=5)
summary(varModel)

#diagnostic: fit and residuals
#dev.new()
#plot(varModel) 

#Structural Impulse Response using Sims (1980) solution (Cholesky decomposition)
irf.y.int<-irf(varModel,ortho=TRUE,ci=0.95,runs=100,n.ahead=16)
plot(irf.y.int,lwd=2)


#####
###Robustness Check, lag 11
rgdpGrowth = window(dlrgdp,start= c(1987,2),end=c(2020,1))
srInt = window(int,start= c(1987,2),end=c(2020,1))

##plot data
dev.new()
plot(rgdpGrowth,col="black",lwd=2)
lines(srInt,col="blue",lwd=2)

#VAR analysis begins here
#bind data (pay attention to order)
bindedDta<-ts(cbind(rgdpGrowth,srInt))
bindedDta<-window(bindedDta, start=2, end=137)

#compute information criteria and select order of VAR
VARselect(bindedDta,lag.max=16,type="const") 

#run VAR estimation and report summary
varModel = VAR(bindedDta,p=2)
summary(varModel)

#diagnostic: fit and residuals
#dev.new()
#plot(varModel) 

#Structural Impulse Response using Sims (1980) solution (Cholesky decomposition)
irf.y.int<-irf(varModel,ortho=TRUE,ci=0.95,runs=100,n.ahead=16)
plot(irf.y.int,lwd=2)
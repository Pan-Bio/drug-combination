setwd('H:/POD/GCN-DNN-master/GCN-DNN-master/demo/data2/negative/data/novel/replicate')
library(data.table)
library(keras)
library(sigmoid)
#source('GCN.R') 
############st##################
netedge=read.table('1-sd_drugnet.txt')
X=as.matrix(read.table('1-sd_drugfeature46.txt'))
#10ge 



pnetedge=read.table('1-sd_proteinnet.txt')
pX=as.matrix(read.table('1-sd_proteinfeature.txt'))
#10ge

alldrug=read.table('1-sd_drugname.txt',stringsAsFactor=F)
allprotein=read.table('1-sd_proteinname.txt',stringsAsFactor=F)

alldrug<-alldrug$V1
allprotein<-allprotein$V1


need_drug<-read.table("uni-drug.txt",header=F)
needdrug<-need_drug$V1

need_target<-read.table("uni-target.txt",header=F)
needtarget<-need_target$V1




result_drug<-c()
for (element in needdrug){
  print(element)
  id1<-which(alldrug==element)
  print(id1)
  index3=apply(as.matrix(id1),1,function(x){which(netedge[x,]==1)})
  if (length(index3)!=0){
    result_drug<-c(result_drug,alldrug[index3])
  }
}

dd=as.data.frame(table(result_drug))
drugname=as.character(dd[which(dd[,2]>0),1])



result_drug=unique(c(drugname,needdrug))


result_target<-c()
for (element in needtarget){
  print(element)
  id1<-which(allprotein==element)
  print(id1)
  index3=apply(as.matrix(id1),1,function(x){which(pnetedge[x,]>0)})
  if (length(index3)!=0){
    result_target<-c(result_target,allprotein[index3])
  }
}

tt=as.data.frame(table(result_target))
targetname=as.character(tt[which(tt[,2]>=0),1])


result_target=unique(c(targetname,needtarget))
 



write.table(file='2-drug.txt',result_drug,row.names = FALSE,col.names = FALSE,quote = FALSE)
write.table(file='2-target.txt',result_target,row.names = FALSE,col.names = FALSE,quote = FALSE)


pt=read.table('2-demo-real.txt',stringsAsFactor=F)
pt<-pt$V2
a=as.data.frame(table(pt))


result_target<-c()
for (element in needtarget){
  print(element)
  id1<-which(allprotein==element)
  print(id1)
  index3=apply(as.matrix(id1),1,function(x){which(pnetedge[x,]>0)})
  if (length(index3)!=0){
    result_target<-c(result_target,allprotein[index3])
  }
}

library(tidyverse)

pt2 <- a  %>% filter(pt%in%result_target) 

targetname2=as.character(pt2[which(pt2[,2]>1),1])
result_target2=unique(c(targetname2,needtarget))

write.table(file='3-target.txt',result_target2,row.names = FALSE,col.names = FALSE,quote = FALSE)

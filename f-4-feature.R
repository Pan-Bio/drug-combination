setwd('H:/POD/GCN-DNN-master/GCN-DNN-master/demo/data2/negative/data/novel/replicate')
library(data.table)
library(keras)
library(sigmoid)
#source('GCN-xiugai.R') 
############st##################
#netedge=read.table('5-sd_drugnet.txt')
X=as.matrix(read.table('5-sd_drugfeature46.txt'))
#10ge



#pnetedge=read.table('5-sd_proteinnet.txt')
pX=as.matrix(read.table('5-sd_proteinfeature.txt'))
#10ge

#original=read.table('4-demo-real.txt',stringsAsFactor=F)
alldrug=read.table('5-sd_drugname.txt',stringsAsFactor=F)
allprotein=read.table('5-sd_proteinname.txt',stringsAsFactor=F)
#drug_index=apply(as.matrix(original[,1]),1,function(x){which(x==alldrug)})

X2<-as.data.frame(X)
X2$name<-alldrug$V1


pX2<-as.data.frame(pX)
pX2$name<-allprotein$V1

write.csv(X2,"5-drug-feature.csv")

write.csv(pX2,"5-protein-feature.csv")


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



need_drug<-read.table("uni-drug.txt",header=F)
needdrug<-need_drug$V1

need_target<-read.table("uni-target.txt",header=F)
needtarget<-need_target$V1






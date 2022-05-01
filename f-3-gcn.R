setwd('H:/POD/GCN-DNN-master/GCN-DNN-master/demo/data2/negative/data/replicate')
library(data.table)
library(keras)
library(sigmoid)
source('GCN-xiugai.R') 
############st##################
netedge=read.table('5-sd_drugnet.txt')
X=as.matrix(read.table('5-sd_drugfeature46.txt'))
#10ge



pnetedge=read.table('5-sd_proteinnet.txt')
pX=as.matrix(read.table('5-sd_proteinfeature.txt'))
#10ge

original=read.table('4-demo-real.txt',stringsAsFactor=F)
alldrug=read.table('5-sd_drugname.txt',stringsAsFactor=F)
allprotein=read.table('5-sd_proteinname.txt',stringsAsFactor=F)
drug_index=apply(as.matrix(original[,1]),1,function(x){which(x==alldrug)})

newdrug_index=setdiff(1:nrow(alldrug),drug_index)
newdrug=alldrug[newdrug_index,]




#jixu



label=matrix(0,nrow(alldrug),nrow(allprotein))

for (i in 1:nrow(alldrug)){
  index1=which(original[,1]==alldrug[i,1])
  index2=apply(as.matrix(original[index1,2]),1,function(x){which(allprotein==x)})
  label[i,index2]=1
}



allfeature=matrix(0,nrow(pX)*nrow(X),ncol(X)+ncol(pX))
for (i in 1:nrow(X)){
  for (j in 1:nrow(pX)){
    allfeature[((i-1)*nrow(pX)+j),]=c(pX[j,],X[i,])
  }
}



feature_gcn=GCN(netedge,pnetedge,label,allfeature) 
#zhenghe hou de tezheng  butaidong
write.table(file='5-drug_protein_pair_gcn_features.txt',feature_gcn,row.names = FALSE,col.names = FALSE,quote = FALSE)



label=as.vector(label)
label1=matrix(0,length(label),3)
for (i in 1:nrow(allprotein)){
  for (j in 1:nrow(alldrug)){
    label1[(i-1)*nrow(alldrug)+j,1]=alldrug[j,1]
    label1[(i-1)*nrow(alldrug)+j,2]=allprotein[i,1]
    label1[(i-1)*nrow(alldrug)+j,3]=label[(i-1)*nrow(alldrug)+j]
  }
}

write.table(file='5-drug_protein.txt',label1,row.names = FALSE,col.names = FALSE,quote = FALSE)


label2=as.vector(as.matrix(netedge))
label22=matrix(0,length(label2),3)
for (i in 1:nrow(netedge)){
  for (j in 1:nrow(netedge)){
    label22[(i-1)*nrow(netedge)+j,1]=alldrug[j,1]
    label22[(i-1)*nrow(netedge)+j,2]=alldrug[i,1]
    label22[(i-1)*nrow(netedge)+j,3]=label2[(i-1)*nrow(netedge)+j]
  }
}

write.table(file='5-drug_drug.txt',label22,row.names = FALSE,col.names = FALSE,quote = FALSE)



label3=as.vector(as.matrix(pnetedge))
label33=matrix(0,length(label3),3)
for (i in 1:nrow(pnetedge)){
  for (j in 1:nrow(pnetedge)){
    label33[(i-1)*nrow(pnetedge)+j,1]=allprotein[j,1]
    label33[(i-1)*nrow(pnetedge)+j,2]=allprotein[i,1]
    label33[(i-1)*nrow(pnetedge)+j,3]=label3[(i-1)*nrow(pnetedge)+j]
  }
}

write.table(file='5-protein_protein.txt',label33,row.names = FALSE,col.names = FALSE,quote = FALSE)






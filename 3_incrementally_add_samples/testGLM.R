myTable = data.frame(read.table("both_likelihoods.txt",header=T))
summary(glm( JC ~ GTR + round, family=Gamma, data=myTable ))

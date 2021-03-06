###1. Load csv file as a matrix in R
library(kmlShape)
args <- commandArgs(trailingOnly = TRUE)
print(args)

num <- as.integer(args[1])
infile_name <- args[2]
outfile_name <- args[3]
cluster_num <- 15
dat <- read.csv(infile_name)
mat <- as.matrix(dat)

###2. Extract WAR by time data from matrix
###Note: mat[, 3:3+(n-1)] should be used when using career_until_n_years.csv
wmat <- mat[, 3:(2+num)]
class(wmat) <- "numeric"
 
###3. Create clusterLondData from matrix
ld <- clusterLongData(wmat)
 
###4. Execute kml algorithm then get clustering result
###Note: 2nd argument to kml function determines how many clusters you use.
kmlShape(ld, cluster_num)
out <- getClusters(ld,cluster_num)
out_mat <- as.matrix(out)
colnames(out_mat) <- c("Cluster")
output <- cbind(cbind(mat[, 1:2],wmat), out_mat)



###5. Dump the result
write.csv(output, file=outfile_name, row.names=FALSE)

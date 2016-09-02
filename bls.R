ln.data <- read.table(
  "http://download.bls.gov/pub/time.series/ln/ln.data.1.AllData",
                      header = T, sep ="\t", strip.white = TRUE)
# exact information from a large file of unemployment

ln.data <- read.delim("ln.data.1.AllData",  header = T, sep ="\t",
                        strip.white = TRUE)
# period code: A: annula, M*: monthly, Q*: quaterly
levels(ln.data$period)
summary(ln.data$period)

ln.periods <- levels(ln.data$period)
ln.vals <- levels(ln.data$value)
A01 <- subset(ln.data, period=="A01" & as.numeric(value) >0)
# or a1 = A01[which(A01$year=2015),1:4]
a1 <- A01[,1:4]
# rm(A01)
d2015 <-subset(a1, a1$year==2015) 
LNU00018240 <- subset(a1, a1$series_id=="LNU00018240")

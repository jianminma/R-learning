# paste two vectors
labs <- paste(c("X", "Y"), 1:10, sep = '')
labs[1:3]

#A vector of character strings; add name attributes
fruit <- c(5, 10, 1, 20)
names(fruit) <- c("orange", "banana", "apple", "peach")
lunch <- fruit[c("apple","orange")]
lunch()
names(fruit) <-NULL # remove names

## exact subvector
x <- c(10,5, 4, 3.4, TRUE)
y <- x[x>4]
x[6] =NA
x[is.na(x)==NA]

# vector of length 0 
e = numeric()
e[3] =0 # set length  3

# select only even indices
alpha <- c(1:10)
alpha <- alpha[2 *1:5]

# factors of a vector and leval
state <- c("tas", "sa",  "qld", "nsw", "nsw", "nt",  "wa",  "wa",
           "qld", "vic", "nsw", "vic", "qld", "qld", "sa",  "tas",
           "sa",  "nt",  "wa",  "vic", "qld", "nsw", "nsw", "wa",
           "sa",  "act", "nsw", "vic", "vic", "act")

statef <- factor(state)
levels(statef)
# pair with state above
incomes <- c(60, 49, 40, 61, 64, 60, 59, 54, 62, 69, 70, 42, 56,
             61, 61, 61, 58, 51, 48, 65, 49, 49, 41, 48, 52, 46,
             59, 46, 58, 43)
#get the mean for each factor
incmeans <- tapply(incomes, statef, mean)
#get the frequency count
table(state)

# the following return the same result as able
tapply(statef, statef, length)



# matrices and array
ar <- array(1:3, 4:1)

# In the case of a doubly indexed array, an index matrix may be given 
# consisting of two columns and as many rows as desired. The entries in 
# the index matrix are the row and column indices for the doubly indexed 
# array. Suppose for example we have a 4 by 5 array X and we wish to do 
# the following: 
x <- array(1:20, dim=c(4,5))   # Generate a 4 by 5 array.
i <- array(c(1:3,3:1), dim=c(3,2))

# outer product
a <- array(1:6, 2:3)
b <- array(1:4,c(2,2))
c <-a %o% b

# working with list
Lst <- list(name="Fred", wife="Mary", no.children=3,
            child.ages=c(4,7,9))

# data frame : 
#   make a data frame: each column is a list of obs. values for a var
# each row is an obs
employee <- c('John Doe','Peter Gynn','Jolie Hope')
salary <- c(21000, 23400, 26800)
startdate <- as.Date(c('2010-11-1','2008-3-25','2007-3-14'))
employ.data <- data.frame(employee, salary, startdate)

# read data, more information see: 
# http://www.ats.ucla.edu/stat/r/modules/raw_data.htm
# comma separated values
dat.csv <- read.csv("http://www.ats.ucla.edu/stat/data/hsb2.csv")
# tab separated values
dat.tab <- read.table("http://www.ats.ucla.edu/stat/data/hsb2.txt",
                      header=TRUE, sep = "\t")
# these two steps only needed to read excel files from the internet
f <- tempfile("hsb2", fileext=".xls")
download.file("http://www.ats.ucla.edu/stat/data/hsb2.xls", f, mode="wb")
dat.xls <- read.xlsx(f, sheetIndex=1)

# complete data, space delimited, variable names in first row
(test <- read.table("http://www.ats.ucla.edu/stat/data/test.txt", header = TRUE))

# read from the console
x1 = scan() # numeric data
y <- scan(what=" ") # string data


# lapply - When you want to apply a function to each element 
# of a list in turn and get a list back.
ldapply(allSections, mean)


# working with dataset: mtcars
# structure of dataset
str(mtcars)
names(mtcars) # variables
dim(mtcars) # size of dataset
head(mtcars)
tail(mtcars)
row.names(mtcars) # row labels
row.names(mtcars) -> rlabels
# select several row 
subset(mtcars, am ==1) -> am1 # all rows with am ==1
# select two columns of am1
subset(mtcars, am ==1, select = c(mpg, cyl)) ->mpgcyl 
# select column from S to T
subset(mtcars, am ==1 , select = mpg:disp) ->mpg2disp
# which indices are TRUE
which(mtcars$am==1)
# remove a column/var
mpg2disp$disp <- NULL
#  row, column count
nrow(mpg2disp); ncol(mpg2disp)
# add the column back
mpg2disp$disp <- am1$disp
# select the first 5 five rows 
mtcars[1:5,]
# distribution of data
summary(mtcars)
# histogram 
hist(mtcars$mpg)


group <- gl(2, 10, 20, labels = c("Ctl","Trt"))

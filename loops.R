# loop structure
for (i in 1:20) print(i)

shoppingBasket <- c("apples", "bananas", "butter", "bread", "milk", 
                    "cheese")
for (item in shoppingBasket) 
  print(item)

cnt <- 0
while (cnt <5){
  cnt <- cnt +1
  print(cnt)
}

total <- 0
repeat {
    total <- total + 1
    print (total*10)
    if (total == 5)   break
}

# boolean operators
# negation: !
# element-wise AND: &
# first element AND: && 
# elelment-wise OR: |
# first elment OR : ||

# if condition
x <- -2
if (x <0){  print('negative number:' )}else { print('positive number')}

# problem in step through: should run region
x <- 2
if (x < 0){
  print("Negative number")
} else if (x > 0) {
  print("Positive number")
} else
  print("Zero")

a <- c(1:25)
ind <-0
for (i in c(1,2,3,5,9)) 
  for (j in c(1,2,3,5,9)){
     ind <- ind +1; a[ind]=i+j
  }
a

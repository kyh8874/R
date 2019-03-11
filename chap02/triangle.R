#
#삼각형 출력
#
#1.
cat("1.번\n")
for (i in 0:4) {
  for (j in 0:4) {
    if (i >=j)
      cat("*")
    else
       cat(" ")
  }
  cat("\n")
}

cat("2.번\n")

num=100
num2=200

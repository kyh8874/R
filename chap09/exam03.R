exam=read_csv('Data/csv_exam.csv')
qplot(math, data=exam, breaks=seq(0,100, by=10))
qplot(english, data=exam, breaks=seq(0,100, by=10))
qplot(science, data=exam, breaks=seq(0,100, by=10))



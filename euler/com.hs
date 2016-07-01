comb n r = (product [2..n]) `div` ((product [2..r])*(product [2..n-r]))

main = print (length [(n, r) | n<-[23..100], r<-[2..n-1], comb n r > 1000000])

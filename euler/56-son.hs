son 0 = 0
son x = x `mod` 10 + son (x `div` 10)

main = do print (maximum ([son (x^y)| x<-[2..99],y<-[90..97]]))

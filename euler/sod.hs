
msod 0 = 0
msod x = (x `mod` 10) + msod (x `div` 10)

sod 0 = 1
sod x = code (x `mod` 10) * sod (x `div` 10)

code 0 = 2
code 1 = 3
code 2 = 5
code 3 = 7
code 4 = 11
code 5 = 13
code 6 = 17
code 7 = 19
code 8 = 23
code 9 = 29
code x = 0

main = print (head [x|x<- [2..], sod (2*x) == sod (3*x) && sod (3*x) == sod (4*x) && sod (4*x) == sod (5*x) && sod (5*x) == sod (6*x)])

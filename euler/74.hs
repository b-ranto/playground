fact x = product [2..x]

next 0 = 0
next x = fact (mod x 10) + next (div x 10)

iter 169    = 3
iter 363601 = 3
iter 1454   = 3
iter 871    = 2
iter 45361  = 2
iter 872    = 2
iter 45362  = 2
iter x = if nx == x then 1 else 1 + iter nx where nx = next x

result = length (filter (((==) 60) . iter) [2..1000000])

main = print result

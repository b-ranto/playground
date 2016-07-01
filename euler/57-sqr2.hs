norm (a, b) = if b /= 1 then (a `div` gcd a b, b `div` gcd a b) else (a, b)

add (a,b) (c,d) = norm (a*d+b*c,b*d)

dv (a, b) (c, d) = (a*d, b*c)

expand' 0 = (2, 1)
expand' i = add (2, 1) (dv (1, 1) (expand' (i-1)))

expand i= add (1, 1) (dv (1,1) (expand' (i-1)))

numb 0 = 0
numb x = 1 + numb (x `div` 10)

num (a, b) = (numb a, numb b)

cnd (a, b) = a > b

main = do print (filter cnd (map num [expand x|x<-[8..1000]]))

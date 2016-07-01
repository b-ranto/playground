--primes = 2:tail primes where primes =
pcount = 10000
dcount = 10000

sz 0 = 1
sz x = 10 * sz (x `div` 10)
primes = sieve [2..]
   where
    sieve (p:xs) = p : sieve [x | x <- xs, rem x p /= 0]

divby x 0 n z w = (z, reverse w)
divby x y 0 z w = (0, [])
divby x y n z w = if n `mod` 10 == x then divby x (y-1) (n `div` 10) z (True:w) else divby x y (n `div` 10) z (False:w)

modby a b c = divby a b c c []

cpute x = map (modby x 3) (take pcount (drop dcount primes))

pp (0, []) (a, b) = (a, b)
pp (a, b) (c, d) = (a, b)
--pp a b = a 

mby 0 = cpute 0 
mby x = zipWith pp (cpute x) (mby (x-1))

uflt f x = filter (flip (/=) (0, [])) (f x)
flt = uflt mby

aflt = uflt cpute

--fltr = flt 9

--f3 = flt 2

uprav k n [] = n
uprav k n (x:z) = if x then k+10*(uprav k (n `div` 10) z) else (n `mod` 10) + 10*(uprav k (n `div` 10) z)

-- aleast k (x:z) n = 

isPrime n = (null [x |x<-[2..floor (sqrt (fromIntegral n))], n `mod` x == 0])

--aleast n 0 [] b = b
aleast (n, y) = (n, length [x|x<-[0..9], isPrime (uprav x n y)])

m6 (x, y) = y > 6

mflt x = filter m6 (map aleast (aflt x))

pr x = if isPrime x && isPrime (x*10+3) && isPrime (x*10+7) && isPrime (x*1000+109)&& isPrime (x+3*(sz x)) && isPrime (x+7*(sz x)) && isPrime (x + 109*(sz x)) && isPrime (x*1000+673) && isPrime (x+673*(sz x)) then x, else pr (x+2)

main = print (head [x|x<-[673,675..5000001], isPrime x, isPrime (x*10+3), isPrime (x*10+7), isPrime (x*1000+109), isPrime (x+3*(sz x)), isPrime (x+7*(sz x)), isPrime (x + 109*(sz x)), isPrime (x*1000+673), isPrime (x+673*(sz x))])
--	print "Hi"
--	mf
--	x0 <- aflt 0
--	x1 <- aflt 1
--	x2 <- aflt 2
--	print zipWith (pp) [x0] [x1]

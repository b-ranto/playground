natSqrt :: Integer -> Integer
natSqrt = floor . sqrt . fromIntegral

max' (a, b) (c, d) = if a*d > c*b then (a, b) else (c, d)

armax x = foldl max' (0, 1) x

phi :: Integer -> Integer
phi x = div (x * (product dx)) (product (map ((+) 1) dx)) where dx = divisors x

rphi n = length [x|x<-[1..(n-1)], gcd n x == 1]
divide n m = if mod n m == 0 then divide (div n m) m else n

divisors' 1 _ _ = []
divisors' n sqr (a:x) = if sqr < a then [n-1] else if mod n a == 0 then (a-1):(divisors' dn (natSqrt dn) x) else divisors' n sqr x where dn = divide n a
divisors n = divisors' n (natSqrt n) impPrimes

phis = [(y, x)|x<-[1000000..10000000],y<-[phi x], filter (((==) 0) . (mod x)) [2,3,5,7] == [], eq (count y) (count x)]

isPrime n = (filter (((==) 0) . (mod n)) [2..(natSqrt n)]) == []

impPrimes = filter (isPrime) [2..5162]

primes' x = if isPrime x then x:(primes' (x-1)) else primes' (x-1)

primes = primes' (10^7)

norm :: Integer -> [Integer]
norm 0 = []
norm x = (mod x 10):(norm (div x 10))

count'' :: Integer -> [Integer] -> Integer
count'' k [] = 0
count'' k (a:x) = if a == k then 1 + count'' k x else count'' k x

count' :: [Integer] -> [Integer]
count' x = map (flip count'' x) [0..9]

count = count' . norm

eq [] [] = True
eq (a:x) (b:y) = if a == b then eq x y else False

result = armax phis
main = print (sum (map phi [2..1000000]))

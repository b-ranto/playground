count' m 0 x = 0
count' m 1 _ = if m /= 0 then 1 else 0
count' m 2 x = if 2*m >= x then div (min (x+1) (m+1)) 2 else 0
count' m k x = sum (map help [1..(min m (x-k+1))]) where help z = count' (min m z) (k-1) (x-z)

count x = (map (flip (count' (x-1)) x) [2..x])
--count' 4 3 5
--count' 1 2 4

acount 3 k = length [(x,y,z)|x<-[1..(k-3+1)],y<-[1..(k-x+1)],z<-[100-x-y]]
--altCount 

-- lcm a b = a * (div b (gcd a b))
thenum = foldl lcm 1 [2..12000]

cnt x = (floor ((ratx-1)/2)) - (ceiling ((ratx+1)/3)) + 1 where ratx = fromIntegral x

phi :: Integer -> Integer
phi x = div (x * (product dx)) (product (map ((+) 1) dx)) where dx = divisors x

rphi n = length [x|x<-[1..(n-1)], gcd n x == 1]
divide n m = if mod n m == 0 then divide (div n m) m else n

divisors' 1 _ _ = []
divisors' n sqr (a:x) = if sqr < a then [n] else if mod n a == 0 then (a):(divisors' dn (natSqrt dn) x) else divisors' n sqr x where dn = divide n a
divisors n = divisors' n (natSqrt n) impPrimes

natSqrt :: Integer -> Integer
natSqrt = floor . sqrt . fromIntegral

isPrime n = (filter (((==) 0) . (mod n)) [2..(natSqrt n)]) == []

impPrimes = filter (isPrime) [2..5162]

coprime [] _    = True
coprime (a:x) k = if mod k a == 0 then False else coprime x k

cop3to2 k = if head divs == k then cnt k else (.) length (filter (coprime divs)) [(ceiling ((ratk+1)/3))..(floor ((ratk-1)/2))] where {divs = divisors k; ratk = fromIntegral k}

result = sum (map cop3to2 [5..12000])

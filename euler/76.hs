count' 0 _ = 0
count' 1 _ = 1
count' 2 x = (div ((x-1) + (divisible x 2)) 2)
count' k x = (count' dk dx) * (count' (k-dk) (x-dx)) where {dk = div k 2; dx = div x 2}
--count' k x = sum (map help [1..(x-k+1)]) where help z = count' (k-1) (x-z)

fact n = product [2..n]

divisible k n = if mod k n == 0 then 1 else 0

--count x = (map (flip (count') x) [2..x])

bfcount 5 k = length [(x,y,z,w,a)|x<-[1..(k-5+1)],y<-[1..(k-x-3)],z<-[1..(k-x-y-2)],w<-[1..(k-x-y-z-1)],a<-[k-x-y-z-w], x>=y, y>=z, z>=w, w>=a]
bfcount 4 k = length [(x,y,z,w)|x<-[1..(k-3)],y<-[1..(k-x-2)],z<-[1..(k-x-y-1)],w<-[k-x-y-z], x>=y, y>=z, z>=w, x + y + z + w == k]
bfcount 3 k = length [(x,y,z)|x<-[1..(k-3+1)],y<-[1..(k-x-1)],z<-[k-x-y], x >= y, y >= z]
bfcount 2 k = length [(x,y)|x<-[1..(k-2+1)],y<-[k-x], x>=y]

var k n = div (fact n) (fact (n-k))

comb k n = div (fact n) (fact k * fact (n-k))

remainder k n = sum [(div (n-x+1) x)*var x k|x<-[2..k-1]] 
--acount _ 0 = 0
--acount 3 x = div ((div ((x-1)*(x-2)) 2) + (div (x-1) 2)*3 + 2*(divisible x 3)) (fact 3)
--acount 2 x = (div ((x-1) + (divisible x 2)) 2)
acount k n = div (comb (k-1) (n-1) + remainder k n) (fact k) -- + ancilla, the "equal states"
--altCount 

count x = (map (flip acount x) [2..x])
result = sum (count 100)

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

--result = sum (map cop3to2 [5..12000])

isPrime n = (null [x |x<-[2..floor (sqrt (fromIntegral n))], n `mod` x == 0])

pr x = if isPrime x && isPrime (x*10+3) && isPrime (x*10+7) && isPrime (x*1000+109)&& isPrime (x+3*(sz x)) && isPrime (x+7*(sz x)) && isPrime (x + 109*(sz x)) && isPrime (x*1000+673) && isPrime (x+673*(sz x)) then x else pr (x+2)

sz 0 = 1
sz x = 10 * sz (x `div` 10)

isFollow' a [] = True
isFollow' a (x:z) = isPrime (a*(sz x)+x) && isPrime (x*(sz a)+a) && isFollow' a z

isFollow a x = isPrime a && isFollow' a x
followers x max = filter (flip isFollow x) [3,5..max]

tk f (x:z) = if f x then x:(tk f z) else []

f a b = if length a < length b then b else a
perm x y = foldr (f) (map (flip (:) y) x)
--dothestuff
--dothestuff = foldr (||) (map (flip (:) dothestuff (k-1)) (take 5 (followers x)))
main = do print (take 5 ([1..]))

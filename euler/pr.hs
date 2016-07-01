--hx (a:s) = map (a:) (perm s)

--perm (a:s) 0 = []
-- perm (a:s) c = hx (a:s) ++ap (a:) (perm s (c-1)) ++ map ((head s):) (perm ((head s):(a++(tail s)))) ++

delete a (b:s) = if a == b then s else b:(delete a s)

pm [] _ = [[]]
pm _ 0 = [[]]
pm xs c = [x:ys | x<-xs,ys <- pm xs (c - 1)]

rnm [] = 0
rnm (a:x) = a + 10*(nm x)

nm = rnm.reverse

isPrime n = (null [x |x<-[2..floor (sqrt (fromIntegral n))], n `mod` x == 0])

prm [] = [[]]
prm xs = [x:ys | x<-xs, ys <- prm (delete x xs)]

ePrime [] = True
ePrime (x:s) = isPrime x && ePrime s

iprime = filter (ePrime . (map nm) . prm) (pm [1,3,7,9] 5)

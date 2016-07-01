fact :: Integer -> Integer -- 1.6x s
fact n = foldl (*) 1 [2..n]

fact_lame 0 = 1 -- 1.2x s -- fastest
fact_lame n = n * fact (n-1)

fact_product n = product [1..n] -- 1.6x s

main = do
--	print "8^5 is "
--	print ((^) 8 5)
	print ((fact.(^5)) 8)

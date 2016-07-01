
isPrime n = (null [x |x<-[2..floor (sqrt (fromIntegral n))], n `mod` x == 0])

mp True = 1
mp False = 0

prim x = mp (isPrime x)

pr k [] x = 0
pr k (a:y) x = prim (a+2*x+k*8) + pr k y (x+1)
--prim (6+k*8) + prim (4+k*8) + prim (8+k*8)

mdf l [] x = []
mdf k (a:y) x = (a+2*x+k*8):(mdf k y (x+1))

iter x y k z = if (x*10) < y then k else iter (x + (pr k z 1)) (y+4) (k+1) (mdf k z 1)

main = do print (iter 3 5 1 [3, 5, 7, 9])

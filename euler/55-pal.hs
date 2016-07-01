rev' 0 y = y
rev' x y = rev' (x `div` 10) (10*y + (x `mod` 10))

rev x = rev' x 0

pal' x 0 = (False, x)
pal' x i = if x == rev x then (True, x) else pal' (x + rev x) (i-1)

pal x = pal' (x + rev x) 50

main = do print (length [x|x<-[1..9999], fst (pal x) /= True])

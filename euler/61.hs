-- test whether b is a successor/predecessor of a
isSucc :: ([Int], Int) -> (Int, Int) -> Bool
isSucc a b = snd a == fst b
-- isPred (a, b) (c, d) = a == d

-- Make one tuple out of two tuples
retuple :: ([a], a) -> (a, a) -> ([a], a)
retuple (a, b) (c, d) = (b:a, d)

--  Transform an array n*k to k*n
sumByParts [] [] = []
sumByParts (a:x) (b:y) = (a ++ b):(sumByParts x y)

-- Remove k-th member of the list
rmkr' :: Int -> [Int] -> [Int]
rmkr' 0 (a:x) = x
rmkr' k (a:x) = a:(rmkr' (k-1) x)

-- Remove array of the members
rmkr :: [Int] -> [Int] -> [Int]
rmkr [] y = y
rmkr (a:x) y = rmkr x (rmkr' a y)

-- Make tuple out of a 4 digit number
norm :: Int -> (Int, Int)
norm x = (x `div` 100, x `mod` 100)

n3 = [norm (x*(x+1) `div` 2) | x <- [45 .. 140]]
n4 = [norm (x*x) | x <- [32..99]]
n5 = [norm (x*(3*x-1) `div` 2) | x <- [26 .. 81]]
n6 = [norm (x*(2*x-1)) | x <- [23 .. 70]]
n7 = [norm (x*(5*x-3) `div` 2) | x <- [21 .. 63]]
n8 = [norm (x*(3*x-2)) | x <- [19 .. 58]]

-- n3 ++ n4 ... + n8 filtered for >9
n :: [[(Int, Int)]]
n = map (filter ((.) ((<) 9) fst)) [n3, n4, n5, n6, n7, n8]

-- repack
repack (a, b) = ([a], b)

narr = (.) map map repack n

-- Member <function> relative
ng a r f = map (retuple a) (filter (f a) r)

-- Member forward relative
nfwd r a = ng a r isSucc

-- Member backward relative
-- nbwd r a = ng a r isPred

-- Abstract forward relative (r), one level
nabsfwd r a = map (nfwd (n !! a)) (r)

-- Alternative approach (probably better)
unify2 l k = foldl (++) [] (nabsfwd (narr !! l) k)

unify2' l k j = foldl (++) [] (nabsfwd (unify2 l k) j)

unify2'' l k j i = foldl (++) [] (nabsfwd (unify2' l k j) i)

unify2''' l k j i h = foldl (++) [] (nabsfwd (unify2'' l k j i) h)

runify (a:[]) = narr !! a
runify (a:x)  = foldl (++) [] (nabsfwd (runify x) a)

-- (l, k, j, i, h) = foldl (++) [] (runify
-- Remove one element from a given array (if it is in the array)
rm' [] m = []
rm' (a:x) m = if a /= m then a:(rm' x m) else x

-- Remove given elements (b:y) from a given array
rm [] _ = []
rm a [] = a
rm x (b:y) = rm (rm' x b) y

-- All the permutations:
perm = [[0, a, b, c, d]| a<-[1..5], b<-(rm [1..5] [a]), c<-(rm [1..5] [a,b]), d<-(rm [1..5] [a,b,c])]

-- fcond (a:x) = 
-- rrun = map runify perm

rndf [] _ = False
rndf (a:x) (b1, b2) = if (fst a) == b2 && (b1 !! 4) == (snd a) then True else rndf x (b1, b2)

run l k j i h = filter (rndf (n !! ((.) head (rm [0..5]) [l,k,j,i,h]))) ((unify2''' l k j i h))

realrun = filter (((/=) []) . fst) [(run 0 a b c d, (a, b, c, d))|a<-[1..5], b<-(rm [1..5] [a]), c<-(rm [1..5] [a,b]), d<-(rm [1..5] [a,b,c])]
--k<-[0..4],j<-[0..3],i<-[0..2],h<-[0,1]]

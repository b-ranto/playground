norm :: Int -> [Int]
norm 0 = []
norm x = (mod x 10):(norm (div x 10))

count' :: Int -> [Int] -> Int
count' k [] = 0
count' k (a:x) = if a == k then 1 + count' k x else count' k x

count :: [Int] -> [Int]
count x = map (flip count' x) [0..9]

-- n :: [Int]
-- n = map ((.) reverse norm) [x^3|x<-[216..464]]
n = map ((.) reverse norm) [x^3|x<-[4642..9999]]

fByCount :: [Int] -> [Int] -> Bool
fByCount y x = eq (count x) y

m = map count n

lt (a:[]) (b:[]) = a < b
lt (a:x) (b:y) = if a == b then lt x y else a < b

gt (a:[]) (b:[]) = a >= b
gt (a:x) (b:y) = if a == b then gt x y else a > b

eq [] [] = True
eq (a:x) (b:y) = if a == b then eq x y else False

qsort [] = []
qsort (a:[]) = [a]
qsort (a:x) = (qsort (filter (gt a) x)) ++ [a] ++ (qsort (filter (lt a) x))

o = map ((,) 1) (qsort m)

reduce [] = []
reduce (a:[]) = [a]
reduce (a:x) = if (snd a) == ((.) snd head x) then reduce ((fst a + 1, snd a):(tail x)) else a:(reduce x)

find k = filter ((.) (flip (>) k) fst) (reduce o)

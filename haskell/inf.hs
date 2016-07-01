(+*)	:: Num a => a -> a -> a -> a
(+*) x y z = x+y*z

multadd	:: Num a => a -> a -> a -> a
multadd x y z = x+y*z

switch	:: a -> (a -> b) -> b
switch x y = y x

apply x y = (x y)

--zipWith switch [7,8,9] (zipWith (multadd) [1,2,3] [4,5,6])

zipW3 :: (a -> b -> c -> d) -> [a] -> [b] -> [c] -> [d]
zipW3 f x y z = zipId (zipWith f x y) z

my_zip :: [a -> b] -> [a] -> [b]
my_zip [] [] = []
my_zip (x:t) (y:v) = (x y):(my_zip t v)

zipId = zipWith apply

--                       PROJECT INFINITY                        --
--                                                               --
--foldl (zipWith identity) (map multadd [1,2,3]) [[4,5,6], [7,8,9]]
main = foldl (zipId) (zipWith (+*) [1,2,3] [4,5,6]) [[7,8,9]] --Infinite type??
-- Fuck the infinite type
-- my_fold :: (a  -> b -> c) -> [d] -> [[e]] -> [f]
-- my_fold f x [] = (map f x) 
-- my_fold f x (y:t) = my_fold f (my_zip (x) y) t 
-- main = print (zipW3 multadd [1,2,3,4,5] [6,7,8,9,10] [11,12,13,14,15])
--                                                               --
--                       PROJECT INFINITY                        --


import Data.List
import Impdat

royal x = map fst x == [10, 11, 12, 13, 14] && null (filter (/= (ff !! 1)) ff) where ff = map snd x

straight y = null(filter (/=1) (zipWith (-) (tail x) x)) where x = map fst y

flush x = null (filter (/= (ff !! 0)) ff) where ff = map snd x

st x = sort (take 5 x) ++ sort (drop 5 x)
--cmp' h1 h2 = 

mp x n = (n, length (filter (== n) x))

cnt y = map (mp x) x where x = map fst y

unique [] = []
unique (a:x) = a:(unique (filter (/= a) x))

four x = length x == 2 && snd (head x) `mod` 3 == 1

fhouse x = length x == 2 && snd (head x) `div` 2 == 1

flt1 x = [a|(a, b)<-x, b /= 1]
--filter (/= 1) (map snd x)

unflt1 x = [a|(a, b)<-x, b == 1]
--filter (==1) (map snd x)

three x = length x == 3 && length (flt1 x) == 1

twopair x = length x == 3 && length (flt1 x) == 2

pair x = length x == 4

highest x = head (reverse (map snd x))

f5 = take 5
l5 = drop 5

--f5u = f5 . unify
--l5u = l5 . unify

same (a:x) n = if a /= n then 0 else 1+ (same x n)

apply x = unique (cnt (take 5 x))

unify x = unique (cnt x)

highCard [] [] = 0
highCard [] _ = -1
highCard _ [] = -1
highCard (a:x) (b:y) = if a>b then 1 else if b > a then 2 else highCard x y

--func = [royal, straight, four, fhouse, flush, straight, three, twopair, pair]

--fs :: [a -> b]
--fs = [royal, straight, four . unify, fhouse . unify, flush, straight, three . unify, twopair . unify, pair . unify]

round f x = if f (f5 x) && f (l5 x) then highCard ((reverse (flt1 (f5u x))) ++ (reverse (unflt1 (f5u x)))) ((reverse (flt1 (l5u x))) ++ (reverse (unflt1 (l5u x)))) else if f (f5 x) then 1 else if f (l5 x) then 2 else -1 where {f5u = unify . f5; l5u = unify . l5}

use [] x = highCard (reverse (f5 x)) (reverse (l5 x))
use (a:y) x = if Main.round a x /= -1 then Main.round a x else use y x

main = do 
	print (let ff x = straight (take 5 x)  in filter ff dt)
	print (map apply dt)

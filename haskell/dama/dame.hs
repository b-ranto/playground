import Data.List

dameSize :: Int
dameSize = 12

fitWith :: Num t => (t, t) -> (t, t) -> Bool
fitWith (a, b) (x, y) = x /= a && y /= b && x - y /= a - b && x + y /= a + b

my_head :: [[a]] -> [a]
my_head [] = []
my_head (x:_) = x

output :: [(Int, Int)] -> IO ()
output [] = putStrLn "Done"
output ((_, y) : s) = do
	putStr (foldl (++) "" (replicate (y - 1) "x "))
	putStr "o "
	putStr (foldl (++) "" (replicate (dameSize - y) "x "))
	putStr "\n"
	output s

outList :: [[(Int, Int)]] -> IO ()
outList [] = putStr ""
outList (x:s) = do
	output (reverse x)
	outList s

-- returns just first dame, uses "permutations" -> complexity O(n!)
damePerm :: [Int] -> [[Int]]
damePerm (s) = permutations s

-- returns all dames that exists, complexity O(n^n)
dameAll :: [(Int, Int)] -> Int -> [[(Int, Int)]]
dameAll x level = if level == (dameSize + 1)
		then [x]
	else if m == []
		then []
	else foldl (++) [] (filter (/= []) (map ((flip dameAll (level + 1)).(flip (:) x)) m) )
	where m = [(level, a)| a<-[1..dameSize], all (fitWith (level, a)) x]
-- perm x = map (map (:) perm s) z where {z<-x; s<-([1..x-1] ++ [x+1..8])}

-- return just first dame, complexity O(n^n)
dame :: [(Int, Int)] -> Int -> [(Int, Int)]
dame x level = if level == (dameSize + 1)
		then x
	else if m == []
		then []
	else my_head (filter (/= []) (map ((flip dame (level + 1)).(flip (:) x)) m) )
	where m = [(level, a)| a<-[1..dameSize], all (fitWith (level, a)) x]

computeDame :: [[(Int, Int)]]
computeDame = dameAll [] 1

main :: IO ()
main = do
--	print (last (permutations [1..15]))
--	print computeDame
--	print (length computeDame)
	outList computeDame
--	print ((reverse.(dame [])) 1)
--	output (reverse (dame [] 1))

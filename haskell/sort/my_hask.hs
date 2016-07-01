import Data.Char
import qualified Data.ByteString.Char8 as Bs

-- RESULTS
-- ./my_hask < toSort  55,40s user 0,42s system 98% cpu 56,735 total -- using qsort

capitalize :: Bs.ByteString -> Bs.ByteString
capitalize = Bs.map toUpper
--capitalize = id

connect_left :: a -> ([a], [a]) -> ([a], [a])
connect_left x (u,v) = (x:u, v)

connect_right :: a -> ([a], [a]) -> ([a], [a])
connect_right x (u, v) = (u, x:v)

sp_filter :: Ord a => a -> [(a, a)] -> ([(a, a)], [(a, a)])
sp_filter _ [] = ([], [])
sp_filter w ((x, y):s) = if x <= w then connect_left (x, y) (sp_filter w s) else connect_right (x, y) (sp_filter w s)

qsort :: [(Bs.ByteString, Bs.ByteString)] -> [(Bs.ByteString, Bs.ByteString)]
qsort [] = []
qsort ((x, y):s) = ( qsort u ) ++ ((x, y):( qsort v )) where (u, v) = sp_filter x s

--mergeSort :: [Bs.ByteString] -> [Bs.ByteString]
--mergeSort [] = []
--mergeSort [x] = [x]
--mergeSort s = merge (mergeSort (take l s)) (mergeSort (drop l s)) where l = ((length s) `div` 2)

--merge :: [Bs.ByteString] -> [Bs.ByteString] -> [Bs.ByteString]
--merge s [] = s
--merge [] t = t
--merge (x:s) (y:t) = if (x) <= (y) then x:(merge s (y:t)) else y:(merge (x:s) t)

my_print :: [(Bs.ByteString, Bs.ByteString)] -> IO ()
my_print [] = putChar '\n'
my_print ((_, x):t) =
	do
	Bs.putStrLn x
	my_print t

create_pair :: Bs.ByteString -> (Bs.ByteString, Bs.ByteString)
create_pair x = (capitalize x, x)

getData :: IO [(Bs.ByteString, Bs.ByteString)]
getData = do
	vstup <- Bs.getContents
	return (map create_pair (Bs.lines vstup))

main :: IO ()
main = do
	putStrLn "Loading Data"
	myData <- getData
	putStrLn "Data loaded"
--	my_print (qsort myData)
--	print (last (qsort myData))
--	putStrLn "Mergesort-ing"
--	my_print (mergeSort myData)
	putStrLn "Quicksort-ing"
	my_print (qsort myData)
	putStrLn "Done"

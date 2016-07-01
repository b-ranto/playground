import Data.Char
import qualified Data.ByteString.Char8 as Bs

-- RESULTS

-- 20 000 items,	quicksort,	String
-- ./my_hask < toSort  55,40s user 0,42s system 98% cpu 56,735 total

-- 20 000 items,	mergeSort,	String
-- ./my_hask < tS  54,19s user 0,42s system 98% cpu 55,246 total

-- 300000 items,	quicksort,	ByteString
-- ./Main  5,46s user 1,16s system 70% cpu 9,392 total

-- 300000 items,	mergeSort,	ByteString
-- ./Main  5,49s user 0,90s system 84% cpu 7,577 total

-- 300000 items,	mergeSort,	ByteString, limited output, -O2
-- ./Main  2,89s user 0,07s system 100% cpu 2,962 total

capitalize :: Bs.ByteString -> Bs.ByteString
capitalize = Bs.map toUpper
--capitalize = id

qsort :: [Bs.ByteString] -> [Bs.ByteString]
qsort [] = []
-- qsort (x:s) = ( qsort ( filter ((<= capX).capitalize) s ) ) ++ [x] ++ ( qsort ( filter (( > capX).capitalize)  s) ) where capX = capitalize x
qsort (x:s) = ( qsort ( filter (<= x) s ) ) ++ [x] ++ ( qsort ( filter ( > x) s) )

mergeSort :: [Bs.ByteString] -> [Bs.ByteString]
mergeSort [] = []
mergeSort [x] = [x]
mergeSort s = merge (mergeSort (take l s)) (mergeSort (drop l s)) where l = ((length s) `div` 2)

merge :: [Bs.ByteString] -> [Bs.ByteString] -> [Bs.ByteString]
merge s [] = s
merge [] t = t
-- merge (x:s) (y:t) = if (capitalize x) <= (capitalize y) then x:(merge s (y:t)) else y:(merge (x:s) t)
merge (x:s) (y:t) = if x <= y then x:(merge s (y:t)) else y:(merge (x:s) t)

my_print :: [Bs.ByteString] -> IO ()
my_print [] = putChar '\n'
my_print (s:t) =
	do
	Bs.putStrLn s
	my_print t

getData :: IO [Bs.ByteString]
getData = do
	vstup <- Bs.readFile "toSort"
	return (Bs.splitWith (=='\n') vstup)
--	vstup <- Bs.getLine
--	if vstup == ""
--		then return []
--		else do l <- getData
--			return (l ++ [vstup])

main :: IO ()
main = do
	putStrLn "Loading Data"
	myData <- getData
	putStrLn "Data loaded"
--	my_print (qsort myData)
	my_print (mergeSort myData)
	putStrLn "Done"

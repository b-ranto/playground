import Data.Char

-- RESULTS
-- ./my_hask < toSort  55,40s user 0,42s system 98% cpu 56,735 total -- using qsort

capitalize :: String -> String
--capitalize = map toUpper
capitalize = id
qsort :: [String] -> [String]
qsort [] = []
qsort (x:s) = ( qsort ( filter ( (<= capX ).capitalize) s ) ) ++ [x] ++ ( qsort ( filter (( > capX).capitalize )  s) ) where capX = capitalize x

mergeSort :: [String] -> [String]
mergeSort [] = []
mergeSort [x] = [x]
mergeSort s = merge (mergeSort (take l s)) (mergeSort (drop l s)) where l = ((length s) `div` 2)

merge :: [String] -> [String] -> [String]
merge s [] = s
merge [] t = t
merge (x:s) (y:t) = if (capitalize x) <= (capitalize y) then x:(merge s (y:t)) else y:(merge (x:s) t)

my_print :: [String] -> IO ()
my_print [] = putChar '\n'
my_print (s:t) =
	do
	putStrLn s
	my_print t

getData :: IO [String]
getData = do
	vstup <- getLine
	if vstup == ""
		then return []
		else do l <- getData
			return (l ++ [vstup])

main :: IO ()
main = do
	putStrLn "Loading Data"
	myData <- getData
	putStrLn "Data loaded"
--	my_print (qsort myData)
	my_print (mergeSort myData)
	putStrLn "Done"

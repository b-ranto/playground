import Data.List
import Data.Time.Clock.POSIX

translate :: Integer -> Integer
translate 7 = 11
translate 6 = 4
translate 5 = 3
translate 4 = 2
translate x = x + 7

-- qrp - quite random prime
qrp :: Integer
qrp = 34511

bbsGen :: Integer -> Integer -> [Integer] -> [Integer]
bbsGen _ 0 [] = []
bbsGen i r s = (genericIndex s (i `mod` r)):(bbsGen (i^2 `mod` qrp) (r-1) ((genericTake (i `mod` r) s) ++ (genericDrop (i `mod` r + 1) s)))

generateData :: Integer -> [Integer]
generateData i = map (translate.(flip mod 8)) (bbsGen i 32 [0..31])

-- my_head returns 4 if one of the players have no cards in his hands
myHead :: [Char] -> Char
myHead [] = ' '
myHead (x:_) = x

deal s 0 = []
deal (x:s) n = [x]:(deal s (n-1))

getCards a (x:s) = do
	putStr "Your Cards: "
	print a
	print "Another card?"
	inp <- getLine
	if (myHead inp) == 'y' then
		getCards (x:a) s
		else if  (myHead inp) == 'n' then
			return a
		else getCards a (x:s)

play [] r = return []
play (x:s) r = do
	i <- getCards x r
	j <- play s (drop (length i - 1) r)
	return (i : j)

main :: IO ()
main = do
	input <- getPOSIXTime
--	print (generateData (ceiling input))
	x <- play (deal (generateData (ceiling input)) 2) (drop 2 (generateData (ceiling input)))
	print (map sum x)

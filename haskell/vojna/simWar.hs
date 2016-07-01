import Data.List
import Data.Time.Clock.POSIX

-- qrp - quite random prime
qrp :: Integer
qrp = 34511

bbs_gen :: Integer -> Integer -> [Integer] -> [Integer]
bbs_gen _ 0 [] = []
bbs_gen i r s = (genericIndex s (i `mod` r)):(bbs_gen (i^2 `mod` qrp) (r-1) ((genericTake (i `mod` r) s) ++ (genericDrop (i `mod` r + 1) s)))

generate_data :: Integer -> ([Integer], [Integer])
generate_data i = splitAt 16 (map (flip mod 8) (bbs_gen i 32 [0..31]))

-- my_head returns 4 if one of the players have no cards in his hands
my_head :: [Integer] -> Integer
my_head [] = 4
my_head (x:_) = x

-- war s t w where 
-- s is first set of cards
-- t is second set of cards
-- w are the cards that are in stake when war is called recursively
war :: [Integer] -> [Integer] -> [Integer] -> ([Integer], [Integer])
war [] [] _ = ([], [])
war s t w = if (my_head (drop 2 s)) > (my_head (drop 2 t))
	then
		(s ++ w ++ take 3 t, drop 3 t)
	else if (my_head (drop 2 s)) < (my_head (drop 2 t))
		then
			(drop 3 s, t ++ w ++ take 3 s)
		else
			war (drop 3 s) (drop 3 t) (take 3 s ++ take 3 t)

simWar :: [Integer] -> [Integer] -> Integer
simWar [] [] = 0
simWar _ [] = 1
simWar [] _ = 2
simWar (x:s) (y:t) = if x `mod` 8 > y `mod` 8
	then
		simWar (s ++ [x,y]) t
	else if x `mod` 8 < y `mod` 8
		then
			simWar s (t ++ [x,y])
		else
			uncurry (simWar) (war s t [])

play :: Integer -> Integer
play i = uncurry simWar (generate_data i)

main :: IO ()
main = do
	input <- getPOSIXTime
	print (ceiling (input * 1000))
--	input <- getLine
	if (play (ceiling (input * 1000))) == 0 then
--	if (play (read input)) == 0 then
		putStrLn "Draw."
		else do
			putStr "And the winner is Player "
			print (play (ceiling (input * 1000)))
--			print (play (read input))

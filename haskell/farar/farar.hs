import Data.List
-- import "imp.hs"
-- import Data.Time.Clock.POSIX

translate :: Integer -> String
translate n = (card (n `mod` 8)) ++ (color (n `div` 8))

card :: Integer -> String
card 0 = "Sedem - "
card 1 = "Osem  - "
card 2 = "Devat - "
card 3 = "Desat - "
card 4 = "Dolok - "
card 5 = "Horok - "
card 6 = "Kral  - "
card 7 = "Eso   - "
card _ = "No id - "

color :: Integer -> String
color 0 = "Cerven"
color 1 = "Zelen "
color 2 = "Zalud "
color 3 = "Gula  "
color _ = "Blank "

-- qrp - quite random prime :)
qrp :: Integer
qrp = 34511

bbsGen :: Integer -> Integer -> [Integer] -> [Integer]
bbsGen _ 0 [] = []
bbsGen i r s = (genericIndex s (i `mod` r)):(bbsGen (i*i `mod` qrp) (r-1) ((genericTake (i `mod` r) s) ++ (genericDrop (i `mod` r + 1) s)))

-- generate_data :: Integer -> ([Integer], [Integer], [Integer])
generateData :: Integer -> ([String], [String], [String])
generateData i = (take 5 pack, take 5 (drop 5 pack), drop 10 pack) where pack = map translate (bbsGen i 32 [0..31])

subtracts :: Integral a => a -> [b] -> [b]
subtracts n s = (genericTake (n-1) s) ++ (genericDrop n s)

update :: [a] -> String -> [a]
update a inp = (foldl (flip subtracts) a (map readInt (words inp)))

empty :: String -> Bool
empty s = length (words s) == 0

printRequest :: String -> [String] -> IO ()
printRequest t a = do
	putStr "This card is on top: "
	putStrLn t
	putStr "Choose your card: "
	print a

readInt :: String -> Integer
readInt s = read s

newTop :: [a] -> String -> a
newTop s i = genericIndex s (readInt (last (words i)) - 1)

play :: [String] -> [String] -> [String] -> Int -> String -> IO ()
play [] _ _ _ _ = putStrLn "Player 1 wins."
play _ [] _ _ _ = putStrLn "Player 2 wins."
play a b r 1 t = do
	printRequest t a
	input <- getLine
	if empty input then play ((head r):a) b (tail r) 2 t
		else play (update a input) b r 2 (newTop a input)
play a b r 2 t = do
	printRequest t b
	input <- getLine
	if empty input then play a ((head r):b) (tail r) 1 t
		else play a (update b input) r 1 (newTop b input)
play _ _ _ _ _ = putStrLn "Wrong input."

haveFun :: Integer -> IO ()
haveFun i = play x y (tail z) 1 (head z) where (x, y, z) = generateData i

main :: IO ()
main = haveFun 45

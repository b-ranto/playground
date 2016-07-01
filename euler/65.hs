-- Reverse ->  Int1/(sqrt(k) - Int2)
-- Sqrt    -> (Int1* sqrt(k) + Int2) / Int3
data Sroot = Reverse Integer Integer | Sqrt Integer Integer Integer | Extracted Integer Sroot |Fextracted Integer

sqrtToReverse :: Integer -> Sroot -> Sroot
sqrtToReverse a0 (Sqrt a b c) = Reverse c (-1*(b - (ep a0 (Sqrt a b c))*c))

reverseToSqrt :: Integer -> Sroot -> Sroot
reverseToSqrt k (Reverse a b) = Sqrt a (b*a) (k - b*b)

simplify      :: Sroot -> Sroot -- Sqrt -> Sqrt
simplify (Sqrt a b c) = Sqrt 1 (div b a) (div c a)

ep            :: Integer -> Sroot -> Integer
ep a0 (Sqrt a b c) = div (b + a0) c

natSqrt :: Integer -> Integer
natSqrt = floor . sqrt . fromIntegral

-- start :: Integer -> Sroot
start n = Reverse 1 (natSqrt n)

worker :: Integer -> Integer -> Integer -> Sroot -> Sroot
worker 0 a0 k s = Extracted (ep a0 (tmpf a0 k s)) (sqrtToReverse a0 (tmpf a0 k s)) where tmpf a0 k = (simplify . (reverseToSqrt k))
worker c a0 k s = Extracted (ep a0 (tmpf a0 k s)) (worker (c-1) a0 k (sqrtToReverse a0 (tmpf a0 k s))) where tmpf a0 k = (simplify . (reverseToSqrt k))

iWorker fp c a0 k s = if c > 0 && fp == (iter a0 k s) then c else iWorker fp (c+1) a0 k (iter a0 k s) where { tmpf a0 k = (simplify . (reverseToSqrt k)) ; iter a0 k s = (sqrtToReverse a0 (tmpf a0 k s))}

-- begin :: Integer -> Sroot
begin n c = Extracted (natSqrt n) ((worker c (natSqrt n) n) (start n))

lst (Extracted a b) = lst b
lst a = a

ibegin n = iWorker (lst (begin n 0)) 0 (natSqrt n) n (start n)

result = length (filter odd (map ibegin [x|x<-[1..10000], (natSqrt x)^2 /= x]))

tke 0 _ = (Sqrt 0 0 0)
tke k (Extracted a b) = Extracted a (tke (k - 1) b)

eq :: Sroot -> Sroot -> Bool
eq (Reverse a b) (Reverse c d) = a == c && b == d
eq (Sqrt a b c) (Sqrt d e f) = a == d && b == e && c == f
eq (Extracted a b) (Extracted c d) = a == c && eq b d
eq _  _ = False

instance Eq Sroot where
  (==) = eq

instance Show Sroot where
  show (Reverse a b) = (show a) ++ " / (sqrt(k) - " ++ (show b) ++ ")"
  show (Sqrt a b c)  = "(" ++ (show a) ++ " * sqrt(k) + " ++ (show b) ++ ") / " ++ (show c)
  show (Extracted a b) = "a = " ++ (show a) ++ "; " ++ show b


e' x = Extracted 1 (Extracted x (Extracted 1 (e' (2+x))))

e = Extracted 2 (e' 2)

regcd (a, b) = (div a g, div b g) where g = gcd a b

repack :: Sroot -> (Integer, Integer)
repack (Extracted a (Sqrt _ _ _)) = (a, 1)
repack (Extracted a (Reverse _ _)) = (a, 1)
repack (Extracted a b) = regcd (a*(fst tval) + (snd tval), fst tval) where tval = repack b

countDig 0 = 0
countDig x = (mod x 10) + countDig (div x 10)

isSquare x = (natSqrt x)^2 == x

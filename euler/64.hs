k :: Int
k = 23
a0 = 4
-- Reverse ->  Int1/(sqrt(k) - Int2)
-- Sqrt    -> (Int1* sqrt(k) + Int2) / Int3
data Sroot = Reverse Int Int | Sqrt Int Int Int | Extracted Int Sroot |Fextracted Int

sqrtToReverse :: Int -> Sroot -> Sroot
sqrtToReverse a0 (Sqrt a b c) = Reverse c (-1*(b - (ep a0 (Sqrt a b c))*c))

reverseToSqrt :: Int -> Sroot -> Sroot
reverseToSqrt k (Reverse a b) = Sqrt a (b*a) (k - b*b)

simplify      :: Sroot -> Sroot -- Sqrt -> Sqrt
simplify (Sqrt a b c) = Sqrt 1 (div b a) (div c a)

ep            :: Int -> Sroot -> Int
ep a0 (Sqrt a b c) = div (b + a0) c

natSqrt :: Int -> Int
natSqrt = floor . sqrt . fromIntegral

-- start :: Int -> Sroot
start n = Reverse 1 (natSqrt n)

worker :: Int -> Int -> Int -> Sroot -> Sroot
worker 0 a0 k s = Extracted (ep a0 (tmpf a0 k s)) (sqrtToReverse a0 (tmpf a0 k s)) where tmpf a0 k = (simplify . (reverseToSqrt k))
worker c a0 k s = Extracted (ep a0 (tmpf a0 k s)) (worker (c-1) a0 k (sqrtToReverse a0 (tmpf a0 k s))) where tmpf a0 k = (simplify . (reverseToSqrt k))

iWorker fp c a0 k s = if c > 0 && fp == (iter a0 k s) then c else iWorker fp (c+1) a0 k (iter a0 k s) where { tmpf a0 k = (simplify . (reverseToSqrt k)) ; iter a0 k s = (sqrtToReverse a0 (tmpf a0 k s))}

-- begin :: Int -> Sroot
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

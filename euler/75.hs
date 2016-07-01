import Data.List
import GHC.Exts
import qualified Data.IntMap as I
import Control.Monad

natSqrt :: Integer -> Integer
natSqrt = floor . sqrt . fromIntegral

triples = [(a, b, c)|m<-[1..375000],n<-[1..(min m (div 375000 m + 1))], mod (m-n) 2 == 1, gcd m n == 1,a<-[m^2 - n^2], b<-[2*m*n], c<-[m^2+n^2],a + b + c < 1500000]

trisum :: Integral a => (a, a, a) -> a
trisum (a, b, c) = a + b + c

divisible :: Integer -> Integer -> Bool
divisible x n = mod x n == 0

sortedLengths = sort (map trisum triples)

findDupla' :: [(Integer, Integer, Integer)] -> Integer -> (Integer, Integer, Integer)
findDupla' [] p = (-1, -1, -1)
findDupla' (a:x) p = if ta == p then a else findDupla' x ta where ta = trisum a
findDupla (a:x) = findDupla' x (trisum a)

uniq' [] _ = []
uniq' (a:x) p = if ta == p then uniq' x p else ta:(uniq' x ta) where ta = a
uniq (a:x) = ta:(uniq' x (ta)) where ta = a

lt5m = uniq (filter (((>=) 750000)) sortedLengths)

isPrime x = (filter (divisible x) [2..(natSqrt x)]) == []

iMap = I.fromList (map (flip (,) 1) sortedLengths)

collapse im (a:[]) = I.insertWith (+) a 1 im
collapse im (a:x) = I.insertWith (+) a 1 (collapse im x)

superArray = (foldl (collapse) iMap [[k*x|k<-[2..(div 1500000 x)]] | x<-lt5m])

main = do
	print (I.size (I.filter ((==) 1) superArray))

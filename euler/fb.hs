suma :: Integer -> Integer
suma 2 = 0
suma n = suma (n-1) + if ( n `mod` 3 == 0 || n `mod` 5 == 0)
		then n
		else 0
fibs :: Integer -> Integer
fibs p = if p < 400000
	then fibs ( ( round (p*(1 + sqrt 5)) ) `div` 2)
	else 0
	+
	if p `mod` 2 == 0
	then p
	else 0

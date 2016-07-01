vectnas [] [] = 0
vectnas (x:s) (y:t) = x*y + (vectnas s t)

nx [] = []
nx (a:y) = (a:[]):(nx y)

transpon [] = []
transpon (x:[]) = nx x
transpon (x:s) = zipWith (:) x (transpon s)

mvect x [] = []
mvect x (y:t) = (vectnas x y):(mvect x t)

matnas [] t = []
matnas (x:s) t = (mvect x t):(matnas s t)

--zipWith vectnas x (transpon y)

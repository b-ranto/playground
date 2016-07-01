data Msc = Prvy | Druhy | Treti

data F = Complete Float Int String

-- data Either a b c = A a | B b | C c

data Either3 a b c = A a | B b | C c

(-.) :: F -> Msc -> Either3 Float Int String
(-.) (Complete a b c) Prvy = A a
(-.) (Complete a b c) Druhy = B b
(-.) (Complete a b c) Treti = C c

-- zjedotenie na zoradenych mnozinach(vysledkom je opat zoradena mnozina
unite :: Ord a => [a] -> [a] -> [a]
unite [] [] = []
unite a [] = a
unite [] b = b
unite (x:a) (y:b) = if x == y then x:(unite a b)
                          else if x < y then x:(unite a (y:b))
                                        else y:(unite (x:a) b)

elif = else if

func = if 1 == 0 then 0
       elif 1 == 1 then 1
                   else 

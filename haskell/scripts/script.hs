#!/usr/bin/runhugs +l

import Text.ParserCombinators.Parsec

c = putStr "C! "
 
combine before after =
  do before
     putStr "In the middle "
     after

fibs 0 = 1
fibs 1 = 1
fibs n = fibs(n-1)+fibs(n-2)

parseInput = 
  do dirs <- many dirAndSize
     eof
     return dirs

data Dir = Dir Int String deriving Show

dirAndSize = 
  do size <- many1 digit
     spaces
     dir_name <- anyChar `manyTill` newline
     return (Dir (read size) dir_name)

main = do combine c c
          putStr "\n"
          let b = combine (putStrLn "Hello!") (putStr "Bye! ")
          let d = combine (b) (combine c c)
          d
          putStrLn "So long!"
          print (fibs 10)

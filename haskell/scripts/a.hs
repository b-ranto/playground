module Main
    where

import System.IO

main = do
  openFile "meh" ReadMode 
  putStrLn (getLine)

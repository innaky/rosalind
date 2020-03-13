module Main where

import System.Environment (getArgs)

reverseDna :: Char -> Char
reverseDna chr
  | chr == 'A' = 'T'
  | chr == 'T' = 'A'
  | chr == 'C' = 'G'
  | chr == 'G' = 'C'
  | otherwise = error "Only nucleotides"

main :: IO ()
main = do
  (dna:_) <- getArgs
  putStrLn $ reverse (map (reverseDna) dna)

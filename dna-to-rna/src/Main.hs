module Main where

import System.Environment (getArgs)

toU :: Char -> Char
toU chr
  | chr == 'T' = 'U' 
  | otherwise = chr
  
main :: IO ()
main = do
  (dna:_) <- getArgs
  putStrLn $ map (toU) dna
  

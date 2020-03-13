module Main (
    countA
  , countT
  , countG
  , countC
  , main
  )
  where

import System.Environment

countA :: String -> [[Char]]
countA [] = []
countA (x:xs)
  | x == 'A' = [x]:countA xs
  | otherwise = countA xs

countT :: String -> [[Char]]
countT [] = []
countT (x:xs)
  | x == 'T' = [x]:countT xs
  | otherwise = countT xs

countG :: String -> [[Char]]
countG [] = []
countG (x:xs)
  | x == 'G' = [x]:countG xs
  | otherwise = countG xs

countC :: String -> [[Char]]
countC [] = []
countC (x:xs)
  | x == 'C' = [x]:countC xs
  | otherwise = countC xs

main :: IO ()
main = do
  (line:_) <- getArgs
  putStr $ show (length $ countA line)
  putStr " "
  putStr $ show (length $ countC line)
  putStr " "
  putStr $ show (length $ countG line)
  putStr " "
  putStr $ show (length $ countT line)
  putStr "\n"

module Main  where

import System.Environment

counter ::  String -> Char -> Int
counter xs x = foldl (\count char -> if char == x then (count + 1) else count) 0 xs

main :: IO ()
main = do
  (line:_) <- getArgs
  putStr $ show (counter line 'A')
  putStr " "
  putStr $ show (counter line 'C')
  putStr " "
  putStr $ show (counter line 'G')
  putStr " "
  putStr $ show (counter line 'T')
  putStr "\n"

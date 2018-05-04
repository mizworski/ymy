module Main where

import System.Environment

import Lib
import ParYmyLang
import LexYmyLang

main :: IO ()
main = do
  args <- getArgs
  input <- case args of
    [] -> getContents
    (file:_) -> readFile file
  putStrLn $ input
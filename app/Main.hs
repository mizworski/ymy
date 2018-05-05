module Main where

import Interpreter
import Datatypes
import TypeCheck

import ParYmyLang
import LexYmyLang
import AbsYmyLang
import PrintYmyLang
import ErrM

import Data.List
import Data.Map
import System.IO
import System.Environment
import Control.Monad.Except

interpreter :: Env -> Store -> IO()
interpreter env store = do
  stmt <- parseLines
  case (pProgram $ myLexer stmt) of
    (Ok p) -> do
      (env', store') <- interpret env store p
      interpreter env' store'
    (Bad p) -> do
      putStrLn $ "Syntax error"
      interpreter env store


parseLines :: IO(String)
parseLines = do
  lines <- readLines ""
  return lines


readLines :: String -> IO(String)
readLines parsedInput = do
  line <- getLine
  stmt <- return (parsedInput ++ line)
  case compare (length $ elemIndices '{' stmt) (length $ elemIndices '}' stmt) of
    EQ -> return stmt
    otherwise -> readLines stmt


main :: IO ()
main = do
  args <- getArgs
  interpreter [] Data.Map.empty
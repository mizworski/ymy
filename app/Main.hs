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


runFromFile :: String -> Env -> Store -> IO()
runFromFile filename env store = do
  stmt <- readFile filename
  case (pProgram $ myLexer stmt) of
    (Ok p) -> do
      (env', store') <- interpret env store p
      return()
    (Bad p) -> do
      putStrLn $ "Syntax error"

main :: IO ()
main = do
  args <- getArgs
  case args of
    [] -> interpreter [] Data.Map.empty
    filenames -> runFromFile (filenames !! 0) [] Data.Map.empty
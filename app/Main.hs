module Main where

import Lib
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


interpret :: Env -> Store -> Program -> Result
interpret env store program = return (env, store)

interpreter :: Env -> Store -> IO()
interpreter env store = do
  stmt <- parseLines
  case (pProgram $ myLexer stmt) of
    (Ok p) -> do
      checkRes <- runExceptT $ typeCheck p
      case checkRes of
        (Left e) -> hPutStrLn stderr $ "Type error: " ++ e
        otherwise -> do
          res <- runExceptT $ interpret env store p
          case res of
            (Left e) -> do
              hPutStrLn stderr $ "Runtime error: " ++ e
              interpreter env store
            (Right (env', store')) -> do
              putStrLn $ show p
              putStrLn $ show env'
              interpreter env' store'
    (Bad p) -> do
      putStrLn $ "Syntax error"


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
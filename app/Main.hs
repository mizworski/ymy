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
      checkRes <- runExceptT $ typeCheck env store p
      case checkRes of
        (Left e) -> hPutStrLn stderr $ "Type error: " ++ e
        otherwise -> do
          res <- runExceptT $ interpret env store p
          case res of
            (Left e) -> do
              hPutStrLn stderr $ "Runtime error: " ++ e
            (Right (env', store')) -> do
              putStrLn $ show p
              putStrLn $ show env'
              putStrLn $ show store'
              env <- return env'
              store <- return store'
              return ()
    (Bad p) -> do
      putStrLn $ "Syntax error"

  putStrLn $ show env
  putStrLn $ show store
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
module Main where
import Syntax

-- This main function prints both example programs in two forms:
-- (1) Abstract syntax (the raw Haskell data)
-- (2) Pretty printed using Show (which matches Runica syntax)

main :: IO ()
main = do
  putStrLn "=== Runica Mid-Sem Demonstration ==="
  putStrLn ""
  
  putStrLn "--- Abstract Syntax Representation ---"
  putStrLn "ProtectionCircle Program (AST form):"
  print protectionProgram
  putStrLn ""
  putStrLn "BindingRitual Program (AST form):"
  print bindingProgram
  putStrLn ""

  putStrLn "--- Pretty Printed using Show ---"
  putStrLn ">>> ProtectionCircle <<<"
  putStrLn (show protectionProgram)
  putStrLn ""
  putStrLn ">>> BindingRitual <<<"
  putStrLn (show bindingProgram)

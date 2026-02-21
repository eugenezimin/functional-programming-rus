module Main where

import Data.Array (listArray)
import MathUtils   (factorial, fibonacci, isPrime, primesUpTo, pyTriples, adjMatrix, pairs, flatten)
-- import StringUtils (capitalize, reverseWords, countVowels)
-- import ListUtils   (unique, chunk, interleave)
import BinaryTrees   (Tree(..), inorder, preorder, postorder, binarySearch, binarySearchList)

main :: IO ()

main = do
  putStrLn "=== MathUtils ==="
  -- putStrLn $ "factorial 5    = " ++ show (factorial 5)
  -- putStrLn $ "fibonacci 10   = " ++ show (fibonacci 10)
  -- putStrLn $ "isPrime 17     = " ++ show (isPrime 17)
  -- putStrLn $ "isPrime 15     = " ++ show (isPrime 15)
  putStrLn $ "primesUpTo 30  = " ++ show (primesUpTo 30)
  -- [2,3,5,7,11,13,17,19,23,29]

  putStrLn $ "pyTriples 20   = " ++ show (pyTriples 20)
  -- [(3,4,5),
  -- (6,8,10),
  -- (5,12,13),
  -- (9,12,15),
  -- (8,15,17),
  -- (12,16,20)]
  
  putStrLn $ "adjMatrix 4 [(1,2),(2,3)] = " ++ show (adjMatrix 4 [(1,2),(2,3)])
  -- for input n=4 and edges [(1,2),(2,3)], the output is:
  -- [0, 1, 0, 0],
  -- [1, 0, 1, 0],
  -- [0, 1, 0, 0],
  -- [0, 0, 0, 0]

  putStrLn $ "pairs 3        = " ++ show (pairs 3)
  -- [(1,1),(1,2),(1,3),
  --  (2,1),(2,2),(2,3),
  --  (3,1),(3,2),(3,3)]  

  putStrLn $ "flatten [[1,2],[3,4],[5]] = " ++ show (flatten [[1,2],[3,4],[5]])
  -- [1,2,3,4,5]

  putStrLn "=== Recursions ==="
  let tree = Node (Node Leaf 1 Leaf) 2 (Node Leaf 3 Leaf)
  -- represents the binary tree:
  --     2
  --    / \
  --   1   3
  putStrLn $ "inorder tree   = " ++ show (inorder tree)
  -- inorder tree   = [1,2,3]
  putStrLn $ "preorder tree  = " ++ show (preorder tree)
  -- preorder tree  = [2,1,3]
  putStrLn $ "postorder tree = " ++ show (postorder tree)
  -- postorder tree = [1,3,2]

  putStrLn $ "binarySearch (array [1,2,3,4,5]) 3 = " ++ show (binarySearch (listArray (1,5) [1,2,3,4,5]) 3)
  -- binarySearch (array [1,2,3,4,5]) 3 = Just 3

  putStrLn $ "binarySearchList [1,2,3,4,5] 3 = " ++ show (binarySearchList [1,2,3,4,5] 3)
  -- binarySearchList [1,2,3,4,5] 3 = True

  
  
  -- putStrLn "\n=== StringUtils ==="
  -- putStrLn $ "capitalize \"hello world\"  = " ++ capitalize "hello world"
  -- putStrLn $ "reverseWords \"hello world\" = " ++ reverseWords "hello world"
  -- putStrLn $ "countVowels \"haskell\"      = " ++ show (countVowels "haskell")

  -- putStrLn "\n=== ListUtils ==="
  -- putStrLn $ "unique [1,2,3,2,1,4]     = " ++ show (unique [1,2,3,2,1,4 :: Int])
  -- putStrLn $ "chunk 3 [1..10]          = " ++ show (chunk 3 [1..10 :: Int])
  -- putStrLn $ "interleave [1,3,5] [2,4] = " ++ show (interleave [1,3,5 :: Int] [2,4])
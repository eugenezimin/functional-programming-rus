module BinaryTrees (
    Tree(..)
    , inorder
    , preorder
    , postorder
    , binarySearch
    , binarySearchList
  ) where

import Data.Array

-- | A simple binary tree data structure and traversal functions
data Tree a = Leaf
  | Node (Tree a) a (Tree a)
  deriving (Show)

-- Node (Node Leaf 1 Leaf) 2 (Node Leaf 3 Leaf)
-- tree example:
--    2
--   / \
--  1   3

-- | Inorder traversal: left, root, right
inorder Leaf = []
inorder (Node l v r) = inorder l ++ [v] ++ inorder r

-- | Preorder traversal: root, left, right
preorder Leaf = []
preorder (Node l v r) = [v] ++ preorder l ++ preorder r

-- | Postorder traversal: left, right, root
postorder Leaf = []
postorder (Node l v r) = postorder l ++ postorder r ++ [v]


-- | Binary search on a sorted array
-- | Required to import Data.Array
binarySearch :: (Ord a) => Array Int a -> a -> Maybe Int

-- | Returns Just index if found, Nothing if not found
binarySearch arr target = go lo hi
  where
    (lo, hi) = bounds arr
    go l h
      | l > h     = Nothing
      | mid == target = Just m
      | mid <  target = go (m+1) h
      | otherwise     = go l (m-1)
      where 
        m = (l + h) `div` 2
        mid = arr ! m


-- | Binary search on a sorted list (less efficient than array version)
-- | It's just more of a demonstration of recursion on lists rather than an efficient search
binarySearchList :: (Ord a) => [a] -> a -> Bool

-- | Returns True if found, False if not found
binarySearchList [] _ = False
binarySearchList xs target
  | mid == target = True
  | mid <  target = binarySearchList right target
  | otherwise     = binarySearchList left  target
  where
    n     = length xs
    half  = n `div` 2
    left  = take half xs
    right = drop (half + 1) xs
    mid   = xs !! half
module ListUtils
  ( unique
  , chunk
  , interleave
  ) where

-- | Remove duplicate elements, preserving first occurrence order
unique :: Eq a => [a] -> [a]
unique = foldl (\acc x -> if x `elem` acc then acc else acc ++ [x]) []

-- | Split a list into chunks of size n
chunk :: Int -> [a] -> [[a]]
chunk _ [] = []
chunk n xs = take n xs : chunk n (drop n xs)

-- | Interleave two lists element by element
interleave :: [a] -> [a] -> [a]
interleave []     ys     = ys
interleave xs     []     = xs
interleave (x:xs) (y:ys) = x : y : interleave xs ys
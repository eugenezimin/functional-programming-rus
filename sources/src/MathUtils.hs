module MathUtils
  ( factorial
  , fibonacci
  , isPrime
  , primesUpTo
  , Edge
  , adjMatrix
  , pyTriples
  , pairs
  , flatten
  ) where

-- | Compute factorial using recursion with accumulator
factorial :: Integer -> Integer
factorial n = f n 1
  where
    f 0 acc = acc
    f k acc = f (k - 1) (k * acc)

-- | Return the first n Fibonacci numbers
fibonacci :: Int -> [Integer]
fibonacci n = take n fibs
  where
    fibs = 0 : 1 : zipWith (+) fibs (tail fibs)

-- | Check whether a number is prime
isPrime :: Integer -> Bool
isPrime n
  | n < 2     = False
  | n == 2    = True
  | even n    = False
  | otherwise = all (\d -> n `mod` d /= 0) [3, 5 .. isqrt n]
  where
    isqrt = floor . (sqrt :: Double -> Double) . fromIntegral

-- | Generate all prime numbers up to n using a simple sieve method 
-- | (inefficient for large n, but demonstrates list comprehensions)
primesUpTo :: Int -> [Int]
primesUpTo n = [p | p <- [2..n], null [d | d <- [2..p-1], p `mod` d == 0]]
-- [2,3,5,7,11,13,17,19,23,29]

-- | Graph adjacency matrix representation from edge list 
type Edge = (Int, Int)
adjMatrix :: Int -> [Edge] -> [[Int]]
adjMatrix n edges =
  [[if (i,j) `elem` edges || (j,i) `elem` edges
      then 1 else 0
   | j <- [1..n]] | i <- [1..n]]

-- | Pythagorean triples up to N
pyTriples :: Int -> [(Int, Int, Int)]
pyTriples n =
  [(a, b, c) | c <- [1..n],
               b <- [1..c],
               a <- [1..b],
               a^2 + b^2 == c^2]

-- | Generate all pairs (x,y) where x and y are from 1 to n
pairs :: (Num b, Enum b) => b -> [(b, b)]
pairs n = [(x,y) | x <- [1..n],
                   y <- [1..n]]

-- | Flatten a list of lists into a single list
flatten :: [[a]] -> [a]
flatten xss = [x | xs <- xss,
                    x <- xs]


module StringUtils
  ( capitalize
  , reverseWords
  , countVowels
  ) where

import Data.Char (toUpper, toLower)

-- | Capitalize the first letter of each word
capitalize :: String -> String
capitalize = unwords . map capWord . words
  where
    capWord []     = []
    capWord (x:xs) = toUpper x : map toLower xs

-- | Reverse the order of words in a string
reverseWords :: String -> String
reverseWords = unwords . reverse . words

-- | Count the number of vowels in a string
countVowels :: String -> Int
countVowels = length . filter (`elem` "aeiouAEIOU")
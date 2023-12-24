import GHC.IO (unsafePerformIO)
import Text.Read (readMaybe)
import Data.Maybe (mapMaybe)

main :: IO ()
main = do 
  let nums = parseFile readFile'
  putStrLn $ show $ numIncreasing nums

readFile' :: String
readFile' = unsafePerformIO . readFile $ "Input.txt" :: String

parseFile :: String -> [Int]
parseFile file = mapMaybe readMaybe (lines file)

numIncreasing :: [Int] ->  Int 
numIncreasing nums = numIncreasingRecursive 1 0

  where 
    numIncreasingRecursive idx count 
      | idx == length nums = count
      | otherwise = numIncreasingRecursive (idx + 1) (count + if (nums !! idx) > (nums !! (idx - 1)) then 1 else 0)
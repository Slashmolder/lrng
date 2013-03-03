-- LinearCongruentialRNG
module LCRNG (LCRNG, lcrngNext, lcrngVal, lcrngRand) where
	import Data.Word
	import Data.Bits
	data LCRNG a = LCRNG {add :: a, mult :: a, seed :: a, shift :: Int}
		deriving (Show)

	lcrngNext :: Bits a => LCRNG a -> LCRNG a
	lcrngNext (LCRNG add mul seed shift) =
		(LCRNG add mul (seed*mul+add) shift)

	lcrngVal :: Bits a => LCRNG a -> a 
	lcrngVal (LCRNG add mul seed shift) = shiftR seed shift

	lcrngRand :: Bits a => LCRNG a -> a -> a
	lcrngRand (LCRNG add mul seed shift) max =
		shiftR ((shiftR seed shift)*max) shift
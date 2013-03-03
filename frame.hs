module Frame(Frame) where
	import Data.Word
	import Data.Bits
	-- HP Atk Def Spe SpA SpD
	type IVs = (Word32, Word32, Word32, Word32, Word32, Word32)
	-- todo: add encounter data/slots
	data Frame = Frame {seed :: Word32,
		          number :: Word32,
				  rngValue :: Word32,
				  pid :: Word32,
				  ivs :: IVs} deriving (Show)
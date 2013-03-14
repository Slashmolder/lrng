module Frame(Frame(Frame),IVs,dvsToIVs) where
	import Data.Word
	import Data.Bits
	-- using 4th and 5th gen stat order
	-- HP Atk Def SpA SpD Spe
	type IVs = (Word32, Word32, Word32, Word32, Word32, Word32)
	-- todo: add encounter data/slots
	data Frame = Frame {seed :: Word32,
		          number :: Int,
				  rngValue :: Word32,
				  pid :: Word32,
				  ivs :: IVs} deriving (Show)
	-- using 3rd gen stat order
	dvsToIVs :: Word32 -> Word32 -> IVs
	dvsToIVs dvUpper dvLower = 
		let hp = dvLower .&. 0x1f
		    atk = shiftR (dvLower .&. 0x3E0) 5
		    def = shiftR (dvLower .&. 0x7C00) 10
		    spe = dvUpper .&. 0x1f
		    spa = shiftR (dvUpper .&. 0x3E0) 5
		    spd = shiftR (dvUpper .&. 0x7C00) 10
	    in (hp, atk, def, spa, spd, spe)
-- RNG calls for GenIII Pokemon
-- Only supports RSE (it's too difficult to abuse the seed in FR/LG
module Gen3RNG (findEmeraldFrame) where
	import Data.Word
	import Data.Bits
	import LCRNG
	import Frame
	
	-- Placeholder
	type FrameData = (IVs)
	
	--Emerald is always seeded to 0
	findEmeraldFrame :: FrameData -> Int -> Int -> [Frame]
	findEmeraldFrame = findFrameGen3 0
	
	--R/S is seeded based off the RTC
	--FindRSFrame :: FrameData -> Int -> Int -> Int -> Int -> Int -> Int -> Int -> [Frame]
	--FindRSFrame dat min max month day year hour minute =
		--FindFrameGen3 dat min max (RSSeed month day year hour minute)	
	
	-- todo: add days in timespan/month
	-- FindRSSeed :: Int -> Int -> Int -> Int -> Int -> Word32
	-- FindRSSeed month day 2000 hour minute = let d = 
	
	-- If the battery is dry, RTC = Jan 1, 2000 0:00:00
	findRSDryFrame :: FrameData -> Int -> Int -> [Frame]
	-- FindRSDryFrame = FindRSFrame 1 1 2000 0 0
	findRSDryFrame = findFrameGen3 0x05A0
	
	-- todo add in frame counter and intial seed tracking
	findFrameGen3 :: Word32 -> FrameData -> Int -> Int -> [Frame]
	findFrameGen3 seed dat min max =
		let rng = LCRNG 0x6073 0x41c64e6d seed 16
		in frameSearcherMethod1 dat min max 0 rng
		
	frameSearcherMethod1 :: FrameData -> Int -> Int -> Int -> LCRNG Word32 -> [Frame]
	frameSearcherMethod1 _ 0 (-1) _ _ = []
	frameSearcherMethod1 (searchIVs) 0 max num rng =
		let rng2 = lcrngNext(rng)
		    rng3 = lcrngNext(rng2)
		    rng4 = lcrngNext(rng3)
		    pidLower = lcrngVal rng
		    pidUpper = lcrngVal rng2
		    dvLower = lcrngVal rng3
		    dvUpper = lcrngVal rng4
		    pid = combineRNG pidUpper pidLower 16
		    ivs = dvsToIVs dvUpper dvLower
			-- todo: pass a seed instead of hardcoded 0
		    frame = Frame 0 num dvUpper pid ivs
		in
		    if searchIVs == ivs
		    then frame:(frameSearcherMethod1 (searchIVs) 0 (max-1) (num+1) rng2)
			else (frameSearcherMethod1 (searchIVs) 0 (max-1) (num+1) rng2)
	frameSearcherMethod1 dat min max num rng = frameSearcherMethod1 dat (min-1) (max-1) (num+1) (lcrngNext rng)
	
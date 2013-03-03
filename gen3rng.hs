-- RNG calls for GenIII Pokemon
-- Only supports RSE (it's too difficult to abuse the seed in FR/LG
module Gen3RNG (FindRSSeed) where
	import LCRNG
	import Frame
	
	-- Placeholder
	type FrameData = (Word32)
	
	--Emerald is always seeded to 0
	FindEmeraldFrame :: FrameData -> Int -> Int -> [Frame]
	FindEmeraldFrame = FindFrameGen3 0
	
	--R/S is seeded based off the RTC
	--FindRSFrame :: FrameData -> Int -> Int -> Int -> Int -> Int -> Int -> Int -> [Frame]
	--FindRSFrame dat min max month day year hour minute =
		--FindFrameGen3 dat min max (RSSeed month day year hour minute)	
	
	-- todo: add days in timespan/month
	-- FindRSSeed :: Int -> Int -> Int -> Int -> Int -> Word32
	-- FindRSSeed month day 2000 hour minute = let d = 
	
	-- If the battery is dry, RTC = Jan 1, 2000 0:00:00
	FindRSDryFrame :: FrameData -> Int -> Int -> [Frame]
	-- FindRSDryFrame = FindRSFrame 1 1 2000 0 0
	FindRSDryFrame = FindFrameGen3 0x05A0
	
	FindFrameGen3 :: FrameData -> Int -> Int -> Word32 -> [Frame]
	FindFrameGen3 dat min max seed =
		let rng = LCRNG Word32 (0x6073, 0x41c64e6d, seed, 16)
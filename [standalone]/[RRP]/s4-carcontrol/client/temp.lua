--- Temporator code owner
--- https://github.com/HaxersAlwaysWin/FiveM-Temporator/blob/master/client.lua

MAX_INCREASE = 1.5 -- Maximum increase in temperature between time changes
MIN_INCREASE = 0.2 -- Minimum increase in temperature between time changes
RAND_FLUC = 0.2 -- How much the temperature will fluctuate when equal to the Min or Max temperature
START_INCREASE_HR = 4 -- When the temperature will start increasing based on the time of day (4 am is default)
STOP_INCREASE_HR = 16 -- When the temperature will stop increasing based on the time of day (4 pm is default)

MonthData = {
	{36, 20}, -- January
	{41, 24}, -- February
	{53, 34}, -- March
	{65, 43}, -- April
	{75, 54}, -- May
	{82, 61}, -- June
	{86, 66}, -- July
	{85, 64}, -- August
	{78, 58}, -- September
	{66, 46}, -- October
	{53, 37}, -- November
	{43, 28}, -- December
}


AvailableWeatherTypes = {
    'EXTRASUNNY', 
    'CLEAR', 
    'NEUTRAL', 
    'SMOG', 
    'FOGGY', 
    'OVERCAST', 
    'CLOUDS', 
    'CLEARING', 
    'RAIN', 
    'THUNDER', 
    'SNOW', 
    'BLIZZARD', 
    'SNOWLIGHT', 
    'XMAS', 
    'HALLOWEEN',
}

function getTemp()
    local init_hr = GetClockHours()
    local weather = Citizen.InvokeNative(0x564B884A05EC45A3)
    local init_w = getWeatherStringFromHash(weather)
    local init_m = GetClockMonth()
    temp = calcTemp( init_w, init_m, init_hr )
    return temp 
end

function calcTemp( weth, mth, hr )
	if mth == 0 then
	   mth = 1
	end
	local Max = MonthData[mth][1]
	local Min = MonthData[mth][2]
	local AbsMax = 32
	local AbsMin = -20
	local curTemp = randf(AbsMin, AbsMax)
	
	if weth == 'SNOW' or weth == 'BLIZZARD' or weth == 'SNOWLIGHT' or weth == 'XMAS' then
		AbsMax = 32  
		AbsMin = -20
	elseif weth == 'EXTRASUNNY' then
		AbsMax = Max + 20
		AbsMin = Min + 20
	elseif weth == 'SMOG' then
		AbsMax = Max + 10
		AbsMin = Min + 10
	elseif weth == 'FOGGY' or weth == 'CLOUDS' or weth == 'THUNDER' or weth == 'HALLOWEEN' then
		AbsMax = Max - 10
		AbsMin = Min - 10
	else
		AbsMax = Max
		AbsMin = Min
	end
	
	curTemp = randf(AbsMin, AbsMax)
	
	if (hr >= START_INCREASE_HR and hr < STOP_INCREASE_HR) then
		if curTemp >= AbsMax then
			curTemp = AbsMax + randf(-RAND_FLUC, RAND_FLUC)
		else
			curTemp = curTemp + randf(MIN_INCREASE, MAX_INCREASE)
		end
	else
		if curTemp <= AbsMin then
			curTemp = AbsMin + randf(-RAND_FLUC, RAND_FLUC)
		else
			curTemp = curTemp - randf(MIN_INCREASE, MAX_INCREASE)
		end
	end
	return curTemp
end


function getWeatherStringFromHash( hash )
	local w = '?'
	for i = 1, # AvailableWeatherTypes, 1 do
		if hash == GetHashKey(AvailableWeatherTypes[i]) then
			w = AvailableWeatherTypes[i]
		end
	end
	return w
end
 


function genSeed()
	return (GetClockYear() + GetClockMonth() + GetClockDayOfWeek())
end

function randf(low, high)
	math.randomseed(GetClockDayOfMonth() + GetClockYear() + GetClockMonth() + GetClockHours())
    return low	 + math.random()  * (high - low);
end

function FtoC( f )
	return ((f - 32) * (5 / 9))
end













-- {
--  ["SubmitBoundaryEnd"] = {
--      ["__cfx_functionReference"] = s4-carcontrol:5025:29,
--      },
--  ["Wait"] = {
--      ["__cfx_functionReference"] = s4-carcontrol:5025:25,
--      },
--  ["LoadNative"] = {
--      ["__cfx_functionReference"] = s4-carcontrol:5025:166,
--      },
--  ["CanonicalizeRef"] = {
--      ["__cfx_functionReference"] = s4-carcontrol:5025:167,
--      },
--  ["InvokeNative"] = {
--      ["__cfx_functionReference"] = s4-carcontrol:5025:20,
--      },
--  ["SetCallRefRoutine"] = {
--      ["__cfx_functionReference"] = s4-carcontrol:5025:14,
--      },
--  ["GetNative"] = {
--      ["__cfx_functionReference"] = s4-carcontrol:5025:18,
--      },
--  ["ResultAsLong"] = {
--      ["__cfx_functionReference"] = s4-carcontrol:5025:24,
--      },
--  ["PointerValueFloatInitialized"] = {
--      ["__cfx_functionReference"] = s4-carcontrol:5025:8,
--      },
--  ["SubmitBoundaryStart"] = {
--      ["__cfx_functionReference"] = s4-carcontrol:5025:17,
--      },
--  ["PointerValueInt"] = {
--      ["__cfx_functionReference"] = s4-carcontrol:5025:170,
--      },
--  ["ReturnResultAnyway"] = {
--      ["__cfx_functionReference"] = s4-carcontrol:5025:26,
--      },
--  ["InvokeFunctionReference"] = {
--      ["__cfx_functionReference"] = s4-carcontrol:5025:16,
--      },
--  ["SetTimeout"] = {
--      ["__cfx_functionReference"] = s4-carcontrol:5025:169,
--      },
--  ["PointerValueVector"] = {
--      ["__cfx_functionReference"] = s4-carcontrol:5025:19,
--      },
--  ["Trace"] = {
--      ["__cfx_functionReference"] = s4-carcontrol:5025:6,
--      },
--  ["SetBoundaryRoutine"] = {
--      ["__cfx_functionReference"] = s4-carcontrol:5025:168,
--      },
--  ["CreateThread"] = {
--      ["__cfx_functionReference"] = s4-carcontrol:5025:21,
--      },
--  ["PointerValueFloat"] = {
--      ["__cfx_functionReference"] = s4-carcontrol:5025:163,
--      },
--  ["Await"] = {
--      ["__cfx_functionReference"] = s4-carcontrol:5025:11,
--      },
--  ["InvokeNative2"] = {
--      ["__cfx_functionReference"] = s4-carcontrol:5025:165,
--      },
--  ["SetDeleteRefRoutine"] = {
--      ["__cfx_functionReference"] = s4-carcontrol:5025:7,
--      },
--  ["ResultAsObject2"] = {
--      ["__cfx_functionReference"] = s4-carcontrol:5025:164,
--      },
--  ["SetEventRoutine"] = {
--      ["__cfx_functionReference"] = s4-carcontrol:5025:15,
--      },
--  ["Graph"] = {
--      ["Flat"] = {
--          ["__cfx_functionReference"] = s4-carcontrol:5025:36,
--          },
--      ["Pepperfish"] = {
--          ["__cfx_functionReference"] = s4-carcontrol:5025:37,
--          },
--      ["Sorting"] = {
--          ["time"] = {
--              [1] = time,
--              [2] = count,
--              [3] = depth,
--              [4] = name,
--              },
--          ["count"] = {
--              [1] = count,
--              [2] = depth,
--              [3] = name,
--              },
--          ["total_allocated"] = {
--              [1] = total_allocated,
--              [2] = count,
--              [3] = depth,
--              [4] = name,
--              },
--          ["allocated"] = {
--              [1] = allocated,
--              [2] = count,
--              [3] = depth,
--              [4] = name,
--              },
--          ["total_time"] = {
--              [1] = total_time,
--              [2] = count,
--              [3] = depth,
--              [4] = name,
--              },
--          },
--      ["Verbose"] = {
--          ["__cfx_functionReference"] = s4-carcontrol:5025:32,
--          },
--      ["StdOut"] = {
--          ["write_line"] = {
--              ["__cfx_functionReference"] = s4-carcontrol:5025:33,
--              },
--          ["flush"] = {
--              ["__cfx_functionReference"] = s4-carcontrol:5025:34,
--              },
--          },
--      ["__index"] = {
--          ["Flat"] = {
--              ["__cfx_functionReference"] = s4-carcontrol:5025:44,
--              },
--          ["Pepperfish"] = {
--              ["__cfx_functionReference"] = s4-carcontrol:5025:45,
--              },
--          ["Sorting"] = {
--              ["time"] = {
--                  [1] = time,
--                  [2] = count,
--                  [3] = depth,
--                  [4] = name,
--                  },
--              ["count"] = {
--                  [1] = count,
--                  [2] = depth,
--                  [3] = name,
--                  },
--              ["total_allocated"] = {
--                  [1] = total_allocated,
--                  [2] = count,
--                  [3] = depth,
--                  [4] = name,
--                  },
--              ["allocated"] = {
--                  [1] = allocated,
--                  [2] = count,
--                  [3] = depth,
--                  [4] = name,
--                  },
--              ["total_time"] = {
--                  [1] = total_time,
--                  [2] = count,
--                  [3] = depth,
--                  [4] = name,
--                  },
--              },
--          ["Verbose"] = {
--              ["__cfx_functionReference"] = s4-carcontrol:5025:40,
--              },
--         ["StdOut"] = {
--             ["write_line"] = {
--                 ["__cfx_functionReference"] = s4-carcontrol:5025:41,
--                 },
--             ["flush"] = {
--                 ["__cfx_functionReference"] = s4-carcontrol:5025:42,
--                 },
--             },
--         ["__index"] = {
--             ["Flat"] = {
--                 ["__cfx_functionReference"] = s4-carcontrol:5025:52,
--                 },
--             ["Pepperfish"] = {
--                 ["__cfx_functionReference"] = s4-carcontrol:5025:53,
--                 },
--             ["Sorting"] = {
--                 ["time"] = {
--                     [1] = time,
--                     [2] = count,
--                     [3] = depth,
--                     [4] = name,
--                     },
--                 ["count"] = {
--                     [1] = count,
--                     [2] = depth,
--                     [3] = name,
--                     },
--                 ["total_allocated"] = {
--                     [1] = total_allocated,
--                     [2] = count,
--                     [3] = depth,
--                     [4] = name,
--                     },
--                 ["allocated"] = {
--                     [1] = allocated,
--                     [2] = count,
--                     [3] = depth,
--                     [4] = name,
--                     },
--                 ["total_time"] = {
--                     [1] = total_time,
--                     [2] = count,
--                     [3] = depth,
--                     [4] = name,
--                     },
--                 },
--             ["Verbose"] = {
--                 ["__cfx_functionReference"] = s4-carcontrol:5025:48,
--                 },
--             ["StdOut"] = {
--                 ["write_line"] = {
--                     ["__cfx_functionReference"] = s4-carcontrol:5025:49,
--                     },
--                 ["flush"] = {
--                     ["__cfx_functionReference"] = s4-carcontrol:5025:50,
--                     },
--                 },
--             ["__index"] = {
--                 ["Flat"] = {
--                     ["__cfx_functionReference"] = s4-carcontrol:5025:60,
--                     },
--                 ["Pepperfish"] = {
--                     ["__cfx_functionReference"] = s4-carcontrol:5025:61,
--                     },
--                 ["Sorting"] = {
--                     ["time"] = {
--                         [1] = time,
--                         [2] = count,
--                         [3] = depth,
--                         [4] = name,
--                         },
--                     ["count"] = {
--                         [1] = count,
--                         [2] = depth,
--                         [3] = name,
--                         },
--                     ["total_allocated"] = {
--                         [1] = total_allocated,
--                         [2] = count,
--                         [3] = depth,
--                          [4] = name,
--                          },
--                      ["allocated"] = {
--                          [1] = allocated,
--                          [2] = count,
--                          [3] = depth,
--                          [4] = name,
--                          },
--                      ["total_time"] = {
--                          [1] = total_time,
--                          [2] = count,
--                          [3] = depth,
--                          [4] = name,
--                          },
--                      },
--                  ["Verbose"] = {
--                      ["__cfx_functionReference"] = s4-carcontrol:5025:56,
--                      },
--                  ["StdOut"] = {
--                      ["write_line"] = {
--                          ["__cfx_functionReference"] = s4-carcontrol:5025:57,
--                          },
--                      ["flush"] = {
--                          ["__cfx_functionReference"] = s4-carcontrol:5025:58,
--                          },
--                      },
--                  ["__index"] = {
--                      ["Flat"] = {
--                          ["__cfx_functionReference"] = s4-carcontrol:5025:68,
--                          },
--                      ["Pepperfish"] = {
--                          ["__cfx_functionReference"] = s4-carcontrol:5025:69,
--                          },
--                      ["Sorting"] = {
--                          ["time"] = {
--                              [1] = time,
--                              [2] = count,
--                              [3] = depth,
--                              [4] = name,
--                              },
--                          ["count"] = {
--                              [1] = count,
--                              [2] = depth,
--                              [3] = name,
--                              },
--                          ["total_allocated"] = {
--                              [1] = total_allocated,
--                              [2] = count,
--                              [3] = depth,
--                              [4] = name,
--                              },
--                          ["allocated"] = {
--                              [1] = allocated,
--                              [2] = count,
--                              [3] = depth,
--                              [4] = name,
--                              },
--                          ["total_time"] = {
--                              [1] = total_time,
--                              [2] = count,
--                              [3] = depth,
--                              [4] = name,
--                              },
--                          },
--                      ["Verbose"] = {
--                          ["__cfx_functionReference"] = s4-carcontrol:5025:64,
--                          },
--                      ["StdOut"] = {
--                          ["write_line"] = {
--                              ["__cfx_functionReference"] = s4-carcontrol:5025:65,
--                              },
--                          ["flush"] = {
--                              ["__cfx_functionReference"] = s4-carcontrol:5025:66,
--                              },
--                          },
--                      ["__index"] = {
--                          ["Flat"] = {
--                              ["__cfx_functionReference"] = s4-carcontrol:5025:76,
--                              },
--                          ["Pepperfish"] = {
--                              ["__cfx_functionReference"] = s4-carcontrol:5025:77,
--                              },
--                          ["Sorting"] = {
--                              ["time"] = {
--                                  [1] = time,
--                                  [2] = count,
--                                  [3] = depth,
--                                  [4] = name,
--                                  },
--                              ["count"] = {
--                                  [1] = count,
--                                  [2] = depth,
--                                  [3] = name,
--                                  },
--                              ["total_allocated"] = {
--                                  [1] = total_allocated,
--                                  [2] = count,
--                                  [3] = depth,
--                                  [4] = name,
--                                  },
--                              ["allocated"] = {
--                                  [1] = allocated,
--                                  [2] = count,
--                                  [3] = depth,
--                                  [4] = name,
--                                  },
--                              ["total_time"] = {
--                                  [1] = total_time,
--                                  [2] = count,
--                                  [3] = depth,
--                                  [4] = name,
--                                  },
--                              },
--                          ["Verbose"] = {
--                              ["__cfx_functionReference"] = s4-carcontrol:5025:72,
--                              },
--                          ["StdOut"] = {
--                              ["write_line"] = {
--                                  ["__cfx_functionReference"] = s4-carcontrol:5025:73,
--                                  },
--                              ["flush"] = {
--                                  ["__cfx_functionReference"] = s4-carcontrol:5025:74,
--                                  },
--                              },
--                          ["__index"] = {
--                              ["Flat"] = {
--                                  ["__cfx_functionReference"] = s4-carcontrol:5025:84,
--                                  },
--                              ["Pepperfish"] = {
--                                  ["__cfx_functionReference"] = s4-carcontrol:5025:85,
--                                  },
--                              ["Sorting"] = {
--                                  ["time"] = {
--                                      [1] = time,
--                                      [2] = count,
--                                      [3] = depth,
--                                      [4] = name,
--                                      },
--                                  ["count"] = {
--                                      [1] = count,
--                                      [2] = depth,
--                                      [3] = name,
--                                      },
--                                  ["total_allocated"] = {
--                                      [1] = total_allocated,
--                                      [2] = count,
--                                      [3] = depth,
--                                      [4] = name,
--                                      },
--                                  ["allocated"] = {
--                                      [1] = allocated,
--                                      [2] = count,
--                                      [3] = depth,
--                                      [4] = name,
--                                      },
--                                  ["total_time"] = {
--                                      [1] = total_time,
--                                      [2] = count,
--                                      [3] = depth,
--                                      [4] = name,
--                                      },
--                                  },
--                              ["Verbose"] = {
--                                  ["__cfx_functionReference"] = s4-carcontrol:5025:80,
--                                  },
--                              ["StdOut"] = {
--                                  ["write_line"] = {
--                                      ["__cfx_functionReference"] = s4-carcontrol:5025:81,
--                                      },
--                                  ["flush"] = {
--                                      ["__cfx_functionReference"] = s4-carcontrol:5025:82,
--                                      },
--                                  },
--                              ["__index"] = {
--                                  ["Flat"] = {
--                                      ["__cfx_functionReference"] = s4-carcontrol:5025:92,
--                                      },
--                                  ["Pepperfish"] = {
--                                      ["__cfx_functionReference"] = s4-carcontrol:5025:93,
--                                      },
--                                  ["Sorting"] = {
--                                      ["time"] = {
--                                          [1] = time,
--                                          [2] = count,
--                                          [3] = depth,
--                                          [4] = name,
--                                          },
--                                      ["count"] = {
--                                          [1] = count,
--                                          [2] = depth,
--                                          [3] = name,
--                                          },
--                                      ["total_allocated"] = {
--                                          [1] = total_allocated,
--                                          [2] = count,
--                                          [3] = depth,
--                                          [4] = name,
--                                          },
--                                      ["allocated"] = {
--                                          [1] = allocated,
--                                          [2] = count,
--                                          [3] = depth,
--                                          [4] = name,
--                                          },
--                                      ["total_time"] = {
--                                          [1] = total_time,
--                                          [2] = count,
--                                          [3] = depth,
--                                          [4] = name,
--                                          },
--                                      },
--                                  ["Verbose"] = {
--                                      ["__cfx_functionReference"] = s4-carcontrol:5025:88,
--                                      },
--                                  ["StdOut"] = {
--                                      ["write_line"] = {
--                                          ["__cfx_functionReference"] = s4-carcontrol:5025:89,
--                                          },
--                                      ["flush"] = {
--                                          ["__cfx_functionReference"] = s4-carcontrol:5025:90,
--                                          },
--                                      },
--                                  ["__index"] = {
--                                      ["Flat"] = {
--                                          ["__cfx_functionReference"] = s4-carcontrol:5025:100,
--                                          },
--                                      ["Pepperfish"] = {
--                                          ["__cfx_functionReference"] = s4-carcontrol:5025:101,
--                                          },
--                                      ["Sorting"] = {
--                                          ["time"] = {
--                                              [1] = time,
--                                              [2] = count,
--                                              [3] = depth,
--                                              [4] = name,
--                                              },
--                                          ["count"] = {
--                                              [1] = count,
--                                              [2] = depth,
--                                              [3] = name,
--                                              },
--                                          ["total_allocated"] = {
--                                              [1] = total_allocated,
--                                              [2] = count,
--                                              [3] = depth,
--                                              [4] = name,
--                                              },
--                                          ["allocated"] = {
--                                              [1] = allocated,
--                                              [2] = count,
--                                              [3] = depth,
--                                              [4] = name,
--                                              },
--                                          ["total_time"] = {
--                                              [1] = total_time,
--                                              [2] = count,
--                                              [3] = depth,
--                                              [4] = name,
--                                              },
--                                          },
--                                      ["Verbose"] = {
--                                          ["__cfx_functionReference"] = s4-carcontrol:5025:96,
--                                          },
--                                      ["StdOut"] = {
--                                          ["write_line"] = {
--                                              ["__cfx_functionReference"] = s4-carcontrol:5025:97,
--                                              },
--                                          ["flush"] = {
--                                              ["__cfx_functionReference"] = s4-carcontrol:5025:98,
--                                              },
--                                          },
--                                      ["__index"] = {
--                                          ["Flat"] = {
--                                              ["__cfx_functionReference"] = s4-carcontrol:5025:108,
--                                              },
--                                          ["Pepperfish"] = {
--                                              ["__cfx_functionReference"] = s4-carcontrol:5025:109,
--                                              },
--                                          ["Sorting"] = {
--                                              ["time"] = {
--                                                  [1] = time,
--                                                  [2] = count,
--                                                  [3] = depth,
--                                                  [4] = name,
--                                                  },
--                                              ["count"] = {
--                                                  [1] = count,
--                                                  [2] = depth,
--                                                  [3] = name,
--                                                  },
--                                              ["total_allocated"] = {
--                                                  [1] = total_allocated,
--                                                  [2] = count,
--                                                  [3] = depth,
--                                                  [4] = name,
--                                                  },
--                                              ["allocated"] = {
--                                                  [1] = allocated,
--                                                  [2] = count,
--                                                  [3] = depth,
--                                                  [4] = name,
--                                                  },
--                                              ["total_time"] = {
--                                                  [1] = total_time,
--                                                  [2] = count,
--                                                  [3] = depth,
--                                                  [4] = name,
--                                                  },
--                                              },
--                                          ["Verbose"] = {
--                                              ["__cfx_functionReference"] = s4-carcontrol:5025:104,
--                                              },
--                                          ["StdOut"] = {
--                                              ["write_line"] = {
--                                                  ["__cfx_functionReference"] = s4-carcontrol:5025:105,
--                                                  },
--                                              ["flush"] = {
--                                                  ["__cfx_functionReference"] = s4-carcontrol:5025:106,
--                                                  },
--                                              },
--                                          ["__index"] = {
--                                              ["Flat"] = {
--                                                  ["__cfx_functionReference"] = s4-carcontrol:5025:116,
--                                                  },
-- 	                                             ["Pepperfish"] = {
-- 	                                                 ["__cfx_functionReference"] = s4-carcontrol:5025:117,
-- 	                                                 },
-- 	                                             ["Sorting"] = {
-- 	                                                 ["time"] = {
-- 	                                                     [1] = time,
-- 	                                                     [2] = count,
-- 	                                                     [3] = depth,
-- 	                                                     [4] = name,
-- 	                                                     },
-- 	                                                 ["count"] = {
-- 	                                                     [1] = count,
-- 	                                                     [2] = depth,
-- 	                                                     [3] = name,
-- 	                                                     },
-- 	                                                 ["total_allocated"] = {
-- 	                                                     [1] = total_allocated,
-- 	                                                     [2] = count,
-- 	                                                     [3] = depth,
-- 	                                                     [4] = name,
-- 	                                                     },
-- 	                                                 ["allocated"] = {
-- 	                                                     [1] = allocated,
-- 	                                                     [2] = count,
-- 	                                                     [3] = depth,
-- 	                                                     [4] = name,
-- 	                                                     },
-- 	                                                 ["total_time"] = {
-- 	                                                     [1] = total_time,
-- 	                                                     [2] = count,
-- 	                                                     [3] = depth,
-- 	                                                     [4] = name,
-- 	                                                     },
-- 	                                                 },
-- 	                                             ["Verbose"] = {
-- 	                                                 ["__cfx_functionReference"] = s4-carcontrol:5025:112,
-- 	                                                 },
-- 	                                             ["StdOut"] = {
-- 	                                                 ["write_line"] = {
-- 	                                                     ["__cfx_functionReference"] = s4-carcontrol:5025:113,
-- 	                                                     },
-- 	                                                 ["flush"] = {
-- 	                                                     ["__cfx_functionReference"] = s4-carcontrol:5025:114,
-- 	                                                     },
-- 	                                                 },
-- 	                                             ["__index"] = {
-- 	                                                 ["Flat"] = {
-- 	                                                     ["__cfx_functionReference"] = s4-carcontrol:5025:124,
-- 	                                                     },
-- 	                                                 ["Pepperfish"] = {
-- 	                                                     ["__cfx_functionReference"] = s4-carcontrol:5025:125,
-- 	                                                     },
-- 	                                                 ["Sorting"] = {
-- 	                                                     ["time"] = {
-- 	                                                         [1] = time,
-- 	                                                         [2] = count,
-- 	                                                         [3] = depth,
-- 	                                                         [4] = name,
-- 	                                                         },
-- 	                                                     ["count"] = {
-- 	                                                         [1] = count,
-- 	                                                         [2] = depth,
-- 	                                                         [3] = name,
-- 	                                                         },
-- 	                                                     ["total_allocated"] = {
-- 	                                                         [1] = total_allocated,
-- 	                                                         [2] = count,
-- 	                                                         [3] = depth,
-- 	                                                         [4] = name,
-- 	                                                         },
-- 	                                                     ["allocated"] = {
-- 	                                                         [1] = allocated,
-- 	                                                         [2] = count,
-- 	                                                         [3] = depth,
-- 	                                                         [4] = name,
-- 	                                                         },
-- 	                                                     ["total_time"] = {
-- 	                                                         [1] = total_time,
-- 	                                                         [2] = count,
-- 	                                                         [3] = depth,
-- 	                                                         [4] = name,
-- 	                                                         },
-- 	                                                     },
-- 	                                                 ["Verbose"] = {
-- 	                                                     ["__cfx_functionReference"] = s4-carcontrol:5025:120,
-- 	                                                     },
-- 	                                                 ["StdOut"] = {
-- 	                                                     ["write_line"] = {
-- 	                                                         ["__cfx_functionReference"] = s4-carcontrol:5025:121,
-- 	                                                         },
-- 	                                                     ["flush"] = {
-- 	                                                         ["__cfx_functionReference"] = s4-carcontrol:5025:122,
-- 	                                                         },
-- 	                                                     },
-- 	                                                 ["__index"] = {
-- 	                                                    ["Flat"] = {
-- 	                                                        ["__cfx_functionReference"] = s4-carcontrol:5025:132,
-- 	                                                        },
-- 	                                                    ["Pepperfish"] = {
-- 	                                                        ["__cfx_functionReference"] = s4-carcontrol:5025:133,
-- 	                                                        },
-- 	                                                    ["Sorting"] = {
-- 	                                                        ["time"] = {
-- 	                                                            [1] = time,
-- 	                                                            [2] = count,
-- 	                                                            [3] = depth,
-- 	                                                            [4] = name,
-- 	                                                            },
-- 	                                                        ["count"] = {
-- 	                                                            [1] = count,
-- 	                                                            [2] = depth,
-- 	                                                            [3] = name,
-- 	                                                            },
-- 	                                                        ["total_allocated"] = {
-- 	                                                            [1] = total_allocated,
-- 	                                                            [2] = count,
-- 	                                                            [3] = depth,
-- 	                                                            [4] = name,
-- 	                                                            },
-- 	                                                        ["allocated"] = {
-- 	                                                            [1] = allocated,
-- 	                                                            [2] = count,
-- 	                                                            [3] = depth,
-- 	                                                            [4] = name,
-- 	                                                            },
-- 	                                                        ["total_time"] = {
-- 	                                                            [1] = total_time,
-- 	                                                            [2] = count,
-- 	                                                            [3] = depth,
-- 	                                                            [4] = name,
-- 	                                                            },
-- 	                                                        },
-- 	                                                    ["Verbose"] = {
-- 	                                                        ["__cfx_functionReference"] = s4-carcontrol:5025:128,
-- 	                                                        },
-- 	                                                    ["StdOut"] = {
-- 	                                                        ["write_line"] = {
-- 	                                                            ["__cfx_functionReference"] = s4-carcontrol:5025:129,
-- 	                                                            },
-- 	                                                        ["flush"] = {
-- 	                                                            ["__cfx_functionReference"] = s4-carcontrol:5025:130,
-- 	                                                            },
-- 	                                                        },
-- 	                                                    ["__index"] = {
-- 	                                                        ["Flat"] = {
-- 	                                                            ["__cfx_functionReference"] = s4-carcontrol:5025:140,
-- 	                                                            },
-- 	                                                        ["Pepperfish"] = {
-- 	                                                            ["__cfx_functionReference"] = s4-carcontrol:5025:141,
-- 	                                                            },
-- 	                                                        ["Sorting"] = {
-- 	                                                            },
-- 	                                                        ["Verbose"] = {
-- 	                                                            ["__cfx_functionReference"] = s4-carcontrol:5025:136,
-- 	                                                            },
-- 	                                                        ["StdOut"] = {
-- 	                                                            ["write_line"] = {
-- 	                                                                ["__cfx_functionReference"] = s4-carcontrol:5025:137,
-- 	                                                                },
-- 	                                                            ["flush"] = {
-- 	                                                                ["__cfx_functionReference"] = s4-carcontrol:5025:138,
-- 	                                                                },
-- 	                                                            },
-- 	                                                        ["__index"] = {
-- 	                                                            ["New"] = {
-- 	                                                                ["__cfx_functionReference"] = s4-carcontrol:5025:148,
-- 	                                                                },
-- 	                                                            ["CreateByteUnits"] = {
-- 	                                                                ["__cfx_functionReference"] = s4-carcontrol:5025:142,
-- 	                                                                },
-- 	                                                            ["Callgrind"] = {
-- 	                                                                ["__cfx_functionReference"] = s4-carcontrol:5025:143,
-- 	                                                                },
-- 	                                                            ["CreateTimeUnits"] = {
-- 	                                                                ["__cfx_functionReference"] = s4-carcontrol:5025:145,
-- 	                                                                },
-- 	                                                            ["Verbose"] = {
-- 	                                                                ["__cfx_functionReference"] = s4-carcontrol:5025:144,
-- 	                                                                },
-- 	                                                            ["Pepperfish"] = {
-- 	                                                                ["__cfx_functionReference"] = s4-carcontrol:5025:147,
-- 	                                                                },
-- 	                                                            ["Flat"] = {
-- 	                                                                ["__cfx_functionReference"] = s4-carcontrol:5025:146,
-- 	                                                                },
-- 	                                                            },
-- 	                                                        ["CreateTimeUnits"] = {
-- 	                                                            ["__cfx_functionReference"] = s4-carcontrol:5025:139,
-- 	                                                            },
-- 	                                                        ["New"] = {
-- 	                                                            ["__cfx_functionReference"] = s4-carcontrol:5025:149,
-- 	                                                             },
-- 	                                                         ["CreateByteUnits"] = {
-- 	                                                             ["__cfx_functionReference"] = s4-carcontrol:5025:134,
-- 	                                                             },
-- 	                                                         ["Callgrind"] = {
-- 	                                                             ["__cfx_functionReference"] = s4-carcontrol:5025:135,
-- 	                                                             },
-- 	                                                         },
-- 	                                                     ["CreateTimeUnits"] = {
-- 	                                                         ["__cfx_functionReference"] = s4-carcontrol:5025:131,
-- 	                                                         },
-- 	                                                     ["New"] = {
-- 	                                                         ["__cfx_functionReference"] = s4-carcontrol:5025:150,
-- 	                                                         },
-- 	                                                     ["CreateByteUnits"] = {
-- 	                                                         ["__cfx_functionReference"] = s4-carcontrol:5025:126,
-- 	                                                         },
-- 	                                                     ["Callgrind"] = {
-- 	                                                         ["__cfx_functionReference"] = s4-carcontrol:5025:127,
-- 	                                                         },
-- 	                                                     },
-- 	                                                 ["CreateTimeUnits"] = {
-- 	                                                     ["__cfx_functionReference"] = s4-carcontrol:5025:123,
-- 	                                                     },
-- 	                                                 ["New"] = {
-- 	                                                     ["__cfx_functionReference"] = s4-carcontrol:5025:151,
-- 	                                                     },
-- 	                                                 ["CreateByteUnits"] = {
-- 	                                                     ["__cfx_functionReference"] = s4-carcontrol:5025:118,
-- 	                                                     },
-- 	                                                 ["Callgrind"] = {
-- 	                                                     ["__cfx_functionReference"] = s4-carcontrol:5025:119,
-- 	                                                     },
-- 	                                                 },
-- 	                                             ["CreateTimeUnits"] = {
-- 	                                                 ["__cfx_functionReference"] = s4-carcontrol:5025:115,
-- 	                                                 },
-- 	                                             ["New"] = {
-- 	                                                 ["__cfx_functionReference"] = s4-carcontrol:5025:152,
-- 	                                                 },
-- 	                                             ["CreateByteUnits"] = {
-- 	                                                 ["__cfx_functionReference"] = s4-carcontrol:5025:110,
-- 	                                                 },
-- 	                                             ["Callgrind"] = {
-- 	                                                 ["__cfx_functionReference"] = s4-carcontrol:5025:111,
-- 	                                                 },
-- 	                                             },
-- 	                                         ["CreateTimeUnits"] = {
-- 	                                             ["__cfx_functionReference"] = s4-carcontrol:5025:107,
-- 	                                             },
-- 	                                         ["New"] = {
-- 	                                             ["__cfx_functionReference"] = s4-carcontrol:5025:153,
-- 	                                             },
-- 	                                         ["CreateByteUnits"] = {
-- 	                                             ["__cfx_functionReference"] = s4-carcontrol:5025:102,
-- 	                                             },
-- 	                                         ["Callgrind"] = {
-- 	                                             ["__cfx_functionReference"] = s4-carcontrol:5025:103,
-- 	                                             },
-- 	                                         },
-- 	                                     ["CreateTimeUnits"] = {
-- 	                                         ["__cfx_functionReference"] = s4-carcontrol:5025:99,
-- 	                                         },
-- 	                                     ["New"] = {
-- 	                                         ["__cfx_functionReference"] = s4-carcontrol:5025:154,
-- 	                                         },
-- 	                                     ["CreateByteUnits"] = {
-- 	                                         ["__cfx_functionReference"] = s4-carcontrol:5025:94,
-- 	                                         },
-- 	                                     ["Callgrind"] = {
-- 	                                         ["__cfx_functionReference"] = s4-carcontrol:5025:95,
-- 	                                         },
-- 	                                     },
-- 	                                 ["CreateTimeUnits"] = {
-- 	                                     ["__cfx_functionReference"] = s4-carcontrol:5025:91,
-- 	                                     },
-- 	                                 ["New"] = {
-- 	                                     ["__cfx_functionReference"] = s4-carcontrol:5025:155,
-- 	                                     },
-- 	                                 ["CreateByteUnits"] = {
-- 	                                     ["__cfx_functionReference"] = s4-carcontrol:5025:86,
--                                     },
--                                 ["Callgrind"] = {
--                                     ["__cfx_functionReference"] = s4-carcontrol:5025:87,
--                                     },
--                                 },
--                             ["CreateTimeUnits"] = {
--                                 ["__cfx_functionReference"] = s4-carcontrol:5025:83,
--                                 },
--                             ["New"] = {
--                                 ["__cfx_functionReference"] = s4-carcontrol:5025:156,
--                                 },
--                             ["CreateByteUnits"] = {
--                                 ["__cfx_functionReference"] = s4-carcontrol:5025:78,
--                                 },
--                             ["Callgrind"] = {
--                                 ["__cfx_functionReference"] = s4-carcontrol:5025:79,
--                                 },
--                             },
--                         ["CreateTimeUnits"] = {
--                             ["__cfx_functionReference"] = s4-carcontrol:5025:75,
--                             },
--                         ["New"] = {
--                             ["__cfx_functionReference"] = s4-carcontrol:5025:157,
--                             },
--                         ["CreateByteUnits"] = {
--                             ["__cfx_functionReference"] = s4-carcontrol:5025:70,
--                             },
--                         ["Callgrind"] = {
--                             ["__cfx_functionReference"] = s4-carcontrol:5025:71,
--                             },
--                         },
--                     ["CreateTimeUnits"] = {
--                         ["__cfx_functionReference"] = s4-carcontrol:5025:67,
--                         },
--                     ["New"] = {
--                         ["__cfx_functionReference"] = s4-carcontrol:5025:158,
--                         },
--                     ["CreateByteUnits"] = {
--                         ["__cfx_functionReference"] = s4-carcontrol:5025:62,
--                         },
--                     ["Callgrind"] = {
--                         ["__cfx_functionReference"] = s4-carcontrol:5025:63,
--                         },
--                     },
--                 ["CreateTimeUnits"] = {
--                     ["__cfx_functionReference"] = s4-carcontrol:5025:59,
--                     },
--                 ["New"] = {
--                     ["__cfx_functionReference"] = s4-carcontrol:5025:159,
--                     },
--                 ["CreateByteUnits"] = {
--                     ["__cfx_functionReference"] = s4-carcontrol:5025:54,
--                     },
--                 ["Callgrind"] = {
--                     ["__cfx_functionReference"] = s4-carcontrol:5025:55,
--                     },
--                 },
--             ["CreateTimeUnits"] = {
--                 ["__cfx_functionReference"] = s4-carcontrol:5025:51,
--                 },
--             ["New"] = {
--                 ["__cfx_functionReference"] = s4-carcontrol:5025:160,
--                 },
--             ["CreateByteUnits"] = {
--                 ["__cfx_functionReference"] = s4-carcontrol:5025:46,
--                 },
--             ["Callgrind"] = {
--                 ["__cfx_functionReference"] = s4-carcontrol:5025:47,
--                 },
--             },
--         ["CreateTimeUnits"] = {
--             ["__cfx_functionReference"] = s4-carcontrol:5025:43,
--             },
--         ["New"] = {
--             ["__cfx_functionReference"] = s4-carcontrol:5025:161,
--             },
--         ["CreateByteUnits"] = {
--             ["__cfx_functionReference"] = s4-carcontrol:5025:38,
--             },
--         ["Callgrind"] = {
--             ["__cfx_functionReference"] = s4-carcontrol:5025:39,
--             },
--         },
--     ["CreateTimeUnits"] = {
--         ["__cfx_functionReference"] = s4-carcontrol:5025:35,
--         },
--     ["New"] = {
--         ["__cfx_functionReference"] = s4-carcontrol:5025:162,
--         },
--     ["CreateByteUnits"] = {
--         ["__cfx_functionReference"] = s4-carcontrol:5025:30,
--         },
--     ["Callgrind"] = {
--         ["__cfx_functionReference"] = s4-carcontrol:5025:31,
--          },
--      },
--  ["ResultAsInteger"] = {
--      ["__cfx_functionReference"] = s4-carcontrol:5025:3,
--      },
--  ["SetTickRoutine"] = {
--      ["__cfx_functionReference"] = s4-carcontrol:5025:5,
--      },
--  ["GetFunctionReference"] = {
--      ["__cfx_functionReference"] = s4-carcontrol:5025:22,
--      },
--  ["PointerValueIntInitialized"] = {
--      ["__cfx_functionReference"] = s4-carcontrol:5025:28,
--      },
--  ["SetDuplicateRefRoutine"] = {
--      ["__cfx_functionReference"] = s4-carcontrol:5025:13,
--      },
--  ["CreateThreadNow"] = {
--      ["__cfx_functionReference"] = s4-carcontrol:5025:4,
--      },
--  ["ResultAsFloat"] = {
--      ["__cfx_functionReference"] = s4-carcontrol:5025:27,
--      },
--  ["ResultAsString"] = {
--      ["__cfx_functionReference"] = s4-carcontrol:5025:10,
--      },
--  ["ResultAsVector"] = {
--      ["__cfx_functionReference"] = s4-carcontrol:5025:23,
--      },
--  ["ResultAsObject"] = {
--      ["__cfx_functionReference"] = s4-carcontrol:5025:9,
--      },
--  ["SetStackTraceRoutine"] = {
--      ["__cfx_functionReference"] = s4-carcontrol:5025:12,
--      },
--  }
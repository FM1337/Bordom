resetting = false;


function softReset()
	-- count to 10 before soft resetting
	i = 0
	while true do
		i = i+1;
		emu.frameadvance();
		if i >= math.random(100) then
			local input = {};
			input['A'] = true;
			input['B'] = true;
			input['Start'] = true;
			input['Select'] = true;
			joypad.set(input)
			resetting = false;
			break
		end
	end

end

function checkShiny()
	if memory.readbyte(0x9861) == 198 then
		-- it is shiny
		console.log("found shiny")
		return true;
	else
		-- not shiny
		return false;
	end
end

-- Reads 0x9902 looking for 0x80, if 0x80 then we're on the nickname screen
-- Also check to see if 0x9800 is equal to 96 (0x60)
function onNickname()
	if memory.readbyte(0x9902) == 128 and memory.readbyte(0x9800) == 96 then
		return true;
	else
		return false;
	end
end


-- Map address is maybe 0x9861 for the locaiton of where the shiny sprite 
-- should be on the nickname screen
-- value is 127 when no shiny symbol
-- 198 when shiny which is C6 which is what we want

-- When on nickname screen, the BG map address we wanna inspect is 0x9902 which should contain
-- 0x80 which is 128, when I wasn't on there, I got 17, let's see what I get when on there
-- yup got 128, perfect

-- 0x9A32 will contain the V (tilemap is 0xEE which is 238) when A needs to be pushed
-- and when we're at a yes prompt (which should be by default on nickname)
-- then 0x990F should be 0xED (or 237) 
function pressButton(button)
	local input = {};
	input[button] = true;
	joypad.set(input)
end


-- Set this to true when you're ready to shiny reset on gift/starter
-- make sure the game is set to jump right in and not go to the title screen pls
local shinyResetNickname = true;
console.log(string.format("Started shiny hunt at %s", os.date("%Y/%m/%d @ %H:%M:%S")))
shinyResetCount = 0;
foundShiny = false;
seen = {}
while true do
	if foundShiny then
		break;
	end
	emu.frameadvance();
	if shinyResetNickname then
		-- Check if we need to press A
		if memory.readbyte(0x9A32) == 238 or memory.readbyte(0x990F) == 237 then
			pressButton("A")
		elseif onNickname() then
			if not checkShiny() and not resetting then
				atk = tonumber(string.sub(string.format("%x", memory.readbyte(0xDCF4)), 1, 1), 16)
				def = tonumber(string.sub(string.format("%x", memory.readbyte(0xDCF4)), 2, 2), 16)
				spd = tonumber(string.sub(string.format("%x", memory.readbyte(0xDCF5)), 1, 1), 16)
				spc = tonumber(string.sub(string.format("%x", memory.readbyte(0xDCF5)), 2, 2), 16)
				if atk and def and spd and spc then
					if not seen[string.format("%s %s %s %s", atk, def, spd, spc)] then
						console.log(string.format("%s %s %s %s", atk, def, spd, spc))
						seen[string.format("%s %s %s %s", atk, def, spd, spc)] = 1
					else
						seen[string.format("%s %s %s %s", atk, def, spd, spc)] = seen[string.format("%s %s %s %s", atk, def, spd, spc)] + 1
					end
				end
				-- set resetting
				resetting = true;
				-- soft reset
				softReset()
				-- add 1 to shiny reset count
				shinyResetCount = shinyResetCount + 1;
				-- print out attempt number
			else
				if not foundShiny then
					-- set foundShiny to true
					foundShiny = true
					-- print out how many resets it took
					console.log("This time, resetting for a shiny took", shinyResetCount, "resets")
					-- print out the amount of DV combinations seen
					console.log(seen);
					console.log(string.format("Finished shiny hunt at %s", os.date("%Y/%m/%d @ %H:%M:%S")))
					
				end
			end
		end
	end
end

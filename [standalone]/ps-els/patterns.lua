--[[
This configuration table is used to define the light patterns for emergency vehicles. The table contains different pattern groups, each containing multiple patterns with their corresponding light sequences for the vehicle's extras. In this case, there is only one pattern group named "default."

Each pattern group has a series of patterns defined by an index (1, 2, 3, etc.), and each pattern has a name attribute. The name attribute is used for reference and will be displayed on the ELS Panel.

Within each pattern, there are a series of numbered keys (1, 2, 3, etc.) corresponding to the "frame" of the "animation". The value for each extra is a string composed of 1s and 0s, where each character in the string represents a light state for a specific frame in the pattern.
    1 means the light is ON in the corresponding frame.
    0 means the light is OFF in the corresponding frame.

For example, in pattern 1 with the name "NORMAL", extra 1 has the following pattern: "000000111111000000111111000000111111".

This means that for the first 6 frames, the light will be OFF (0s), then it will be ON for the next 6 frames (1s), followed by 6 frames of OFF and another 6 frames of ON. This sequence will repeat as the pattern is played.

To create custom patterns, you can add or modify the patterns within a pattern group. To do so, simply modify the sequences of 1s and 0s for each extra in the pattern. While it's recommended to keep the length of the strings consistent for all extras within a specific pattern to maintain continuity, it's not mandatory. You can make an "animation" as long or as short as you want, as it will just repeat. However, do keep in mind that different patterns can have different lengths, but it is advisable to maintain the same length for each extra within a specific pattern for a smoother appearance.
]]

Config.patternGroups = {
    {
        -- This would be pattern group one. By default all cars use pattern group one. In the future you will be able to change this, but right now if you want different patterns, just add/edit/remove patterns in this group.
        name = "default", -- Can be anything you want, not used atm just for reference. Will be used in the future if you want to change the pattern group on a vehicle.
        [1] = {
            -- Pattern 1
            name = "NORMAL", -- This is the name of the specific pattern. These are the names that you see on the ELS Panel.
            [1] = "000000111111000000111111000000111111", -- Frame 1
            [2] = "111000111000111000111000111000111000", -- Frame 2
            [3] = "000111000111000111000111000111000111", -- Frame 3
            [4] = "111111000000111111000000111111000000", -- Frame 4
            [5] = "111000111000111000111000111000111000", -- Frame 5
            [6] = "000111000111000111000111000111000111", -- Frame 6
            [7] = "100000110001100000000001100011000001", -- Frame 7
            [8] = "011100000100000111111000001000001110", -- Frame 8
            [9] = "100000110001100000000001100011000001", -- Frame 9
            [10] = "111111000000111111000000111111000000", -- Frame 10
            [11] = "111111000000111111000000111111000000", -- Frame 11
            [12] = "111111000000111111000000111111000000", -- Frame 12
            [13] = "111111000000111111000000111111000000", -- Frame 13
            [14] = "111111000000111111000000111111000000" -- Frame 14
        },
        [2] = {
            -- Pattern 2
            name = "LEFT", -- This is the name of the specific pattern. These are the names that you see on the ELS Panel.
            [1] = "000000000111111", -- Frame 1
            [2] = "000000111111000", -- Frame 2
            [3] = "000111111000000", -- Frame 3
            [4] = "111111000000000", -- Frame 4
            [5] = "000001111100000", -- Frame 5
            [6] = "111000111000111", -- Frame 6
            [7] = "000000000111111", -- Frame 7
            [8] = "000011111110000", -- Frame 8
            [9] = "111111000000000", -- Frame 9
            [10] = "101101001011010", -- Frame 10
            [11] = "101101001011010", -- Frame 11
            [12] = "101101001011010", -- Frame 12
            [13] = "101101001011010", -- Frame 13
            [14] = "101101001011010" -- Frame 14
        },
        [3] = {
            -- Pattern 3
            name = "RIGHT", -- This is the name of the specific pattern. These are the names that you see on the ELS Panel.
            [1] = "111111000000000", -- Frame 1
            [2] = "000111111000000", -- Frame 2
            [3] = "000000111111000", -- Frame 3
            [4] = "000000000111111", -- Frame 4
            [5] = "111000111000111", -- Frame 5
            [6] = "000001111100000", -- Frame 6
            [7] = "111111000000000", -- Frame 7
            [8] = "000011111110000", -- Frame 8
            [9] = "000000000111111", -- Frame 9
            [10] = "101101001011010", -- Frame 10
            [11] = "101101001011010", -- Frame 11
            [12] = "101101001011010", -- Frame 12
            [13] = "101101001011010", -- Frame 13
            [14] = "101101001011010" -- Frame 14
        },
        [4] = {
            -- Pattern 4
            name = "STDBRN", -- This is the name of the specific pattern. These are the names that you see on the ELS Panel.
            [1] = "11111111111111111", -- Frame 1
            [2] = "11111111111111111", -- Frame 2
            [3] = "11111111111111111", -- Frame 3
            [4] = "11111111111111111", -- Frame 4
            [5] = "11111111111111111", -- Frame 5
            [6] = "11111111111111111", -- Frame 6
            [7] = "11111111111111111", -- Frame 7
            [8] = "11111111111111111", -- Frame 8
            [9] = "11111111111111111", -- Frame 9
            [10] = "11111111111111111", -- Frame 10
            [11] = "11111111111111111", -- Frame 11
            [12] = "11111111111111111", -- Frame 12
            [13] = "11111111111111111", -- Frame 13
            [14] = "11111111111111111" -- Frame 14
        }
    }
}
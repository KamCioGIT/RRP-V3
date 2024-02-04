--------------------------------------------------------------------------------
-- defineSiren({wavfilenames}, awcname, dlcname) --
-- horn first, then all other tones in order. up to 6 sirens 1 horn. --

-- local c3rls = defineSiren({"C3RLS_ALPHA", "C3RLS_BRAVO", "C3RLS_CHARLIE", "C3RLS_DELTA", "C3RLS_ECHO"}, "C3RLS", "dlc_c3rls")
-- local pathfinder = defineSiren({"PATHFINDER_HORN", "PATHFINDER_WAIL", "PATHFINDER_YELP", "PATHFINDER_SIREN_2", "PATHFINDER_PRIORITY"}, "PATHFINDER", "dlc_pathfinder")
-- local nypd = defineSiren({"NYPD_HORN", "NYPD_WAIL", "NYPD_YELP", "NYPD_SIREN_2", "NYPD_PRIORITY", "NYPD_POLICE_WARNING", "NYPD_PULSAR"}, "NYPD", "dlc_nypd")
-- local cencomsaph = defineSiren( { '1', '2', '3', '4', '5', '6', '7', }, 'cencomsaph', 'dlc_cencomsaph' )

-- NOTE: The last siren to be defined will be the default siren for all ELS vehicles. --
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- applySiren(spawncode, definedsiren) --

-- applySiren("SSTRAFFIC", nypd) -- gives spawncode "SSTRAFFIC" the NYPD siren
--------------------------------------------------------------------------------
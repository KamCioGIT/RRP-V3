Config = {}

Config.debug = true

--- SETTINGS FOR ESX
Config.esxSettings = {
    enabled = false,
    -- Whether or not to use the new ESX export method
    useNewESXExport = true,

    oldEsx = false, -- use this when on a very old version of esx
}

--- SETTINGS FOR QBCORE
Config.qbSettings = {
    enabled = true,
    useNewQBExport = true, -- Make sure to uncomment the old export inside fxmanifest.lua if you're still using it
}


Config.sql = {
    driver = 'oxmysql', -- oxmysql or ghmattimysql or mysql
    -- If you're using an older version of oxmysql set this to false
    newOxMysql = true,
}


-- I DO NOT RECOMMEND USING TARGET AS SOME SMALLER PROPS MAY BE DIFFICULT TO PICKUP FROM THE TRUCK BED (USING CERTAIN TARGET SYSTEMS)
Config.target = {
    enabled = false,
    system = 'ox_target' -- 'qtarget' or 'qb-target' or 'ox_target'  (Other systems might work as well)
}

-- Saving placed items in the database
Config.objectPersistence = {
    -- Whether the script should save items placed on the ground in the database and load them back up after restart
    enabled = true,

    -- Whether to show warnings when items that somehow got duplicated by an client got picked up twice
    -- (The players wont receive the duplicated item regardless)
    showWarnings = true,

    -- Whether to display a little hint when placing an item which will be persistent
    showHint = false,
}

-- When not using target
-- '3d-text', 'top-left', 'help-text'
Config.inputType = '3d-text'

-- Font used for the 3d text
Config.textFont = 4

-- Scale used for the 3d text
Config.textScale = 1.0

-- Outline shown on props that the player can pickup
Config.outline = {
    enabled = true,
    color = {
        r = 126,
        g = 207,
        b = 147,
        a = 144,
    }
}

-- The opacity of the placement box color
Config.boxOpacity = 150

-- Command which will open the "place an item" menu
Config.menuCommand = {
    enabled = true,
    command = 'placeitem',
    
    aliasEnabled = true,
    aliasCommand = 'pi',
}

-- Whether or not to disable item stacking (placing items on top of other items)
-- This can rarely cause collision issues with some vehicles. Therefore its off by default
Config.disallowItemStacking = false

-- Whether or not to make all items placeable.
-- When disabled only the items defined below will be placeable
Config.makeEverythingPlaceable = {
    enabled = false,
    fallbackProp = 'hei_prop_heist_box',
}

-- Whether or not players will be allowed to place items on roofs of cars
Config.allowPlacingOnRoofs = true

-- All placeable items with the amounts and props defined
-- https://gta-objects.xyz/objects
Config.items = {
    --dildo
    ['dildo'] = {
        [1] = 'prop_cs_dildo_01',
    },
    ['phone'] = {
        [1] = 'prop_player_phone_01',
    },
	['laptop'] = {
        [1] = 'prop_laptop_02_closed',
	},
	--weapons
	['weapon_bat'] = {
        [1] = 'p_cs_bbbat_01',
	},
	['weapon_crowbar'] = {
        [1] = 'prop_ing_crowbar',
	},
	['weapon_pistol'] = {
        [1] = 'w_pi_pistol',
	},
	['weapon_pistolxm3'] = {
        [1] = 'w_pi_heavypistol',
	},
	['weapon_petrolcan'] = {
        [1] = 'w_am_jerrycan',
	},
	['clip_attachment'] = {
        [1] = 'w_pi_pistol_mag1',
	},
	['clip_attachment'] = {
        [1] = 'w_pi_pistol_mag1',
	},
	--ammo
	['pistol_ammo'] = {
        [1] = 'prop_ld_ammo_pack_01',
	},
	--drink
	['water_bottle'] = {
        [1] = 'apa_mp_h_acc_bottle_01',
	},
	['coffee'] = {
        [1] = 'p_ing_coffeecup_01',
	},
	['kurkakola'] = {
        [1] = 'prop_ecola_can',
	},
	['beer'] = {
        [1] = 'prop_beer_am',
	},
	['whiskey'] = {
        [1] = 'prop_whiskey_bottle',
	},
	['vodka'] = {
        [1] = 'prop_vodka_bottle',
	},
	['grape'] = {
        [1] = 'p_kitch_juicer_s',
	},
	['wine'] = {
        [1] = 'prop_wine_rose',
	},
	['grapejuice'] = {
        [1] = 'ng_proc_brkbottle_02a',
	},
	--Drugs
	['joint'] = {
        [1] = 'prop_sh_joint_01',
	},
	['cokebaggy'] = {
        [1] = 'prop_coke_block_half_b',
	},
	['crack_baggy'] = {
        [1] = 'prop_coke_block_half_a',
	},
	['xtcbaggy'] = {
        [1] = 'ex_office_swag_pills1',
	},
	['coke_brick'] = {
        [1] = 'bkr_prop_coke_block_01a',
	},
	['weed_brick'] = {
        [1] = 'hei_prop_heist_weed_block_01b',
	},
	['coke_small_brick'] = {
        [1] = 'imp_prop_impexp_boxcoke_01',
	},
	['oxy'] = {
        [1] = 'hei_prop_pill_bag_01',
	},
	['meth'] = {
        [1] = 'bkr_prop_meth_smallbag_01a',
	},
	['rolling_paper'] = {
        [1] = 'p_cs_papers_02',
	},
	--Weed 
	['weed_purplehaze'] = {
        [1] = 'bkr_prop_weed_smallbag_01a',
	},
	['empty_weed_bag'] = {
        [1] = 'bkr_prop_weed_bag_01a',
	},
	['weed_nutrition'] = {
        [1] = 'bkr_prop_weed_spray_01a',
	},
	--Material
	['plastic'] = {
        [1] = 'prop_yell_plastic_target',
	},
	['metalscrap'] = {
        [1] = 'prop_ld_scrap',
	},
	['glass'] = {
        [1] = 'gr_dlc_gr_yacht_props_glass_04',
	},
	--Tools
	['drill'] = {
        [1] = 'gr_prop_gr_drill_01a',
	},
	['screwdriverset'] = {
        [1] = 'prop_tool_screwdvr01',
	},
	-- Vehicle Tools
	['repairkit'] = {
        [1] = 'prop_tool_box_04',
	},
	['advancedrepairkit'] = {
        [1] = 'imp_prop_tool_chest_01a',
	},
	['cleaningkit'] = {
        [1] = 'prop_sponge_01',
	},
	['tunerlaptop'] = {
        [1] = 'gr_prop_gr_laptop_01c',
	},
	['harness'] = {
        [1] = 'p_mrk_harness_s',
	},
	['jerry_can'] = {
        [1] = 'prop_jerrycan_01a',
	},
	['tirerepairkit'] = {
        [1] = 'imp_prop_wheel_balancer_01a',
	},
	-- Mechanic Parts
	['veh_toolbox'] = {
        [1] = 'imp_prop_tool_cabinet_01b',
	},
	['veh_engine'] = {
        [1] = 'prop_car_engine_01',
	},
	['veh_transmission'] = {
        [1] = 'imp_prop_impexp_gearbox_01',
	},
	['veh_exterior'] = {
        [1] = 'imp_prop_impexp_parts_rack_02a',
	},
	['veh_wheels'] = {
        [1] = 'imp_prop_impexp_wheel_03a',
	},
	['veh_plates'] = {
        [1] = 'p_num_plate_02',
	},
	-- Medication
	['firstaid'] = {
        [1] = 'xm_prop_x17_bag_med_01a',
	},
	['bandage'] = {
        [1] = 'prop_med_bag_01',
	},
	['painkillers'] = {
        [1] = 'v_med_bottles3',
	},
	['walkstick'] = {
        [1] = 'prop_cs_walking_stick',
	},
	-- Communication
	['phone'] = {
        [1] = 'prop_amb_phone',
	},
	['radio'] = {
        [1] = 'prop_cs_hand_radio',
	},
	['laptop'] = {
        [1] = 'p_cs_laptop_02_w',
	},
	['tablet'] = {
        [1] = 'bkr_prop_fakeid_tablet_01a',
	},
	-- Theft and Jewelry
	['rolex'] = {
        [1] = 'p_watch_06',
	},
	['goldbar'] = {
        [1] = 'hei_prop_heist_gold_bar',
	},
    --animals
    ['milk'] = {
        [1] = 'v_res_tt_milk',
    },
    ['egg'] = {
        [1] = 'v_ret_247_eggs',
    },
--fruits

    ['pineapple'] = {
        [1] = 'prop_pineapple',
    },
	
	['lemon'] = {
        [1] = 'prop_bar_lemons',
    },
	
	['cherry'] = {
        [1] = 'apa_mp_h_acc_fruitbowl_02]',
    },
	
	['tomato'] = {
        [1] = 'ex_mp_h_acc_fruitbowl_02',
    },
	
	['coconut'] = {
        [1] = 'ex_mp_h_acc_fruitbowl_01',
    },
	
	['cherry'] = {
        [1] = 'ex_mp_h_acc_fruitbowl_02',
    },
	
	['blueberry'] = {
        [1] = 'ex_mp_h_acc_fruitbowl_01',
    },
	
	['strawberry'] = {
        [1] = 'ex_mp_h_acc_fruitbowl_02',
    },
	
	['apple'] = {
        [1] = 'apa_mp_h_acc_fruitbowl_01',
    },
	
	['orange'] = {
        [1] = 'ex_mp_h_acc_fruitbowl_02',
    },
--crops

	['lettuce'] = {
        [1] = 'prop_veg_crop_03_cab',
    },
	
	['maize'] = {
        [1] = 'v_res_fa_tincorn',
    },
	
	['barley'] = {
        [1] = 'prop_veg_crop_05',
    },
--Jim-Recycle Items
	
	['kq_outfitbag'] = {
        [1] = 'prop_nigel_bag_pickup',
    },
	
	['can'] = {
        [1] = 'v_res_tt_can03',
    },
	
	['recyclablematerial'] = {
        [1] = 'prop_woodpile_03a',
    },
--jim-mining stuff

	['can'] = {
        [1] = 'v_res_tt_cancrsh02',
    },
	
	['bottle'] = {
        [1] = 'watercooler_bottle001',
    },
	
	['pan'] = {
        [1] = 'prop_copper_pan',
    },
	
	['drillbit'] = {
        [1] = 'gr_prop_gr_part_drill_01a',
    },
	
	['miningdrill'] = {
        [1] = 'hei_prop_heist_drill',
    },
	
	['pickaxe'] = {
        [1] = 'prop_tool_pickaxe',
    },
	
	['silveringot'] = {
        [1] = 'ex_office_swag_silver',
    },
	
	['goldingot'] = {
        [1] = 'hei_prop_heist_gold_bar',
    },
	
	['silverearring'] = {
        [1] = 'p_tmom_earrings_s',
    },
	
	['silverchain'] = {
        [1] = 'p_stretch_necklace_s',
    },
	
	['goldchain'] = {
        [1] = 'p_ortega_necklace_s',
    },
--Repair Parts

	['newoil'] = {
        [1] = 'prop_oilcan_01a',
    },
	
	['carbattery'] = {
        [1] = 'prop_car_battery_01',
    },
	
	['sparetire'] = {
        [1] = 'prop_rub_wheel_01',
    },
--Cosmetics 

	['underglow_controller'] = {
        [1] = 'v_res_tre_remote',
    },
	
	['customplate'] = {
        [1] = 'p_num_plate_03',
    },
	
	['hood'] = {
        [1] = 'imp_prop_impexp_bonnet_02a',
    },
	
	['spoiler'] = {
        [1] = 'imp_prop_impexp_spoiler_03a',
    },
	
	['bumper'] = {
        [1] = 'imp_prop_impexp_front_bumper_02a',
    },
	
	['exhaust'] = {
        [1] = 'imp_prop_impexp_exhaust_02',
    },
	
	['seat'] = {
        [1] = 'prop_ejector_seat_01',
    },
	
	['rims'] = {
        [1] = 'prop_wheel_rim_03',
    },
	
	['paintcan'] = {
        [1] = 'ng_proc_paintcan01a',
    },
	
	['tires'] = {
        [1] = 'prop_rub_wheel_01',
    },
--Vehicle Extra Damage Items

	['cables1'] = {
        [1] = 'prop_cablespool_06',
    },
	
	['cables2'] = {
        [1] = 'prop_cablespool_03',
    },
	
	['cables3'] = {
        [1] = 'prop_tool_cable02',
    },
	
	['fueltank1'] = {
        [1] = 'prop_byard_gastank01',
    },
	
	['cylind2'] = {
        [1] = 'prop_gascyl_02a',
    },
	
	['cylind3'] = {
        [1] = 'prop_gascyl_01a',
    },
-- Other Tools

	['casinochips'] = {
        [1] = 'ng_proc_concchips01',
    },
	
	['moneybag'] = {
        [1] = 'prop_big_bag_01',
    },
	
	['parachute'] = {
        [1] = 'p_parachute_s_shop',
    },
	
	['lighter'] = {
        [1] = 'ex_prop_exec_lighter_01',
    },
	
	['markedbills'] = {
        [1] = 'bkr_prop_cutter_moneystack_01a',
    },
	
	['labkey'] = {
        [1] = 'bkr_prop_jailer_keys_01a',
    },
	
	['printerdocument'] = {
        [1] = 'ng_proc_paper_news_rag',
    },
	
	['newscam'] = {
        [1] = 'prop_pap_camera_01',
    },
	
	['newsmic'] = {
        [1] = 'p_ing_microphonel_01',
    },
--sea tools 

	['dendrogyra_coral'] = {
        [1] = 'prop_coral_pillar_01',
    },
	
	['antipatharia_coral'] = {
        [1] = 'prop_coral_kelp_04',
    },
	
	['diving_gear'] = {
        [1] = 'p_s_scuba_tank_s',
    },
	
	['diving_fill'] = {
        [1] = 'p_michael_scuba_tank_s',
    },
--Firework Tools

	['firework1'] = {
        [1] = 'ind_prop_firework_03',
    },
	
	['firework2'] = {
        [1] = 'w_lr_firework_rocket',
    },
	
	['firework3'] = {
        [1] = 'ind_prop_firework_01',
    },
	
	['firework4'] = {
        [1] = 'ind_prop_firework_02',
    },

    -- Golf Ball
	['golf_ball'] = {
        [1] = 'prop_golf_ball',
    },
	
	-- Housing
	-- Sofa
	['sofas1'] = {
        [1] = 'apa_mp_h_stn_sofacorn_01',
        [2] = 'apa_mp_h_stn_sofacorn_05',
        [3] = 'apa_mp_h_stn_sofacorn_06',
        [4] = 'apa_mp_h_stn_sofacorn_07',
        [5] = 'apa_mp_h_stn_sofacorn_08',
        [6] = 'apa_mp_h_stn_sofacorn_09',
        [7] = 'apa_mp_h_stn_sofacorn_10',
    },
	['sofas2'] = {
        [1] = 'apa_mp_h_stn_sofa2seat_02',
        [2] = 'hei_heist_stn_sofa2seat_03',
        [3] = 'hei_heist_stn_sofa2seat_06',
    },
	['sofas3'] = {
        [1] = 'hei_heist_stn_sofacorn_05',
        [2] = 'hei_heist_stn_sofacorn_06',
    },
	['sofas4'] = {
        [1] = 'apa_mp_h_stn_sofa_daybed_01',
        [2] = 'apa_mp_h_stn_sofa_daybed_02',
    },
	['sofas5'] = {
        [1] = 'apa_mp_h_yacht_sofa_01',
        [2] = 'apa_mp_h_yacht_sofa_02',
        [3] = 'p_yacht_sofa_01_s',
        [4] = 'prop_yaught_sofa_01',
        [5] = 'p_yacht_sofa_01_s',
    },
	['sofas6'] = {
        [1] = 'ex_mp_h_off_sofa_003',
        [2] = 'ex_mp_h_off_sofa_01',
        [3] = 'ex_mp_h_off_sofa_02',
    },
	['sofas7'] = {
        [1] = 'hei_heist_stn_sofa3seat_01',
        [2] = 'hei_heist_stn_sofa3seat_02',
        [3] = 'hei_heist_stn_sofa3seat_06',
    },
	['sofas8'] = {
        [1] = 'prop_t_sofa',
        [2] = 'prop_t_sofa_02',
    },
	['sofas9'] = {
        [1] = 'v_tre_sofa_mess_b_s',
        [2] = 'v_tre_sofa_mess_c_s',
        [3] = 'xm_lab_sofa_01',
        [4] = 'xm_lab_sofa_02',
    },
	['sofas10'] = {
        [1] = 'prop_bench_01a',
        [2] = 'prop_bench_01b',
        [3] = 'prop_bench_01c',
        [4] = 'prop_bench_02',
        [5] = 'prop_bench_03',
        [6] = 'prop_bench_04',
        [7] = 'prop_bench_05',
        [8] = 'prop_bench_08',
        [8] = 'prop_bench_10',
        [8] = 'prop_bench_11',
    },
	['sofas11'] = {
        [1] = 'bkr_prop_clubhouse_sofa_01a',
    },
	['sofas12'] = {
        [1] = 'imp_prop_impexp_sofabed_01a',
    },
	['sofas13'] = {
        [1] = 'p_res_sofa_l_s',
    },
	['sofas14'] = {
        [1] = 'p_v_med_p_sofa_s',
    },
	['sofas15'] = {
        [1] = 'gr_dlc_gr_yacht_props_lounger',
    },
	-- Carpet
	['carpets1'] = {
        [1] = 'hei_heist_acc_rugwooll_01',
        [2] = 'hei_heist_acc_rugwooll_02',
        [3] = 'hei_heist_acc_rugwooll_03',
        [4] = 'hei_heist_acc_rughidel_01',
    },
	['carpets2'] = {
        [1] = 'apa_mp_h_acc_rugwoolm_01',
        [2] = 'apa_mp_h_acc_rugwoolm_02',
        [3] = 'apa_mp_h_acc_rugwoolm_03',
        [4] = 'apa_mp_h_acc_rugwoolm_04',
    },
	['carpets3'] = {
        [1] = 'apa_mp_h_acc_rugwools_01',
        [2] = 'apa_mp_h_acc_rugwools_03',
    },
	['carpets4'] = {
        [1] = 'prop_yoga_mat_01',
        [2] = 'prop_yoga_mat_02',
        [3] = 'prop_yoga_mat_03',
        [4] = 'p_yoga_mat_01_s',
    },
	-- Beds
	['bed'] = {
        [1] = 'v_res_d_bed',
        [2] = 'v_res_lestersbed',
        [3] = 'v_res_mbbed',
        [4] = 'v_res_mdbed',
        [5] = 'v_res_msonbed',
        [6] = 'v_res_tre_bed1',
        [7] = 'v_res_tre_bed2',
        [8] = 'v_res_tt_bed',
        [9] = 'apa_mp_h_bed_with_table_02',
        [10] = 'apa_mp_h_bed_wide_05',
        [11] = 'apa_mp_h_bed_double_08',
        [12] = 'apa_mp_h_bed_double_09',
        [13] = 'apa_mp_h_yacht_bed_01',
        [14] = 'apa_mp_h_yacht_bed_02',
        [15] = 'bkr_prop_biker_campbed_01',
        [16] = 'ex_prop_exec_bed_01',
        [17] = 'gr_prop_bunker_bed_01',
        [18] = 'p_mbbed_s',
        [19] = 'gr_prop_gr_campbed_01',
    },
	-- Table
	['table1'] = {
        [1] = 'apa_mp_h_din_table_01',
        [2] = 'apa_mp_h_din_table_04',
        [3] = 'apa_mp_h_din_table_05',
        [4] = 'apa_mp_h_din_table_06',
        [5] = 'apa_mp_h_din_table_11',
        [6] = 'hei_heist_din_table_04',
        [7] = 'hei_heist_din_table_06',
        [8] = 'hei_heist_din_table_07',
    },
	['table2'] = {
        [1] = 'apa_mp_h_yacht_coffee_table_01',
        [2] = 'apa_mp_h_yacht_coffee_table_02',
        [3] = 'prop_fbi3_coffee_table',
        [4] = 'prop_t_coffe_table',
    },
	['table3'] = {
        [1] = 'apa_mp_h_yacht_side_table_01',
        [2] = 'apa_mp_h_yacht_side_table_02',
    },
	['table4'] = {
        [1] = 'ba_prop_int_edgy_table_01',
        [2] = 'ba_prop_int_edgy_table_02',
    },
	['table5'] = {
        [1] = 'bkr_prop_weed_table_01a',
        [2] = 'bkr_prop_weed_table_01b',
        [3] = 'bkr_prop_coke_table01a',
        [4] = 'bkr_prop_meth_table01a',
    },
	['table6'] = {
        [1] = 'gr_dlc_gr_yacht_props_table_01',
        [2] = 'gr_dlc_gr_yacht_props_table_02',
        [3] = 'gr_dlc_gr_yacht_props_table_03',
    },
	['table7'] = {
        [1] = 'prop_pooltable_02',
        [2] = 'prop_pooltable_3b',
    },
	['table8'] = {
        [1] = 'prop_table_02',
        [2] = 'prop_table_04',
        [3] = 'prop_table_05',
        [4] = 'prop_table_06',
        [5] = 'prop_table_07',
        [6] = 'prop_table_08',
    },
	['table9'] = {
        [1] = 'prop_table_02',
        [2] = 'apa_mp_h_str_sideboards_02',
        [3] = 'apa_mp_h_tab_sidelrg_07',
        [4] = 'apa_mp_h_tab_sidesml_01',
    },
}

-- https://docs.fivem.net/docs/game-references/controls/
-- Use the input index for the "input" value
Config.keybinds = {
    openMenu = {
        enabled = false,
        key = 'F4',
    },
    pickup = {
        label = 'E',
        name = 'INPUT_PICKUP',
        input = 38,
        duration = 1000,
    },
    place = {
        label = 'E',
        name = 'INPUT_PICKUP',
        input = 38,
    },
    cancelPlacing = {
        label = 'Backspace',
        name = 'INPUT_CELLPHONE_CANCEL',
        input = 177,
    },
    exit = {
        label = 'Escape',
        name = 'INPUT_CELLPHONE_CANCEL',
        input = 177,
    },
    arrowUp = {
        label = 'Arrow up',
        name = 'INPUT_CELLPHONE_UP',
        input = 172,
    },
    arrowDown = {
        label = 'Arrow down',
        name = 'INPUT_CELLPHONE_DOWN',
        input = 173,
    },
    upAlternative = {
        label = 'Scroll up',
        name = 'INPUT_VEH_CINEMATIC_UP_ONLY',
        input = 96,
    },
    downAlternative = {
        label = 'Scroll down',
        name = 'INPUT_VEH_CINEMATIC_DOWN_ONLY',
        input = 97,
    },
    confirm = {
        label = 'Enter',
        name = 'INPUT_FRONTEND_ACCEPT',
        input = 201,
    },
}

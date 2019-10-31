//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
//|||| Name   : ugx_fx.gsc 
//|||| Info     : Easiest way to implement FX in your map.
//|||| Site     : www.ugx-mods.com
//|||| Author : [UGX] treminaor
//|||| Notes  : contact 'treminaor' on xFire for more info/suggestions/help
//|||| Version : 1.1 (7/17/2011) Changes: Added 'stationary_loop' function.
//|||| Instructions: Read the code comments. I strongly advise that you download Notepad++ (free text editor) and go to Language>C>C++ so that this is easy to read (syntax highlighting)
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

//|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
//Initial Setup:
// Open your raw/maps/mapname.gsc
// Find: 'maps\_zombiemode::main();'
//
// Place 'maps\ugx_easy_fx::fx_setup()' on the LINE BEFORE 'maps\_zombiemode::main();'.
//
// Place 'level thread maps\ugx_easy_fx::fx_start()' on the LINE AFTER 'maps\_zombiemode::main()'
//
// Copy this file to /mods/mapname/maps/
// Open Launcher, go to the Mod tab, click your mod in the list, then find and CHECK this file in the right side box. Then Build MOD.
//
//
//
//Radiant Setup:
// Spawn a script_struct where you want the fx to appear. The CENTER of this red box is the origin of the spwaned fx. The fx will use the angles and rotation of the struct, so pretend you are placing the fx as if you could see it.
// Give the script_struct these REQUIRED KvP's:
// targetname, fx
// script_noteworthy, alias (where alias is the name of the fx... example: if you wanted level._effect["fire1"], you would enter fire1 for alias.
// script_string, usage (where usage is either stationary, use, or touch. See bottom of file for explainations.)
//
//
// REQUIRED KvP's FOR USE AND TOUCH SETUP
// script_string, hint (this is for the TRIGGER, not the STRUCT - where hint is the hint string you want for the trigger, example: Press &&1 to start the fire) '&&1' will automatically change to the players USE button (F usually)
// 
// REQUIRED KvP's FOR NON-LOOPING FX THAT YOU WANT TO LOOP
//
// If you are using stationary as your usage, you are done. Otherwise, continue:
//
// For USE usage, create a trigger_use. Then FIRST select the struct it will trigger, then SECOND hold shift and select the trigger. LASTLY, press W to link the two. You CAN have multiple structs per trigger.
//
// For TOUCH usage, create a trigger_multiple. Then set it up as you would a USE usage.
//
//
//
//
// Other REQUIRED preparation:
//
// If you are using 1.4 scripts, open your /zone_source/mapname_patch.csv
// Otherwise, open your /zone_source/mapname.csv
//
// Add these lines to it WITHOUT THE /* or */ - It does not matter if you add them at the beginning or end or middle of the file.
/*
fx,env/fire/fx_fire_brush_smolder_sm
fx,env/fire/fx_fire_detail_fade_14
fx,env/fire/fx_fire_blown_md_blk_smk_distant_w
fx,env/fire/fx_fire_oil_md
fx,env/fire/fx_fire_campfire_small
fx,env/fire/fx_fire_player_torso
fx,env/light/fx_glow_hanginglamp
fx,env/light/fx_glow_emergency_red_blink
fx,env/electrical/fx_elec_player_md
fx,maps/zombie/fx_zombie_wire_spark
fx,env/smoke/fx_smoke_smolder_sm_blk
fx,env/smoke/fx_smoke_smolder_md_gry
fx,env/smoke/fx_smoke_smolder_lg_gry
fx,env/smoke/fx_smoke_wood_chimney_med
fx,explosions/fx_default_explosion
fx,explosions/tank_impact_dirt
fx,maps/zombie/fx_zombie_wire_spark
*/
// 
//
// NEXT (1.4): Compile your map to save the structs
// Older versions: don't compile until you're done with everything.
//
// NEXT, for 1.4,
// Open Launcher and click your mapname_patch in the list, then check 'Build FastFiles' and ensure 'Mod Specific Map' is checked and set to your mapname. Then click 'Build Map'.
//
// For other older versions, just compile your entire map again.
//
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// IF YOU REACH THE 400FX LIMIT, YOU MUST COMMENT OUT ( // before the line) ANY FX YOU DO NOT WANT IN fx_setup() - YOU ALSO MUST REMOVE THE INCLUDE LINE FROM YOUR CSV. THIS WILL PREVENT THE FX FROM LOADING INTO YOUR MAP.
//|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

#include common_scripts\utility; 
#include maps\_utility;
#include maps\_zombiemode_utility; 

fx_setup() //This is where the FX are precached. Any FX you want to use must be added to your mapname_patch.csv as well as listed below. 
{
	//|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
	
	//Usage: level._effect["alias"] 			= loadFX("path/to/fx/name");
	//Where 'alias' is your personal name for the fx that you will use later in the code, and 'path/to/fx/name' is the file location + name of the fx you want to assign to the variable. See below for examples:
	//When entering the fx path, be sure to only include folder names that are within /raw/fx, and make sure to leave off the file extension (.efx).
	//If you want to preview any of these FX, open Launcher, click the EffectsEd button, then File>Open the file you wish to preview. Then press the green play button.
	
	//Fire\\
	level._effect["fire1"] 			= loadFX("env/fire/fx_fire_brush_smolder_sm");
	level._effect["fire2"] 			= loadFX("env/fire/fx_fire_detail_fade_14");
	level._effect["fire3"] 			= loadFX("env/fire/fx_fire_blown_md_blk_smk_distant_w");
	level._effect["fire4"] 			= loadFX("env/fire/fx_fire_oil_md");
	level._effect["fire5"] 			= loadFX("env/fire/fx_fire_campfire_small");
	level._effect["fire6"] 			= loadFX("env/fire/fx_fire_player_torso");
	//End Fire\\
	
	//Smoke/Smolder\\
	level._effect["smoke1"]			= loadFX("env/smoke/fx_smoke_smolder_sm_blk");
	level._effect["smoke2"]			= loadFX("env/smoke/fx_smoke_smolder_md_gry");
	level._effect["smoke3"]			= loadFX("env/smoke/fx_smoke_smolder_lg_gry");
	level._effect["smoke4"]			= loadFX("env/smoke/fx_smoke_wood_chimney_med");
	//End Smoke/Smolder\\
	
	
	//Explosions\\
	level._effect["explosion1"]			= loadFX("explosions/fx_default_explosion"); //non stationary
	level._effect["explosion2"]			= loadFX("explosions/tank_impact_dirt"); //non stationary
	//End Explosions\\
	
	
	//Light Rays\\
	level._effect["light1"] 			= loadFX("env/light/fx_glow_hanginglamp");
	level._effect["light2"]			= loadFX("env/light/fx_glow_emergency_red_blink");
	//End Light Rays\\
	
	
	//Electrical\\
	level._effect["electric1"]		= loadFX("env/electrical/fx_elec_player_md"); // 1.4 only!
	level._effect["electric2"]		= loadFX("maps/zombie/fx_zombie_wire_spark"); // 1.4 only!
	//End Electrical\\
	
	
	//User-Additions\\
	//Place your fx lines below this line, or below other fx in their respective sections.
	level._effect["bugs1"]		= loadFX("bio/insects/fx_insect_carcass_flies");
	//End User-Additions\\
	
	//|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
	//DEBUG SETTING:
	
	level.fx_debug = 1; // '1' = ON, 'undefined' = OFF
	
	//|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
	//Do not edit or add anything below this line.
}

fx_start()
{
	fx_spots = getstructarray("fx","targetname");
	
	if(isDefined(level.fx_debug))
	{
		if(fx_spots.size == 0 || !isDefined(fx_spots))
			iPrintLn("Easy-FX: ^1ERROR: ^7No FX structs were found! Ensure that you used SCRIPT_STRUCTS and you gave them the correct TARGETNAME.");
		else
			iPrintLn("Easy-FX found "+fx_spots.size+" fx structs in your level.");
	}
	
	
	for(i=0;i<fx_spots.size;i++)
	{
		usage = fx_spots[i].script_string;
		if(usage == "stationary")
			fx_spots[i] thread stationary_fx();
		if(usage == "stationary_loop")
			fx_spots[i] thread stationary_fx(true);
		else if(usage == "touch")
			fx_spots[i] thread triggered_touch_fx();
		else if(usage == "use")
			fx_spots[i] thread triggered_use_fx();
		else if(usage == "use_loop")
			fx_spots[i] thread triggered_use_fx(true);
		else if(usage == "touch_loop")
			fx_spots[i] thread triggered_touch_fx(true);
		else if(!isDefined(fx_spots[i].script_string))
			if(isDefined(level.fx_debug)) iPrintLn("Easy-FX: ^1ERROR: ^7FX struct at origin "+fx_spots[i].origin+" is missing its stript_string for fx usage! Set it as stationary, use, or touch.");
	}
}

stationary_fx(loop) //These are untriggered FX that will play on loop while the level is running.
{
	
	fx = self.script_noteworthy;
	if(!isDefined(fx) && isDefined(level.fx_debug)) iPrintLn("Easy-FX: ^1ERROR: ^7 FX struct at origin "+self.origin+" is missing its script_noteworthy for fx name!");
	
    fxTag = "tag_origin";
   
    self.fx = Spawn( "script_model", self.origin );
    self.fx SetModel( "tag_origin" );
    self.fx.angles = self.angles;
    self.fx.origin = self.origin;
    self.fx LinkTo( self, fxTag );
	
	if(isDefined(loop))
	{
		if(!isDefined(self.speed))
		{
			self.speed = 1;
			if(isDefined(level.fx_debug))iPrintLn("Easy-FX: ^1ERROR: ^7No speed was specified on the struct at origin "+self.origin+". It has defaulted to 1 second.");
		}
		PlayLoopedFX(level._effect[fx], self.speed, self.origin);
	}
	else
		PlayFxOnTag( level._effect[fx], self.fx, fxTag ); 
}

triggered_touch_fx(loop) //These are triggered FX. They are triggered when the player walks though a trigger_multiple that you create in Radiant.
{
	trigger = getEnt(self.target,"targetname");
	if(!isDefined(trigger.script_string))
		trigger.script_string = "SET THIS TEXT USING THE SCRIPT_STRING KVP ON THE TRIGGER";
	trigger setHintString(trigger.script_string);
	trigger SetCursorHint("HINT_NOICON");
	fx = self.script_noteworthy;
	trigger waittill("trigger");
	
	fxTag = "tag_origin";
    self.fx = Spawn( "script_model", self.origin );
    self.fx SetModel( "tag_origin" );
    self.fx.angles = self.angles;
    self.fx.origin = self.origin;
    self.fx LinkTo( self, fxTag );
	
	if(isDefined(loop))
	{
		if(!isDefined(self.speed))
		{
			self.speed = 1;
			if(isDefined(level.fx_debug))iPrintLn("Easy-FX: ^1ERROR: ^7No speed was specified on the struct at origin "+self.origin+". It has defaulted to 1 second.");
		}
		PlayLoopedFX(level._effect[fx], self.speed, self.origin);
	}
	else
		PlayFxOnTag( level._effect[fx], self.fx, fxTag ); 
}

triggered_use_fx(loop) //These are triggered FX. They are triggered when the player uses a trigger (by pressing F) that you create in Radiant.
{
	trigger = getEnt(self.target,"targetname");
	if(!isDefined(trigger.script_string))
		trigger.script_string = "SET THIS TEXT USING THE SCRIPT_STRING KVP ON THE TRIGGER";
	trigger setHintString(trigger.script_string);
	trigger SetCursorHint("HINT_NOICON");
	fx = self.script_noteworthy;
	trigger waittill("trigger");
	
	fxTag = "tag_origin";
    self.fx = Spawn( "script_model", self.origin );
    self.fx SetModel( "tag_origin" );
    self.fx.angles = self.angles;
    self.fx.origin = self.origin;
    self.fx LinkTo( self, fxTag );
	
	if(isDefined(loop))
	{
		if(!isDefined(self.speed))
		{
			self.speed = 0.5;
			if(isDefined(level.fx_debug))iPrintLn("Easy-FX: ^1ERROR: ^7No speed was specified on the struct at origin "+self.origin+". It has defaulted to 0.5 seconds");
		}
		PlayLoopedFX(level._effect[fx], self.speed, self.origin);
	}
	else
		PlayFxOnTag( level._effect[fx], self.fx, fxTag ); 
}


#include common_scripts\utility; 
#include maps\_utility;
#include maps\_zombiemode_utility; 

init()
{
	level._effect["ugx_weather"] = LoadFx("env/weather/fx_snow_blizzard_intense");
}

think()
{
	players = getPlayers();
	for(i = 0; i < players.size; i++)
		players[i] thread play_weather();
}

play_weather()
{
	self endon("death");
	self endon("disconnect");
	
	for (;;)
	{
		PlayFX( level._effect["ugx_weather"], self.origin + (0,0,650) );
		wait( 0.3 );
	}
}

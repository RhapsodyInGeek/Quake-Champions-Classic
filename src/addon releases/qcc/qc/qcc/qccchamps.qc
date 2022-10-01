/*
==================================================================================
GENERAL FIRE ABILITY FUNCTION
Might add some other classes / champions after this, who knows?
==================================================================================
*/

void() QCC_Precaches =
{
	// Ranger
	precache_model ("progs/qcranger.mdl"); // player Ranger model (has new animations)
	precache_model ("progs/v_dorb.mdl"); // dire orb view model
	precache_model ("progs/w_dorb.mdl"); // dire orb world model
	precache_sound ("misc/r_tele2.wav"); // dire orb throw sound
	
	// Death Knight
	precache_model ("progs/qcdknight.mdl"); // player Death Knight model
	precache_model ("progs/v_dksword.mdl"); // Death Knight ax and flame strike view model
	precache_model ("progs/k_spike.mdl"); // flame strike projectile
	precache_model ("progs/flame2.mdl"); // for the flame trail
	precache_sound ("hknight/attack1.wav"); // flame strike sound
	precache_model ("progs/h_hellkn.mdl");
	precache_sound ("hknight/attack1.wav");
	precache_sound ("hknight/death1.wav");
	precache_sound ("hknight/pain1.wav");
	precache_sound ("hknight/sight1.wav");
	precache_sound ("hknight/hit.wav");
	precache_sound ("hknight/slash1.wav");
	precache_sound ("hknight/idle.wav");
	precache_sound ("hknight/grunt.wav");
};

/*
======================================================
CHAMPION SPAWNING
======================================================
*/

// Will replace the player spawning code in client.qc
// This way we can have champion picking and custom player models
void() QCC_SpawnChampion = 
{
	local float armorbit;
	
	if (self.qccNextChampion == QCC_DEATHKNIGHT)
	{
		QCC_DeathKnight();
	}
	else // Ranger is the default class
	{
		QCC_Ranger();
	}
	self.modelindex_champ = self.modelindex;
	//self.colormap;
	self.view_ofs = '0 0 22';
	self.velocity = '0 0 0';	// 1998-07-21 Player moves after respawn fix by Xian
	setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
	self.qccChampion = self.qccNextChampion;
	if (self.qccClass == QCC_LIGHT)
	{
		self.armortype = 0.4;
		self.armorvalue = 100;
		armorbit = IT_ARMOR1;
	}
	else if (self.qccClass == QCC_MEDIUM)
	{
		self.armortype = 0.6;
		self.armorvalue = 100;
		armorbit = IT_ARMOR2;
	}
	else if (self.qccClass == QCC_HEAVY)
	{
		self.armortype = 0.8;
		self.armorvalue = 100;
		armorbit = IT_ARMOR3;
	}
	self.items = self.items - (self.items & (IT_ARMOR1 | IT_ARMOR2 | IT_ARMOR3)) + armorbit;
	W_SetCurrentAmmo();
	player_stand1 ();
};
	

void() QCC_PickChampion =
{
	if (self.qccNextChampion == QCC_RANGER)
	{
		self.qccNextChampion = QCC_DEATHKNIGHT;
		if (time > 10 && deathmatch)
		{
			centerprint(self, "You will respawn as the Death Knight");
		}
		else
		{
			centerprint(self, "You are now the Death Knight");
		}
	}
	else
	{
		self.qccNextChampion = QCC_RANGER;
		if (time > 10 && deathmatch)
		{
			centerprint(self, "You will respawn as the Ranger");
		}
		else
		{
			centerprint(self, "You are now the Ranger");
		}
	}
	if (coop || deathmatch == 0 || time < 10)
	{
		QCC_SpawnChampion();
	}
};

/*
====================================================
BASE ABILITY METHODS
====================================================
*/
void() QCC_AbilityUsed =
{
	self.qccAbilityTimer = time + 45;
};

void(entity ent) QCC_AbilityTimeLeft =
{
	// Defaults to QCC_RANGER
	string ability_string;
	if (ent.qccChampion == QCC_RANGER)
	{
		ability_string = "Dire Orb";
	}
	else if (ent.qccChampion == QCC_DEATHKNIGHT)
	{
		ability_string = "Flame Strike";
	}
	sprint(ent, ability_string);
	if (ent.qccAbilityTimer - time <= 0)
	{
		sprint(ent, " is ready!\n");
		return;
	}
	sprint(ent, " ready in ");
	string time_left_str;
	time_left_str = ftos(ent.qccAbilityTimer - time);
	sprint(ent, time_left_str);
	sprint(ent, " seconds\n");
};

void(entity ent) QCC_AbilityCooldown =
{
	if (ent.qccAbilityTimer > time)
	{
		ent.qccAbilityTimer = ent.qccAbilityTimer - 4.5;
		QCC_AbilityTimeLeft(ent);
	}
};

void() QCC_FireAbility =
{
	// Check the timer
	if (self.qccAbilityTimer > time)
	{
		QCC_AbilityTimeLeft(self);
		return;
	}
	
	// Save the current weapon model so we can swap back to it
	self.qccPrevWep = self.weapon;
	
	// Death Knight: Flame Strike
	if (self.qccChampion == QCC_DEATHKNIGHT)
	{
		QCC_FlameStrike();
		return;
	}
	
	// Ranger: Dire Orb
	if (self.qccAbilityTimer < 0)
	{		
		QCC_DireOrbWarp();
		return;
	}
	QCC_DireOrbThrow();
	return;
};

// We use this for any abilities that alter the player's view model
void() QCC_RestoreWeapon =
{
	self.weapon = self.qccPrevWep;
	player_stand1();	
	W_SetCurrentAmmo ();
};

void() hourglass_grab =
{
	if (other.classname != "player")
		return;
	if (other.qccAbilityTimer > time)
	{
		QCC_AbilityCooldown(other);
		sound(other, CHAN_ITEM, self.noise, 1, ATTN_NORM);
		self.model = string_null;
		self.solid = SOLID_NOT;
		if ( deathmatch && deathmatch != 2 )
			self.nextthink = time + 20;
		self.think = SUB_regen;
		activator = other;
		SUB_UseTargets();
	}
};

void() item_hourglass =
{
	precache_model ("progs/qchourglass.mdl");
	precache_sound("items/r_item1.wav");
	setmodel(self, "progs/qchourglass.mdl");
	self.noise = "items/r_item1.wav";
	self.touch = hourglass_grab;
	setsize (self, '-16 -16 -16', '16 16 40');
	StartItem ();
};
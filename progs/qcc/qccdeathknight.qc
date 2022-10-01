/*
======================================================
QCC: RANGER
======================================================
*/
void() QCC_DeathKnight =
{
	// Stats
	self.qccClass = QCC_MEDIUM;
	// Model
	setmodel (self, "progs/qcdknight.mdl");
	self.qccChampGib = "progs/h_hellkn.mdl";
	self.qccMeleeMdl = "progs/v_dksword.mdl";
	// Sounds
	self.qccSndMelee = "hknight/slash1.wav";
	self.qccSndJump = "hknight/idle.wav";
	self.qccSndLand1 = "hknight/hit.wav";
	self.qccSndLand2 = "hknight/pain1.wav";
	self.qccSndPain1 = "hknight/pain1.wav";
	self.qccSndPain2 = "hknight/pain1.wav";
	self.qccSndPain3 = "hknight/pain1.wav";
	self.qccSndPain4 = "hknight/pain1.wav";
	self.qccSndPain5 = "hknight/pain1.wav";
	self.qccSndPain6 = "hknight/pain1.wav";
	self.qccSndDeath1 = "hknight/death1.wav";
	self.qccSndDeath2 = "hknight/death1.wav";
	self.qccSndDeath3 = "hknight/death1.wav";
	self.qccSndDeath4 = "hknight/death1.wav";
	self.qccSndDeath5 = "hknight/death1.wav";
	self.qccSndAxHit1 = "hknight/grunt.wav";
	self.qccSndBurn1 = "hknight/grunt.wav";
	self.qccSndBurn2 = "hknight/grunt.wav";
	self.qccSndGasp1 = "hknight/idle.wav";
	self.qccSndGasp2 = "hknight/idle.wav";
	self.qccSndDrown1 = "hknight/grunt.wav";
	self.qccSndDrown2 = "hknight/grunt.wav";
	self.qccSndH2oDeath = "hknight/death1.wav";
};

/*
======================================================
QCC: FLAME STRIKE
======================================================
*/

// Called by Flame Strike Shot
void() QCC_FlametrailTouch =
{
	if (other.qccChampion == QCC_DEATHKNIGHT || other.classname == "monster_hell_knight" || other.health <= 0 || other.qccOnFire > time)
		return;
	
	T_Damage (other, self, self.owner, 10);
	particle (other.origin, '0 0 32', 232, 25);
	QCC_CatchFire(self.owner, other);
};

void() QCC_FlamestrikeThink =
{
	local entity fire;
	
	traceline(self.origin, self.origin + '0 0 -56', 1, self);
	if (trace_fraction < 1)
	{
		fire = spawn();
		fire.owner = self.owner;
		fire.movetype = MOVETYPE_NONE;
		fire.solid = SOLID_TRIGGER;
		setmodel (fire, "progs/flame2.mdl");
		setorigin (fire, trace_endpos + '0 0 16');
		setsize (self, '-8 -8 -8', '8 8 0');
		fire.touch = QCC_FlametrailTouch;
		fire.nextthink = time + 7;
		fire.think = SUB_Remove;
		self.nextthink = time + 0.2;
	}
};

void() QCC_FlamestrikeTouch =
{
	local float	damg;

	if (other == self.owner)
		return;
	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}
	
	damg = 25;
	
	if (other.health)
	{
		spawn_touchblood (damg);
		T_Damage (other, self, self.owner, damg );
		QCC_CatchFire(self.owner, other);
	}
	T_RadiusDamage (self, self.owner, damg, other);

	self.origin = self.origin - 8*normalize(self.velocity);
	
	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);
	
	BecomeExplosion ();
};
	
// Called by Death Knight (taken from hknight.qc)
void(float offset) QCC_FlameStrikeShot =
{
	local	vector	offang;
	local	vector	org, vec;
	
	offang = self.v_angle;
	offang_y = offang_y + offset * -6;
	offang_x = offang_x * -1;
	
	makevectors (offang);

	org = self.origin + self.mins + self.size*0.5 + v_forward * 20;

	// set missile speed
	vec = normalize (v_forward);
	vec_z = 0 - vec_z;
	
	launch_spike (org, vec);
	newmis.classname = "flamestrike";
	newmis.touch = QCC_FlamestrikeTouch;
	setmodel (newmis, "progs/k_spike.mdl");
	setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);		
	newmis.velocity = vec*300;
	sound (self, CHAN_WEAPON, "hknight/attack1.wav", 1, ATTN_NORM);
	newmis.nextthink = time + 0.1;
	newmis.think = QCC_FlamestrikeThink;
};

// Called by Death Knight
void() QCC_FlameStrikeAnimProc =
{
	//float offset;
	QCC_FlameStrikeShot(-2 + self.weaponframe - 9);
	if (self.weaponframe < 13)
	{
		self.weaponframe = self.weaponframe + 1;
		self.frame = 117 + self.weaponframe;
		self.nextthink = time + 0.075;
		self.think = QCC_FlameStrikeAnimProc;
		return;
	}
	self.qccAbilityTimer = time + 45;
	self.nextthink = time + 0.075;
	self.think = QCC_RestoreWeapon;
}

// Called by Death Knight
void() QCC_FlameStrike =
{
	//centerprint (self,"INCENDIMUS!\n");
	
	self.weapon = QCC_ABILITY;
	self.weaponmodel = "progs/v_dksword.mdl";
	self.weaponframe = 9;
	self.frame = 126;
	self.attack_finished = time + 0.5;
	self.show_hostile = time + 1;	// wake monsters up
	sound (self, CHAN_VOICE, "hknight/sight1.wav", 1, ATTN_NORM);
	self.nextthink = time + 0.075;
	self.think = QCC_FlameStrikeAnimProc;
};

// Set them on fire
void(entity f_owner, entity f_target) QCC_CatchFire =
{
	local entity fire;
	
	// Death Knight is immune to catching on fire, as are dead bodies
	if (f_target.qccChampion == QCC_DEATHKNIGHT || f_target.classname == "monster_hell_knight" || f_target.health <= 0 || f_target.qccOnFire > time)
	{
		return;
	}	
	fire = spawn ();
	fire.qccAbilityOwner = f_owner;
	fire.owner = f_target; 
	fire.movetype = MOVETYPE_NONE;
	fire.solid = SOLID_NOT;
	setmodel (fire, "");
	setsize (fire, '0 0 0', '0 0 0');             
	setorigin (fire, '0 0 0');
	f_target.qccOnFire = time + 8;
	fire.nextthink = time + 1;
	fire.think = QCC_OnFireThink;
};

void() QCC_OnFireThink =
{
    if (self.owner.qccOnFire < time || self.owner.health <= 0 || self.waterlevel >= 1) // if you get to water it stops... or if you're dead
    {
        remove(self);
        return;
    }
	particle (self.owner.origin, '0 0 32', 232, 25);
    T_Damage (self.owner, self, self.qccAbilityOwner, 10); // do damage
	self.nextthink = time + 1;
};   
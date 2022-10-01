/*
======================================================
QCC: RANGER
======================================================
*/
void() QCC_Ranger =
{
	// Stats
	self.qccClass = QCC_MEDIUM;
	// Model
	setmodel (self, "progs/qcranger.mdl");
	self.qccChampGib = "progs/h_player.mdl";
	self.qccMeleeMdl = "progs/v_axe.mdl";
	// Sounds
	self.qccSndMelee = "weapons/ax1.wav";
	self.qccSndJump = "player/plyrjmp8.wav";
	self.qccSndLand1 = "player/land.wav";
	self.qccSndLand2 = "player/land2.wav";
	self.qccSndPain1 = "player/pain1.wav";
	self.qccSndPain2 = "player/pain2.wav";
	self.qccSndPain3 = "player/pain3.wav";
	self.qccSndPain4 = "player/pain4.wav";
	self.qccSndPain5 = "player/pain5.wav";
	self.qccSndPain6 = "player/pain6.wav";
	self.qccSndDeath1 = "player/death1.wav";
	self.qccSndDeath2 = "player/death2.wav";
	self.qccSndDeath3 = "player/death3.wav";
	self.qccSndDeath4 = "player/death4.wav";
	self.qccSndDeath5 = "player/death5.wav";
	self.qccSndAxHit1 = "player/axhit1.wav";
	self.qccSndBurn1 = "player/lburn1.wav";
	self.qccSndBurn2 = "player/lburn2.wav";
	self.qccSndGasp1 = "player/gasp1.wav";
	self.qccSndGasp2 = "player/gasp2.wav";
	self.qccSndDrown1 = "player/drown1.wav";
	self.qccSndDrown2 = "player/drown2.wav";
	self.qccSndH2oDeath = "player/h2odeath.wav";
};

/*
======================================================
QCC: DIRE ORB
======================================================
*/
$frame dorb1 dorb2 dorb3 dorb4 dorb5

void() dorb_fly1 = [$dorb1, dorb_fly2] {};
void() dorb_fly2 = [$dorb2, dorb_fly3] {};
void() dorb_fly3 = [$dorb3, dorb_fly4] {};
void() dorb_fly4 = [$dorb4, dorb_fly5] {};
void() dorb_fly5 = [$dorb5, dorb_fly6] {};
void() dorb_fly6 = [$dorb4, dorb_fly7] {};
void() dorb_fly7 = [$dorb3, dorb_fly8] {};
void() dorb_fly8 = [$dorb2, dorb_fly1] {};

void() dorb_x1 = [$dorb1, dorb_x2] {};
void() dorb_x2 = [$dorb2, dorb_x3] {};
void() dorb_x3 = [$dorb3, dorb_x4] {};
void() dorb_x4 = [$dorb4, dorb_x5] {};
void() dorb_x5 = [$dorb5, dorb_x6] {};
void() dorb_x6 = [$dorb4, dorb_x7] {};
void() dorb_x7 = [$dorb3, dorb_x8] {};
void() dorb_x8 = [$dorb2, QCC_DireOrbExplosion] {};

// Called by Orb
void() QCC_DireOrbExplosion =
{
	self.owner.qccAbilityTimer = time + 45;
	self.movetype = MOVETYPE_NONE;
	self.velocity = '0 0 0';
	self.touch = SUB_Null;
	setmodel (self, "progs/s_explod.spr");
	
	T_RadiusDamage (self, self.owner, 50, self.owner);
	
	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);
	
	s_explode1 ();
};

// Called by Orb
void() QCC_DireOrbTouch =
{
	if (other == self.owner)
		return;		// don't explode on owner
	
	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		self.owner.qccAbilityTimer = time + 45;
		remove(self);
		return;
	}
	
	// sound (self, CHAN_WEAPON, "weapons/r_exp3.wav", 1, ATTN_NORM);
	
	self.origin = self.origin - 8*normalize(self.velocity);
	
	if (other.health)
	{
		spawn_touchblood (3);
		T_Damage (other, self, self.owner, 1 );
	}
	
	// Only explode if we hit a wall
	if (other.classname == "worldspawn")
	{
		self.movetype = MOVETYPE_NONE;
		dorb_x1();
		//self.nextthink = time + 1;
		//self.think = QCC_DireOrbExplosion;
	}
};

// Called by Ranger
// shows Ranger's arm throw out the orb
void() QCC_DireOrbAnimProc =
{
	if (self.weaponframe < 9)
	{
		self.weaponframe = self.weaponframe + 1;
		self.frame = 144 + self.weaponframe;
		self.nextthink = time + 0.025;
		self.think = QCC_DireOrbAnimProc;
		return;
	}
	QCC_RestoreWeapon();
}

// Called by Ranger
void() QCC_DireOrbAnim =
{
	self.weapon = QCC_ABILITY;
	self.weaponmodel = "progs/v_dorb.mdl";
	self.weaponframe = 0;
	self.frame = 144;
	self.attack_finished = time + 0.25;
	self.show_hostile = time + 1;	// wake monsters up
	self.nextthink = time + 0.025;
	self.think = QCC_DireOrbAnimProc;
}

// Called by Ranger
void() QCC_DireOrbWarp =
{
	QCC_DireOrbAnim ();
	
	local vector aVec;
	
	makevectors (self.qccAbilityEnt.mangle);
	
	aVec = self.qccAbilityEnt.origin;
	
	local float i;
	i = 0;
	while (i < 6)
	{
		local vector vCheck;
		if (i < 2) {vCheck = v_forward * 32;}
		if (i > 1 && i < 4) {vCheck = v_up * 32;}
		if (i > 3) {vCheck = v_right * 32;}
		if (i == 1 || i == 3 || i == 5) {vCheck = vCheck - vCheck * 2;}
		
		traceline (aVec, aVec + vCheck, TRUE, self);
		if (trace_fraction < 1)
		{
			aVec = aVec - vCheck;
		}
		i = i + 1;
	}
	
	spawn_tfog (self.origin);
	spawn_tdeath (aVec,self);

	setorigin (self,aVec);
	
	i = 0;
	while (i < 4)
	{
		local vector offset;
		if (i == 0) {offset = v_forward * 3;}
		if (i == 1) {offset = v_forward * -3;}
		if (i == 2) {offset = v_right * 3;}
		if (i == 3) {offset = v_right * -3;}
		spawn_tfog (aVec + offset);
		i = i + 1;
	}
	
	self.teleport_time = time + 0;
	self.flags = self.flags - self.flags & FL_ONGROUND;
	self.qccAbilityEnt.nextthink = time + 0;
	self.qccAbilityEnt.think = QCC_DireOrbExplosion;
	
	self.qccAbilityTimer = 0;
};

// Called by Ranger
void() QCC_DireOrbThrow =
{
	sound (self, CHAN_WEAPON, "misc/r_tele2.wav", 1, ATTN_NORM);
	QCC_DireOrbAnim ();
	
	self.qccAbilityTimer = -1;
	
	self.qccAbilityEnt = spawn();
	self.qccAbilityEnt.owner = self;
	self.qccAbilityEnt.movetype = MOVETYPE_FLY;
	self.qccAbilityEnt.solid = SOLID_TRIGGER;
	setmodel (self.qccAbilityEnt, "progs/w_dorb.mdl");
	setsize (self.qccAbilityEnt, '0 0 0', '1 1 1');
	//self.lightstyle = 1;
	
	self.qccAbilityEnt.touch = QCC_DireOrbTouch;
	
	//sound (self, CHAN_WEAPON, "misc/r_tele2.wav", 1, ATTN_NORM);
	
	// set orb movement
	setorigin (self.qccAbilityEnt, self.origin + v_forward * 8 + '0 0 16');
	makevectors (self.qccAbilityEnt.owner.v_angle);
	self.qccAbilityEnt.velocity = aim(self.qccAbilityEnt.owner, 500);
	self.qccAbilityEnt.velocity = self.qccAbilityEnt.velocity * 500;
	self.qccAbilityEnt.angles = vectoangles(self.qccAbilityEnt.velocity);
	
	// set orb animation
	self.qccAbilityEnt.think = dorb_fly1;
	self.qccAbilityEnt.nextthink = time + 0.1;
};

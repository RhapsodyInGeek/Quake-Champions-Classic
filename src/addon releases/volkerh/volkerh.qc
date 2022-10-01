/*
==============================================================================

VOLKERH

==============================================================================

To set up Volkerh fully, add this before ai.qc's "void() SightSound" function:

void() vol_wake;

And add this to ai.qc's "void() SightSound" function:

	else if (self.classname == "monster_volkerh")
		sound (self, CHAN_VOICE, "volkerh/volwake.wav", 1, ATTN_NONE);

Add this to client.qc's void() ClientObituary = function, after the line "if (attacker.flags & FL_MONSTER)":

				if (attacker.classname == "monster_volkerh")
					bprint ("'s blood was feasted upon by Volkerh\n");

And add this line to your FGD file to see him properly in Trenchbroom:

@PointClass base(Monster) size(-96 -96 -24, 96 96 288) model({ "path": ":progs/volkerh.mdl" }) = monster_volkerh : "Volkerh" []

*/

.float volmis_t;
.float voltaunt_timer;

vector(vector point, float ang) VolRotatePointYaw =
{
	local vector vec;
	local float x, y;
	
	vec = '0 1 0' * self.angles_y;
	makevectors(vec);
	vec = point;
	x = vec_x * v_forward_x - vec_y * v_forward_y;
	y = vec_x * v_forward_y + vec_y * v_forward_x;
	vec_x = x;
	vec_y = y;
	
	return vec;
}

// copied from boss.qc
void() vol_face =
{
	
// go for another player if multi player
	if (self.enemy.health <= 0 || random() < 0.02)
	{
		self.enemy = find(self.enemy, classname, "player");
		if (!self.enemy)
			self.enemy = find(self.enemy, classname, "player");
	}
	ai_face();
};

$frame hover1 hover2 hover3 hover4 hover5 hover6 hover7 hover8 hover9 hover10
$frame hover11 hover12 hover13 hover14 hover15 hover16 hover17 hover18 hover19 hover20
$frame hover21 hover22 hover23 hover24 hover25 hover26 hover27 hover28 hover29 hover30

$frame fly1 fly2 fly3 fly4 fly5 fly6 fly7 fly8 fly9 fly10
$frame fly11 fly12 fly13 fly14 fly15 fly16 fly17 fly18 fly19 fly20

$frame magica1 magica2 magica3 magica4 magica5 magica6 magica7 magica8 magica9
$frame magica10 magica11 magica12 magica13 magica14 magica15 magica16 magica17 magica18 magica19
$frame magica20 magica21 magica22 magica23 magica24 magica25 magica26 magica27 magica28 magica29

$frame magicb1 magicb2 magicb3 magicb4 magicb5 magicb6 magicb7 magicb8 magicb9 magicb10
$frame magicb11 magicb12 magicb13 magicb14 magicb15 magicb16 magicb17 magicb18 magicb19 magicb20

$frame magicc1 magicc2 magicc3 magicc4 magicc5 magicc6 magicc7 magicc8 magicc9
$frame magicc10 magicc11 magicc12 magicc13 magicc14 magicc15 magicc16 magicc17 magicc18 magicc19
$frame magicc20 magicc21 magicc22 magicc23 magicc24 magicc25 magicc26 magicc27 magicc28 magicc29
$frame magicc30 magicc31 magicc32 magicc33 magicc34 magicc35

$frame death1 death2 death3 death4 death5 death6 death7 death8 death9 death10
$frame death11 death12 death13 death14 death15 death16 death17 death18 death19
$frame death20 death21 death22 death23 death24 death25 death26

// Volkerh special functions
void() VolkerhTaunt =
{
	if (self.voltaunt_timer > time) 
	{
		return;
	}
	
	local float r;
	r = random();
	
	if (r < 0.33)
		sound (self, CHAN_VOICE, "volkerh/voltaunt1.wav", 1, ATTN_NONE);
		self.voltaunt_timer = time + 12;
	if (r >= 0.33 && r < 0.66)
		sound (self, CHAN_VOICE, "volkerh/voltaunt2.wav", 1, ATTN_NONE);
		self.voltaunt_timer = time + 8;
	if (r >= 0.66)
		sound (self, CHAN_VOICE, "volkerh/voltaunt3.wav", 1, ATTN_NONE);
		self.voltaunt_timer = time + 8;
};

void(vector bloodpos, float bloodsz) VolkerhBloodFist = 
{
	local vector vec, dir;
	local float x, y, z;
		
	vec = VolRotatePointYaw(bloodpos,self.angles_y);		
	vec = self.origin + vec;
	if (bloodsz > 0)
	{
		z = -1;
		while (z <= 1)
		{
			x = -1;
			while (x <= 1)
			{
				y = -1;
				while (y <= 1)
				{
					dir_x = x;
					dir_y = y;
					dir_z = z;
					dir = normalize(dir);
					particle (vec + dir * 8, dir * 32, 73, 100 * bloodsz);
					y = y + 1;
				}
				x = x + 1;
			}
			z = z + 1;
		}
	}
	else
		particle (vec, '0 0 -32', 73, 100);
}

// Animations

void() vol_stand1	=[	$hover1,	vol_stand2] {ai_stand();};
void() vol_stand2	=[	$hover2,	vol_stand3] {ai_stand();};
void() vol_stand3	=[	$hover3,	vol_stand4] {ai_stand();};
void() vol_stand4	=[	$hover4,	vol_stand5] {ai_stand();};
void() vol_stand5	=[	$hover5,	vol_stand6] {ai_stand();};
void() vol_stand6	=[	$hover6,	vol_stand7] {ai_stand();};
void() vol_stand7	=[	$hover7,	vol_stand8] {ai_stand();};
void() vol_stand8	=[	$hover8,	vol_stand9] {ai_stand();};
void() vol_stand9	=[	$hover9,	vol_stand10] {ai_stand();};
void() vol_stand10	=[	$hover10,	vol_stand11] {ai_stand();};
void() vol_stand11	=[	$hover11,	vol_stand12] {ai_stand();};
void() vol_stand12	=[	$hover12,	vol_stand13] {ai_stand();};
void() vol_stand13	=[	$hover13,	vol_stand14] {ai_stand();};
void() vol_stand14	=[	$hover14,	vol_stand15] {ai_stand();};
void() vol_stand15	=[	$hover15,	vol_stand16] {ai_stand();};
void() vol_stand16	=[	$hover16,	vol_stand17] {ai_stand();};
void() vol_stand17	=[	$hover17,	vol_stand18] {ai_stand();};
void() vol_stand18	=[	$hover18,	vol_stand19] {ai_stand();};
void() vol_stand19	=[	$hover19,	vol_stand20] {ai_stand();};
void() vol_stand20	=[	$hover20,	vol_stand21] {ai_stand();};
void() vol_stand21	=[	$hover21,	vol_stand22] {ai_stand();};
void() vol_stand22	=[	$hover22,	vol_stand23] {ai_stand();};
void() vol_stand23	=[	$hover23,	vol_stand24] {ai_stand();};
void() vol_stand24	=[	$hover24,	vol_stand25] {ai_stand();};
void() vol_stand25	=[	$hover25,	vol_stand26] {ai_stand();};
void() vol_stand26	=[	$hover26,	vol_stand27] {ai_stand();};
void() vol_stand27	=[	$hover27,	vol_stand28] {ai_stand();};
void() vol_stand28	=[	$hover28,	vol_stand29] {ai_stand();};
void() vol_stand29	=[	$hover29,	vol_stand30] {ai_stand();};
void() vol_stand30	=[	$hover30,	vol_stand1] {ai_stand();};

void() vol_walk1 =[ $fly1, vol_walk2 ] {ai_walk(3);};
void() vol_walk2 =[ $fly2, vol_walk3 ] {ai_walk(3);};
void() vol_walk3 =[ $fly3, vol_walk4 ] {ai_walk(3);};
void() vol_walk4 =[ $fly4, vol_walk5 ] {ai_walk(3);};
void() vol_walk5 =[ $fly5, vol_walk6 ] {ai_walk(3);};
void() vol_walk6 =[ $fly6, vol_walk7 ] {ai_walk(3);};
void() vol_walk7 =[ $fly7, vol_walk8 ] {ai_walk(3);};
void() vol_walk8 =[ $fly8, vol_walk9 ] {ai_walk(3);};
void() vol_walk9 =[ $fly9, vol_walk10] {ai_walk(3);};
void() vol_walk10 =[ $fly10, vol_walk11] {ai_walk(3);};
void() vol_walk11 =[ $fly11, vol_walk12] {ai_walk(3);};
void() vol_walk12 =[ $fly12, vol_walk13] {ai_walk(3);};
void() vol_walk13 =[ $fly13, vol_walk14] {ai_walk(3);};
void() vol_walk14 =[ $fly14, vol_walk15] {ai_walk(3);};
void() vol_walk15 =[ $fly15, vol_walk16] {ai_walk(3);};
void() vol_walk16 =[ $fly16, vol_walk17] {ai_walk(3);};
void() vol_walk17 =[ $fly17, vol_walk18] {ai_walk(3);};
void() vol_walk18 =[ $fly18, vol_walk19] {ai_walk(3);};
void() vol_walk19 =[ $fly19, vol_walk20] {ai_walk(3);};
void() vol_walk20 =[ $fly20, vol_walk1 ] {ai_walk(3);};

void() vol_run1 =[ $fly1, vol_run2 ] {ai_run(7);};
void() vol_run2 =[ $fly2, vol_run3 ] {ai_run(7);};
void() vol_run3 =[ $fly3, vol_run4 ] {ai_run(7);};
void() vol_run4 =[ $fly4, vol_run5 ] {ai_run(7);};
void() vol_run5 =[ $fly5, vol_run6 ] {ai_run(7);};
void() vol_run6 =[ $fly6, vol_run7 ] {ai_run(7);};
void() vol_run7 =[ $fly7, vol_run8 ] {ai_run(7);};
void() vol_run8 =[ $fly8, vol_run9 ] {ai_run(7);};
void() vol_run9 =[ $fly9, vol_run10] {ai_run(7);};
void() vol_run10 =[ $fly10, vol_run11] {ai_run(7);};
void() vol_run11 =[ $fly11, vol_run12] {ai_run(7);};
void() vol_run12 =[ $fly12, vol_run13] {ai_run(7);};
void() vol_run13 =[ $fly13, vol_run14] {ai_run(7);};
void() vol_run14 =[ $fly14, vol_run15] {ai_run(7);};
void() vol_run15 =[ $fly15, vol_run16] {ai_run(7);};
void() vol_run16 =[ $fly16, vol_run17] {ai_run(7);};
void() vol_run17 =[ $fly17, vol_run18] {ai_run(7);};
void() vol_run18 =[ $fly18, vol_run19] {ai_run(7);};
void() vol_run19 =[ $fly19, vol_run20] {ai_run(7);};
void() vol_run20 =[ $fly20, vol_run1 ]
	{
		if (time > self.voltaunt_timer)
		{
			VolkerhTaunt();
		}
		ai_run(7);
	};

/*
=============================
MAGIC A - MISSILE
-----------------------------
Volkerh charges up some blood magic and launches dark explosive energy at his victim.
=============================
*/
void() VolMisTouch = 
{
	if (other == self.owner)
		return;		// don't explode on owner
	
	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}
	
	if (other.health)
	{
		SpawnBlood (self.origin, self.velocity*0.2, 50);
		T_Damage (other, self, self, 80);
	}
	T_RadiusDamage (self, self.owner, 80, other);
	sound (self, CHAN_WEAPON, "weapons/r_exp3.wav", 1, ATTN_NORM);

	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);

	self.velocity = '0 0 0';
	self.touch = SUB_Null;
	setmodel (self, "progs/s_explod.spr");
	self.solid = SOLID_NOT;
	s_explode1 ();
};

void() VolMisFly = 
{
	particle (self.origin, '0 0 0', 220, 100);
	self.nextthink = time + 0.1;
	self.think = VolMisFly;
};

void() VolkerhMissile =
{
	local	entity 	missile;
	local	vector	vec, org;
	local	float	t;
	
	org = VolRotatePointYaw('187 3 208',self.angles_y);
	org = org + self.origin;
	
	// lead the player on hard mode
	if (skill > 0)
	{
		t = vlen(self.enemy.origin - org) / 666;
		vec = self.enemy.velocity;
		vec_z = 0;
		vec = self.enemy.origin + t * vec;		
	}
	else
	{
		vec = self.enemy.origin;
	}
	vec = normalize((vec + '0 0 10') - org);
	
	self.effects = self.effects | EF_MUZZLEFLASH;	
	missile = spawn ();
	missile.owner = self;

	missile.solid = SOLID_BBOX;
	missile.movetype = MOVETYPE_FLYMISSILE;

	setsize (missile, '0 0 0', '0 0 0');		

	missile.origin = org;
	missile.velocity = vec * 666;
	missile.avelocity = '300 300 300';
	missile.enemy = self.enemy;
	missile.touch = VolMisTouch;
	missile.nextthink = time + 0.1;
	missile.think = VolMisFly;
	sound (self, CHAN_WEAPON, "blob/death1.wav", 1, ATTN_NORM);
};

void() vol_magica1 = [$magica1, vol_magica2] 
	{
		if (time > self.voltaunt_timer)
		{
			sound (self, CHAN_VOICE, "volkerh/volmag1.wav", 1, ATTN_NONE);
			self.voltaunt_timer = time + 4;
		}
		vol_face ();
	};
void() vol_magica2 = [$magica2, vol_magica3] {vol_face ();};
void() vol_magica3 = [$magica3, vol_magica4] {vol_face ();};
void() vol_magica4 = [$magica4, vol_magica5] {vol_face ();};
void() vol_magica5 = [$magica5, vol_magica6] {vol_face ();};
void() vol_magica6 = [$magica6, vol_magica7] 
	{
		VolkerhBloodFist('-30 -140 225', 0);
		vol_face ();
	};
void() vol_magica7 = [$magica7, vol_magica8] 
	{
		VolkerhBloodFist('-29 -145 260', 0);
		vol_face ();
	};
void() vol_magica8 = [$magica8, vol_magica9] 
	{
		VolkerhBloodFist('-30 -146 305', 0);
		vol_face ();
	};
void() vol_magica9 = [$magica9, vol_magica10] 
	{
		VolkerhBloodFist('-30 -147 354', 0);
		vol_face ();
	};
void() vol_magica10 = [$magica10, vol_magica11] 
	{
		VolkerhBloodFist('-34 -138 394', 0);
		vol_face ();
	};
void() vol_magica11 = [$magica11, vol_magica12] 
	{
		VolkerhBloodFist('-44 -132 427', 0);
		vol_face ();
	};
void() vol_magica12 = [$magica12, vol_magica13] 
	{
		VolkerhBloodFist('-49 -124 446', 0);
		vol_face ();
	};
void() vol_magica13 = [$magica13, vol_magica14] 
	{
		VolkerhBloodFist('-49 -125 453', 0);
		vol_face ();
	};
void() vol_magica14 = [$magica14, vol_magica15] 
	{
		VolkerhBloodFist('-48 -131 442', 0);
		vol_face ();
	};
// Clench fist
void() vol_magica15 = [$magica15, vol_magica16] 
	{
		VolkerhBloodFist('-51 -137 428', 1);
		vol_face ();
	};
void() vol_magica16 = [$magica16, vol_magica17] {vol_face();};
void() vol_magica17 = [$magica17, vol_magica18] {vol_face();};
void() vol_magica18 = [$magica18, vol_magica19] {vol_face();};
void() vol_magica19 = [$magica19, vol_magica20] {vol_face();};
// Attack frame
void() vol_magica20 = [$magica20, vol_magica21]
	{
		vector vec, dir;
		float x, y, z;	
		vec = VolRotatePointYaw('187 3 208',self.angles_y);		
		vec = self.origin + vec;
		z = -1;
		while (z <= 1)
		{
			x = -1;
			while (x <= 1)
			{
				y = -1;
				while (y <= 1)
				{
					dir_x = x;
					dir_y = y;
					dir_z = z;
					dir = normalize(dir);
					particle (vec + dir * 8, dir * 32, 220, 100);
					y = y + 1;
				}
				x = x + 1;
			}
			z = z + 1;
		}
		VolkerhMissile();
		vol_face();
	};
void() vol_magica21 = [$magica21, vol_magica22] {};
void() vol_magica22 = [$magica22, vol_magica23] {};
void() vol_magica23 = [$magica23, vol_magica24] {};
void() vol_magica24 = [$magica24, vol_magica25] {};
void() vol_magica25 = [$magica25, vol_magica26] {};
void() vol_magica26 = [$magica26, vol_magica27] {};
void() vol_magica27 = [$magica27, vol_magica28] {};
void() vol_magica28 = [$magica28, vol_magica29] {};
void() vol_magica29 = [$magica29, vol_run1] {};

/*
==============================
MAGIC B - LIGHTNING
------------------------------
Volkerh clasps his hands together and shoots a bolt of lightning.
==============================
*/
void() VolkerhLightning =
{
	local	vector	org, dir;
	
	self.effects = self.effects | EF_MUZZLEFLASH;

	vol_face ();

	org = VolRotatePointYaw('229 0 246',self.angles_y);
	org = org + self.origin;

	dir = normalize((self.enemy.origin + '0 0 16') - org);

	traceline (org, org + dir*4000, TRUE, self);

	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_LIGHTNING1);
	WriteEntity (MSG_BROADCAST, self);
	WriteCoord (MSG_BROADCAST, org_x);
	WriteCoord (MSG_BROADCAST, org_y);
	WriteCoord (MSG_BROADCAST, org_z);
	WriteCoord (MSG_BROADCAST, trace_endpos_x);
	WriteCoord (MSG_BROADCAST, trace_endpos_y);
	WriteCoord (MSG_BROADCAST, trace_endpos_z);

	LightningDamage (org, trace_endpos, self, 30);
};


void() vol_magicb1 = [$magicb1, vol_magicb2] 
	{
		if (time > self.voltaunt_timer)
		{
			sound (self, CHAN_VOICE, "volkerh/volmag2.wav", 1, ATTN_NONE);
			self.voltaunt_timer = time + 4;
		}
		VolkerhBloodFist('7 -116 186', 0);
		VolkerhBloodFist('1 129 202', 0);
		vol_face ();
	};
void() vol_magicb2 = [$magicb2, vol_magicb3] 
	{
		VolkerhBloodFist('-3 -111 189', 0);
		VolkerhBloodFist('3 116 216', 0);
		vol_face ();
	};
void() vol_magicb3 = [$magicb3, vol_magicb4] 
	{
		VolkerhBloodFist('-2 -100 206', 0);
		VolkerhBloodFist('2 106 222', 0);
		vol_face ();
	};
void() vol_magicb4 = [$magicb4, vol_magicb5] 
	{
		VolkerhBloodFist('-2 -90 225', 0);
		VolkerhBloodFist('3 91 239', 0);
		vol_face ();
	};
void() vol_magicb5 = [$magicb5, vol_magicb6] 
	{
		VolkerhBloodFist('-2 -76 240', 0);
		VolkerhBloodFist('3 74 252', 0);
		vol_face ();
	};
void() vol_magicb6 = [$magicb6, vol_magicb7] 
	{
		VolkerhBloodFist('0 -61 247', 0);
		VolkerhBloodFist('10 58 256', 0);
		vol_face ();
	};
void() vol_magicb7 = [$magicb7, vol_magicb8] 
	{
		VolkerhBloodFist('33 -48 245', 0);
		VolkerhBloodFist('34 43 256', 0);
		vol_face ();
	};
void() vol_magicb8 = [$magicb8, vol_magicb9] 
	{
		VolkerhBloodFist('61 -33 265', 0);
		VolkerhBloodFist('63 26 266', 0);
		vol_face ();
	};
void() vol_magicb9 = [$magicb9, vol_magicb10] 
	{
		VolkerhBloodFist('80 -19 277', 0);
		VolkerhBloodFist('79 10 271', 0);
		vol_face ();
	};
void() vol_magicb10 = [$magicb10, vol_magicb11] 
	{
		VolkerhBloodFist('88 -7 281', 0);
		VolkerhBloodFist('88 5 283', 0);
		vol_face ();
	};
void() vol_magicb11 = [$magicb11, vol_magicb12] 
	{
		VolkerhBloodFist('108 0 285', 1);
		VolkerhBloodFist('116 0 303', 1);
		vol_face ();
	};
void() vol_magicb12 = [$magicb12, vol_magicb13] {vol_face();};
void() vol_magicb13 = [$magicb13, vol_magicb14] {vol_face();};
// Attack Start
void() vol_magicb14 = [$magicb14, vol_magicb15]
	{
		VolkerhLightning();
		sound (self, CHAN_WEAPON, "shambler/sboom.wav", 1, ATTN_NONE);
	};
void() vol_magicb15 = [$magicb15, vol_magicb16] 
	{
		VolkerhLightning();
	};
void() vol_magicb16 = [$magicb16, vol_magicb17] 
	{
		VolkerhLightning();
	};
// Attack End
void() vol_magicb17 = [$magicb17, vol_magicb18] {};
void() vol_magicb18 = [$magicb18, vol_magicb19] {};
void() vol_magicb19 = [$magicb19, vol_magicb20] {};
void() vol_magicb20 = [$magicb20, vol_run1]{};

/*
======================
MAGIC C
----------------------
Volkerh raises his hands and blood fountains rise up,
damaging the target and knocking them into the air.
======================
*/

void() VolSpireTouch = 
{
	local vector dir;
	
	if (other == self.owner)
		return;
	
	dir = '0 0 1';
	
	if (other.health)
	{
		T_Damage (other, self, self.owner, 30);
		other.velocity = other.velocity + dir * 666;
		particle (other.origin, other.velocity, 73, 100);
	}
	self.touch = SUB_Null;
};

void() volspire1 = [0, volspire2]{};
void() volspire2 = [1, volspire3]{};
void() volspire3 = [2, volspire4]{};
void() volspire4 = [3, volspire5]{self.touch = VolSpireTouch;};
void() volspire5 = [4, volspire6]{};
void() volspire6 = [5, volspire7]{};
void() volspire7 = [6, volspire8]{};
void() volspire8 = [7, volspire9]{};
void() volspire9 = [8, volspire10]{};
void() volspire10 = [9, volspire11]{};
void() volspire11 = [10, volspire12]{};
void() volspire12 = [11, volspire13]{};
void() volspire13 = [12, volspire14]{};
void() volspire14 = [13, volspire15]{};
void() volspire15 = [14, volspire16]{};
void() volspire16 = {remove(self);};

void() VolkerhBloodspire =
{
	local entity spire;
		
	spire = spawn();
	spire.movetype = MOVETYPE_NONE;
	spire.solid = SOLID_TRIGGER;
	setmodel (spire, "progs/volspire.mdl");
	spire.owner = self;
	setsize (spire, '-32 -32 -32', '32 32 256');
	setorigin (spire, self.enemy.origin);
	particle (spire.origin + '0 0 24', '0 0 0', 73, 100);
	sound (spire, CHAN_WEAPON, "player/inlava.wav", 1, ATTN_NORM);
	spire.nextthink = time;
	spire.think = volspire1;
};

void() vol_magicc1 = [$magicc1, vol_magicc2] 
	{
		if (time > self.voltaunt_timer)
		{
			sound (self, CHAN_VOICE, "volkerh/volmag3.wav", 1, ATTN_NONE);
			self.voltaunt_timer = time + 5.5;
		}
	};
void() vol_magicc2 = [$magicc2, vol_magicc3] {};
void() vol_magicc3 = [$magicc3, vol_magicc4] {};
void() vol_magicc4 = [$magicc4, vol_magicc5] {};
void() vol_magicc5 = [$magicc5, vol_magicc6] {};
void() vol_magicc6 = [$magicc6, vol_magicc7] {};
void() vol_magicc7 = [$magicc7, vol_magicc8] {};
void() vol_magicc8 = [$magicc8, vol_magicc9] {};
void() vol_magicc9 = [$magicc9, vol_magicc10] {};
void() vol_magicc10 = [$magicc10, vol_magicc11] {};
void() vol_magicc11 = [$magicc11, vol_magicc12] 
	{
		VolkerhBloodFist('75 -34 97', 0);
		VolkerhBloodFist('78 32 97', 0);
	};
void() vol_magicc12 = [$magicc12, vol_magicc13] 
	{
		VolkerhBloodFist('96 -32 110', 0);
		VolkerhBloodFist('102 26 110', 0);
	};
void() vol_magicc13 = [$magicc13, vol_magicc14] 
	{
		VolkerhBloodFist('114 -29 137', 0);
		VolkerhBloodFist('116 22 134', 0);
	};
void() vol_magicc14 = [$magicc14, vol_magicc15] 
	{
		VolkerhBloodFist('126 -27 174', 0);
		VolkerhBloodFist('129 21 169', 0);
	};
void() vol_magicc15 = [$magicc15, vol_magicc16] 
	{
		VolkerhBloodFist('128 -30 219', 0);
		VolkerhBloodFist('132 29 215', 0);
	};
void() vol_magicc16 = [$magicc16, vol_magicc17] 
	{
		VolkerhBloodFist('137 -34 265', 0);
		VolkerhBloodFist('134 37 258', 0);
	};
void() vol_magicc17 = [$magicc17, vol_magicc18] 
	{
		VolkerhBloodFist('100 -107 315', 0);
		VolkerhBloodFist('97 105 313', 0);
	};
void() vol_magicc18 = [$magicc18, vol_magicc19] 
	{
		VolkerhBloodFist('37 -218 358', 0.5);
		VolkerhBloodFist('37 212 363', 0.5);
	};
// Attack Start
void() vol_magicc19 = [$magicc19, vol_magicc20] 
	{
		//VolkerhBloodFist('-4 -275 386', 0.25);
		//VolkerhBloodFist('-4 265 393', 0.25);
		VolkerhBloodspire();
	};
void() vol_magicc20 = [$magicc20, vol_magicc21] 
	{
		//VolkerhBloodFist('-4 -281 402', 0.25);
		//VolkerhBloodFist('-8 268 408', 0.25);
		//VolkerhBloodspire();
	};
void() vol_magicc21 = [$magicc21, vol_magicc22] 
	{
		//VolkerhBloodFist('-8 -280 410', 0.25);
		//VolkerhBloodFist('-8 269 420', 0.25);
		VolkerhBloodspire();
	};
void() vol_magicc22 = [$magicc22, vol_magicc23] 
	{
		//VolkerhBloodFist('-8 -282 420', 0.25);
		//VolkerhBloodFist('-8 269 427', 0.25);
		//VolkerhBloodspire();
	};
void() vol_magicc23 = [$magicc23, vol_magicc24] 
	{
		//VolkerhBloodFist('-8 -281 423', 0.25);
		//VolkerhBloodFist('-8 270 429', 0.25);
		VolkerhBloodspire();
	};
void() vol_magicc24 = [$magicc24, vol_magicc25] 
	{
		//VolkerhBloodFist('-8 -283 432', 0.25);
		//VolkerhBloodFist('-8 271 432', 0.25);
		//VolkerhBloodspire();
	};
void() vol_magicc25 = [$magicc25, vol_magicc26] 
	{
		//VolkerhBloodFist('-8 -283 432', 0.25);
		//VolkerhBloodFist('-8 271 432', 0.25);
		VolkerhBloodspire();
	};
void() vol_magicc26 = [$magicc26, vol_magicc27] 
	{
		//VolkerhBloodFist('-8 -283 432', 0.25);
		//VolkerhBloodFist('-8 271 432', 0.25);
		//VolkerhBloodspire();
	};
// Attack Finish
void() vol_magicc27 = [$magicc27, vol_magicc28] {};
void() vol_magicc28 = [$magicc28, vol_magicc29] {};
void() vol_magicc29 = [$magicc29, vol_magicc30] {};
void() vol_magicc30 = [$magicc30, vol_magicc31] {};
void() vol_magicc31 = [$magicc31, vol_magicc32] {};
void() vol_magicc32 = [$magicc32, vol_magicc33] {};
void() vol_magicc33 = [$magicc33, vol_magicc34] {};
void() vol_magicc34 = [$magicc34, vol_magicc35] {};
void() vol_magicc35 = [$magicc35, vol_run1] {};

// ATTACK =======================================================================
void() VolkerhAttack =
{
	local float r;
	r = random();
	
	if (r < 0.33)
		vol_magicc1();
	else if (r < 0.66)
		vol_magicb1();
	else
		vol_magica1();
};

// DAMAGE =======================================================================
void(entity attacker, float damage)	vol_pain =
{
	return;
};

void() vol_gib =
{
	// throw tons of meat chunks	
	local	vector	oldo;
	local	float	x, y, z;
	local	float	r;

	sound (self, CHAN_BODY, "boss2/pop2.wav", 1, ATTN_NORM);
	
	oldo = self.origin;

	z = 0;
	while (z <= 300)
	{
		x = -48;
		while (x <= 48)
		{
			y = -48;
			while (y <= 48)
			{
				self.origin_x = oldo_x + x;
				self.origin_y = oldo_y + y;
				self.origin_z = oldo_z + z;

				r = random();
				if (r < 0.3)				
					ThrowGib ("progs/gib1.mdl", -100);
				else if (r < 0.6)
					ThrowGib ("progs/gib2.mdl", -100);
				else
					ThrowGib ("progs/gib3.mdl", -100);
				y = y + 24;
			}
			x = x + 24;
		}
		z = z + 60;
	}
	remove (self);
};

void() vol_death1      =[      $death1,       vol_death2     ] {sound (self, CHAN_VOICE, "volkerh/voldie.wav", 1, ATTN_NONE);};
void() vol_death2      =[      $death2,       vol_death3     ] {};
void() vol_death3      =[      $death3,       vol_death4     ] {self.solid = SOLID_NOT;};
void() vol_death4      =[      $death4,       vol_death5     ] {};
void() vol_death5      =[      $death5,       vol_death6     ] {};
void() vol_death6      =[      $death6,       vol_death7     ] {};
void() vol_death7      =[      $death7,       vol_death8     ] {};
void() vol_death8      =[      $death8,       vol_death9     ] {};
void() vol_death9      =[      $death9,       vol_death10    ] {};
void() vol_death10     =[      $death10,      vol_death11    ] {};
void() vol_death11     =[      $death11,      vol_death12    ] {};
void() vol_death12     =[      $death12,      vol_death13    ] {};
void() vol_death13     =[      $death13,      vol_death14    ] {};
void() vol_death14     =[      $death14,      vol_death15    ] {};
void() vol_death15     =[      $death15,      vol_death16    ] {};
void() vol_death16     =[      $death16,      vol_death17    ] {};
void() vol_death17     =[      $death17,      vol_death18    ] {};
void() vol_death18     =[      $death18,      vol_death19    ] {};
void() vol_death19     =[      $death19,      vol_death20    ] {};
void() vol_death20     =[      $death20,      vol_death21    ] {};
void() vol_death21     =[      $death21,      vol_death22    ] {};
void() vol_death22     =[      $death22,      vol_death23    ] 
	{
		VolkerhBloodFist('110 0 287', 1);
		VolkerhBloodFist('67 0 230', 1);
	};
void() vol_death23     =[      $death23,      vol_death24    ] {};
void() vol_death24     =[      $death24,      vol_death25    ] {};
void() vol_death25     =[      $death25,      vol_death26    ] {};
void() vol_death26     =[      $death26,      vol_gib	     ] {};

void() vol_wake = 
{
	sound (self, CHAN_VOICE, "volkerh/volwake.wav", 1, ATTN_NONE);
	self.voltaunt_timer = time + 12;
};

//============================================================================

void() monster_volkerh =
{
	if (deathmatch)
	{
		remove(self);
		return;
	}
	
	precache_model ("progs/volkerh.mdl");
	precache_model ("progs/volspire.mdl");
	
	precache_sound2 ("blob/death1.wav");
	precache_sound ("shambler/sboom.wav");
	precache_sound ("player/inlava.wav");
	precache_sound2 ("boss2/pop2.wav");
	
	precache_sound ("volkerh/volwake.wav");
	precache_sound ("volkerh/voltaunt1.wav");
	precache_sound ("volkerh/voltaunt2.wav");
	precache_sound ("volkerh/voltaunt3.wav");
	precache_sound ("volkerh/volmag1.wav");
	precache_sound ("volkerh/volmag2.wav");
	precache_sound ("volkerh/volmag3.wav");
	precache_sound ("volkerh/voldie.wav");

	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	setmodel (self, "progs/volkerh.mdl");

	setsize (self, '-64 -72 0', '64 72 448');
	self.health = 6000;

	self.th_stand = vol_stand1;
	self.th_walk = vol_walk1;
	self.th_run = vol_run1;
	self.th_die = vol_death1;
	//self.th_melee = VolkerhAttack;
	self.th_missile = VolkerhAttack;
	self.th_pain = vol_pain;
	self.use = vol_wake;
	
	flymonster_start();
};

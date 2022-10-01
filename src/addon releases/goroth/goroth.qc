/*
==============================================================================

GOROTH

==============================================================================

To set up Goroth fully, add this before ai.qc's "void() SightSound" function:

void() gor_wake;

And add this to ai.qc's "void() SightSound" function:

	else if (self.classname == "monster_goroth")
		sound (self, CHAN_VOICE, "goroth/gorwake.wav", 1, ATTN_NONE);

Add this to client.qc's void() ClientObituary = function, after the line "if (attacker.flags & FL_MONSTER)":

				if (attacker.classname == "monster_goroth")
					bprint (" was dominated by Goroth\n");

And add this line to your FGD file to see him properly in Trenchbroom:

@PointClass base(Monster) size(-96 -96 -24, 96 96 288) model({ "path": ":progs/goroth.mdl" }) = monster_goroth : "Goroth" []

*/

.float gormis_t;
.float gortaunt_timer;

vector(vector point, float ang) GorRotatePointYaw =
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

// "modified" from boss.qc
void() gor_run =
{
	
// go for another player if multi player
	if (self.enemy.health <= 0 || random() < 0.02)
	{
		self.enemy = find(self.enemy, classname, "player");
		if (!self.enemy)
			self.enemy = find(self.enemy, classname, "player");
	}
	ai_run(10);
};

$frame stand1 stand2 stand3 stand4 stand5 stand6 stand7 stand8 stand9
$frame stand10 stand11 stand12 stand13 stand14 stand15 stand16 stand17
$frame stand18 stand19 stand20

$frame walk1 walk2 walk3 walk4 walk5 walk6 walk7 
$frame walk8 walk9 walk10 walk11 walk12

$frame smash1 smash2 smash3 smash4 smash5 smash6 smash7 smash8 smash9 smash10
$frame smash11 smash12 smash13 smash14 smash15 smash16 smash17 smash18 smash19 smash20
$frame smash21 smash22 smash23 smash24 smash25 smash26 smash27

$frame magic1 magic2 magic3 magic4 magic5 magic6 magic7 magic8 magic9
$frame magic10 magic11 magic12 magic13 magic14 magic15 magic16 magic17 magic18 magic19
$frame magic20 magic21 magic22 magic23 magic24 magic25 magic26

$frame death1 death2 death3 death4 death5 death6 death7 death8 death9 death10
$frame death11 death12 death13 death14 death15 death16 death17 death18 death19
$frame death20 death21 death22

$frame ball1 ball2 ball3 ball4 ball5 ball6 ball7 ball8 ball9 ball10
$frame ball11 ball12 ball13 ball14 ball15 ball16 ball17 ball18 ball19 ball20

void() GorothTaunt =
{
	local float r;
	r = random();
	
	if (r < 0.33)
		sound (self, CHAN_VOICE, "goroth/gortaunt1.wav", 1, ATTN_NONE);
		self.gortaunt_timer = time + 5;
	if (r >= 0.33 && r < 0.66)
		sound (self, CHAN_VOICE, "goroth/gortaunt2.wav", 1, ATTN_NONE);
		self.gortaunt_timer = time + 10;
	if (r >= 0.66)
		sound (self, CHAN_VOICE, "goroth/gortaunt3.wav", 1, ATTN_NONE);
		self.gortaunt_timer = time + 7;
};

void() gor_stand1	=[	$stand1,	gor_stand2	] {ai_stand();};
void() gor_stand2	=[	$stand2,	gor_stand3	] {ai_stand();};
void() gor_stand3	=[	$stand3,	gor_stand4	] {ai_stand();};
void() gor_stand4	=[	$stand4,	gor_stand5	] {ai_stand();};
void() gor_stand5	=[	$stand5,	gor_stand6	] {ai_stand();};
void() gor_stand6	=[	$stand6,	gor_stand7	] {ai_stand();};
void() gor_stand7	=[	$stand7,	gor_stand8	] {ai_stand();};
void() gor_stand8	=[	$stand8,	gor_stand9	] {ai_stand();};
void() gor_stand9	=[	$stand9,	gor_stand10] {ai_stand();};
void() gor_stand10	=[	$stand10,	gor_stand11] {ai_stand();};
void() gor_stand11	=[	$stand11,	gor_stand12] {ai_stand();};
void() gor_stand12	=[	$stand12,	gor_stand13] {ai_stand();};
void() gor_stand13	=[	$stand13,	gor_stand14] {ai_stand();};
void() gor_stand14	=[	$stand14,	gor_stand15] {ai_stand();};
void() gor_stand15	=[	$stand15,	gor_stand16] {ai_stand();};
void() gor_stand16	=[	$stand16,	gor_stand17] {ai_stand();};
void() gor_stand17	=[	$stand17,	gor_stand18] {ai_stand();};
void() gor_stand18	=[	$stand18,	gor_stand19] {ai_stand();};
void() gor_stand19	=[	$stand19,	gor_stand20] {ai_stand();};
void() gor_stand20	=[	$stand20,	gor_stand1] {ai_stand();};

void() gor_walk1		=[      $walk1,       gor_walk2 ] {ai_walk(7);};
void() gor_walk2       =[      $walk2,        gor_walk3 ] {ai_walk(7);};
void() gor_walk3       =[      $walk3,        gor_walk4 ] {ai_walk(7);};
void() gor_walk4       =[      $walk4,        gor_walk5 ] {ai_walk(7);};
void() gor_walk5       =[      $walk5,        gor_walk6 ] {ai_walk(7);};
void() gor_walk6       =[      $walk6,        gor_walk7 ] {ai_walk(7);};
void() gor_walk7       =[      $walk7,        gor_walk8 ] {ai_walk(7);};
void() gor_walk8       =[      $walk8,        gor_walk9 ] {ai_walk(7);};
void() gor_walk9       =[      $walk9,        gor_walk10] {ai_walk(7);};
void() gor_walk10      =[      $walk10,       gor_walk11] {ai_walk(7);};
void() gor_walk11      =[      $walk11,       gor_walk12] {ai_walk(7);};
void() gor_walk12      =[      $walk12,       gor_walk1 ] {ai_walk(7);};

void() gor_run1 =[$walk1, gor_run2 ] {gor_run();};
void() gor_run2 =[$walk2, gor_run3 ] {gor_run();};
void() gor_run3 =[$walk3, gor_run4 ] {gor_run();};
void() gor_run4 =[$walk4, gor_run5 ] {gor_run();};
void() gor_run5 =[$walk5, gor_run6 ] {gor_run();};
void() gor_run6 =[$walk6, gor_run7 ] {gor_run();};
void() gor_run7 =[$walk7, gor_run8 ] {gor_run();};
void() gor_run8 =[$walk8, gor_run9 ] {gor_run();};
void() gor_run9 =[$walk9, gor_run10] {gor_run();};
void() gor_run10 =[$walk10, gor_run11] {gor_run();};
void() gor_run11 =[$walk11, gor_run12] {gor_run();};
void() gor_run12 =[$walk12, gor_run1] 
	{
		if (time > self.gortaunt_timer)
		{
			GorothTaunt();
		}
		ai_run(10);
	};

/*
=================================
SMASH ATTACK
---------------------------------
Goroth raises his right fist high in the air and then punches the ground hard,
causing a shockwave of explosions to emanate from all around his position.
=================================
*/
void(vector lavapos) GorothLavaSplash = 
{
	local vector vec, dir;
	local float x, y, z;
		
	vec = GorRotatePointYaw(lavapos,self.angles_y);		
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
				particle (vec + dir * 8, dir * 32, 232, 50);
				y = y + 1;
			}
			x = x + 1;
		}
		z = z + 1;
	}
}

void() GorothSmashTouch = 
{
	local	float	r;
	local	entity exp;
	
	T_RadiusDamage (self, self.owner, 30, self.owner);
	
	if (self.gormis_t > time)
		return;
	
	// Explosions occur as the missile travels
	r = random() * 2 - 1;
	
	makevectors(self.angles);
	
	exp = spawn();
	exp.origin = self.origin + r * 32 * v_right;
	
	exp.movetype = MOVETYPE_TOSS;
	exp.velocity = '0 0 200';
	exp.avelocity_x = random()*600;
	exp.avelocity_y = random()*600;
	exp.avelocity_z = random()*600;
	exp.touch = SUB_Null;
	setmodel (exp, "progs/s_explod.spr");
	exp.solid = SOLID_NOT;
	exp.nextthink = time;
	exp.think = s_explode1;
	
	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);
	
	self.gormis_t = time + 0.1 + random() * 0.5;
};


void(vector dir, float rmv_t) GorothSmashMissile = 
{
	local	vector	org;
	local	entity	gmis;
	
	gmis = spawn();
	gmis.gormis_t = 0;
	gmis.owner = self;
	gmis.movetype = MOVETYPE_FLY;
	gmis.solid = SOLID_BBOX;
	gmis.effects = EF_DIMLIGHT;
	setsize (gmis, '-16 -16 -32', '16 16 0');
	makevectors(self.angles);
	org = self.origin + v_forward * 128;
	setorigin (gmis, org);
	
	gmis.velocity = dir * 500;
	gmis.angles = vectoangles(gmis.velocity);
	gmis.nextthink = time + rmv_t;
	gmis.think = SUB_Remove;
	gmis.touch = GorothSmashTouch;
};

void() gor_smash1     =[      $smash1,       gor_smash2    ]
	{
		if (time > self.gortaunt_timer)
		{
			sound (self, CHAN_VOICE, "goroth/gorsmash.wav", 1, ATTN_NONE);
			self.gortaunt_timer = time + 4;
		}
		ai_charge(2);
	};
void() gor_smash2     =[      $smash2,       gor_smash3    ]{ai_charge(2);};
void() gor_smash3     =[      $smash3,       gor_smash4    ]{ai_charge(2);};
void() gor_smash4     =[      $smash4,       gor_smash5    ]{ai_charge(2);};
void() gor_smash5     =[      $smash5,       gor_smash6    ]{ai_charge(2);};
void() gor_smash6     =[      $smash6,       gor_smash7    ]{ai_charge(2);};
void() gor_smash7     =[      $smash7,       gor_smash8    ]{ai_charge(2);};
void() gor_smash8     =[      $smash8,       gor_smash9    ]{ai_charge(2);};
void() gor_smash9     =[      $smash9,       gor_smash10   ]{ai_charge(2);};
void() gor_smash10    =[      $smash10,      gor_smash11   ]{ai_charge(2);};
void() gor_smash11    =[      $smash11,      gor_smash12   ]{ai_charge(2);};
void() gor_smash12    =[      $smash12,      gor_smash13   ]{ai_charge(2);};
// Fist raised
void() gor_smash13    =[      $smash13,      gor_smash14   ]{};
void() gor_smash14    =[      $smash14,      gor_smash15   ]{};
void() gor_smash15    =[      $smash15,      gor_smash16   ]{};
// Strike the ground
void() gor_smash16    =[      $smash16,      gor_smash17   ]
	{
		float ang;
		vector vec;
		
		self.enemy.punchangle_x = -2;
		T_RadiusDamage (self, self, 300, self);
		
		GorothLavaSplash('227 9 -20');
		
		ang = 0;
		while (ang <= 315)
		{
			vec = self.v_angle;
			vec_y = vec_y + ang;
			makevectors(vec);
			GorothSmashMissile(v_forward,13);
			ang = ang + 45;
		}
	};
void() gor_smash17    =[      $smash17,      gor_smash18   ]{};
void() gor_smash18    =[      $smash18,      gor_smash19   ]{};
void() gor_smash19    =[      $smash19,      gor_smash20   ]{};
void() gor_smash20    =[      $smash20,      gor_smash21   ]{};
void() gor_smash21    =[      $smash21,      gor_smash22   ]{};
void() gor_smash22    =[      $smash22,      gor_smash23   ]{};
void() gor_smash23    =[      $smash23,      gor_smash24   ]{};
void() gor_smash24    =[      $smash24,      gor_smash25   ]{};
void() gor_smash25    =[      $smash25,      gor_smash26   ]{};
void() gor_smash26    =[      $smash26,      gor_smash27   ]{};
void() gor_smash27    =[      $smash27,      gor_run1	   ]{};

/*
=======================
MAGIC
-----------------------
Goroth summons 3 molten rock pillars from the ground on the target's position,
all of which proceed to explode after a few seconds. Upon finishing, Goroth slams
both fists on the ground, causing a shockwave of explosions in a straight line
directly in front of him.
=======================
*/
void() GorothRockExplode =
{
	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);
	
	//T_RadiusDamage (self, self.owner, 100, self.owner);
	
	BecomeExplosion();
};

void() gorrock1 = [0, gorrock2]{sound (self, CHAN_VOICE, "goroth/gorrock.wav", 1, ATTN_NORM);};
void() gorrock2 = [1, gorrock3]{};
void() gorrock3 = [2, gorrock4]{};
void() gorrock4 = [3, gorrock5]{};
void() gorrock5 = [4, gorrock6]{T_RadiusDamage(self,self.owner,50,self.owner);};
void() gorrock6 = [5, gorrock7]{T_RadiusDamage(self,self.owner,50,self.owner);};
void() gorrock7 = [5, gorrock8]{T_RadiusDamage(self,self.owner,50,self.owner);};
void() gorrock8 = [5, gorrock9]{T_RadiusDamage(self,self.owner,50,self.owner);};
void() gorrock9 = [5, gorrock10]{T_RadiusDamage(self,self.owner,50,self.owner);};
void() gorrock10 = [5, GorothRockExplode]{T_RadiusDamage(self,self.owner,50,self.owner);};	

void() GorothRock =
{
	local	entity	rock;
	local	vector	org;
	
	rock = spawn();
	rock.movetype = MOVETYPE_NONE;
	rock.solid = SOLID_NOT;
	setmodel (rock, "progs/gorrock.mdl");
	rock.owner = self;
	setsize (rock, '-48 -48 -24', '48 48 192');
	org = self.enemy.origin;	
	org_z = org_z - 2048;
	traceline(self.enemy.origin,org,1,self.enemy);
	org = trace_endpos;
	setorigin (rock, org);
	
	rock.nextthink = time;
	rock.think = gorrock1;
};

void() gor_magic1	=[	$magic1,	gor_magic2	]
	{
		if (time > self.gortaunt_timer)
		{
			sound (self, CHAN_VOICE, "goroth/gormagic.wav", 1, ATTN_NONE);
			self.gortaunt_timer = time + 5;
		}
	};
void() gor_magic2	=[	$magic2,	gor_magic3	]{};
void() gor_magic3	=[	$magic3,	gor_magic4	]{};
void() gor_magic4	=[	$magic4,	gor_magic5	]{};
void() gor_magic5	=[	$magic5,	gor_magic6	]{};
// Begin summoning magic stuff
void() gor_magic6	=[	$magic6,	gor_magic7	]{};
void() gor_magic7	=[	$magic7,	gor_magic8	]{};
void() gor_magic8	=[	$magic8,	gor_magic9	]{};
void() gor_magic9	=[	$magic9,	gor_magic10	]{};
void() gor_magic10	=[	$magic10,	gor_magic11	]{};
void() gor_magic11	=[	$magic11,	gor_magic12	]{};
void() gor_magic12	=[	$magic12,	gor_magic13	]{GorothRock();};
void() gor_magic13	=[	$magic13,	gor_magic14	]{};
void() gor_magic14	=[	$magic14,	gor_magic15	]{GorothRock();};
void() gor_magic15	=[	$magic15,	gor_magic16	]{};
void() gor_magic16	=[	$magic16,	gor_magic17	]{GorothRock();};
// End magic summon, get ready to smash
void() gor_magic17	=[	$magic17,	gor_magic18	]{ai_charge(2);};
void() gor_magic18	=[	$magic18,	gor_magic19	]{ai_charge(2);};
void() gor_magic19	=[	$magic19,	gor_magic20	]{ai_charge(2);};
void() gor_magic20	=[	$magic20,	gor_magic21	]{ai_charge(2);};
// Smash the ground
void() gor_magic21	=[	$magic21,	gor_magic22	]
	{
		float ang;
		vector vec;
		
		self.enemy.punchangle_x = -2;
		T_RadiusDamage (self, self, 300, self);
		
		GorothLavaSplash('227 0 -20');
		
		ang = -15;
		while (ang <= 15)
		{
			vec = aim(self.enemy,500);
			vec_y = vec_y + ang;
			//makevectors(vec);
			GorothSmashMissile(vec,13);
			ang = ang + 5;
		}
	};
void() gor_magic22	=[	$magic22,	gor_magic23	]{};
void() gor_magic23	=[	$magic23,	gor_magic24	]{};
void() gor_magic24	=[	$magic24,	gor_magic25	]{};
void() gor_magic25	=[	$magic25,	gor_magic26	]{};
void() gor_magic26	=[	$magic26,	gor_run1	]{};


/*
==========================
BALL
--------------------------
Goroth throws a spicy meatball and taunts the target.
==========================
*/
void() gor_ball1 = [$ball1, gor_ball2]
	{
		if (time > self.gortaunt_timer)
		{
			sound (self, CHAN_VOICE, "goroth/gorsmash.wav", 1, ATTN_NONE);
			self.gortaunt_timer = time + 4;
		}
	};
void() gor_ball2 = [$ball2, gor_ball3] {ai_face();};
void() gor_ball3 = [$ball3, gor_ball4] {ai_face();};
void() gor_ball4 = [$ball4, gor_ball5] {GorothLavaSplash('-88 87 430');ai_face();};
void() gor_ball5 = [$ball5, gor_ball6] {ai_face();};
void() gor_ball6 = [$ball6, gor_ball7] 
	{
		ai_face();
		local	vector	org, vec;
		local	float	t;
		
		org = GorRotatePointYaw('233 59 143',self.angles_y);
		org = org + self.origin;
		vec = normalize (self.enemy.origin - org);

		launch_spike (org, vec);
		setmodel (newmis, "progs/lavaball.mdl");
		newmis.avelocity = '200 100 300';
		setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);		
		newmis.velocity = vec*666;
		newmis.touch = T_MissileTouch; // rocket explosion
		newmis.effects = EF_DIMLIGHT;
		sound (self, CHAN_WEAPON, "boss1/throw.wav", 1, ATTN_NORM);
	};
void() gor_ball7 = [$ball7, gor_ball8] {ai_face();};
void() gor_ball8 = [$ball8, gor_ball9] {ai_face();};
void() gor_ball9 = [$ball9, gor_ball10] {ai_face();};
void() gor_ball10 = [$ball10, gor_ball11] {ai_face();};
void() gor_ball11 = [$ball11, gor_ball12] {ai_face();};
void() gor_ball12 = [$ball12, gor_ball13] {ai_face();};
void() gor_ball13 = [$ball13, gor_ball14] 
	{
		if (time > self.gortaunt_timer)
		{
			GorothTaunt();
		}
		ai_face();
	};
void() gor_ball14 = [$ball14, gor_ball15] {ai_face();};
void() gor_ball15 = [$ball15, gor_ball16] {ai_face();};
void() gor_ball16 = [$ball16, gor_ball17] {};
void() gor_ball17 = [$ball17, gor_ball18] {};
void() gor_ball18 = [$ball18, gor_ball19] {};
void() gor_ball19 = [$ball19, gor_ball20] {};
void() gor_ball20 = [$ball20, gor_run1] {};

// ATTACK =======================================================================
void() GorothAttack =
{
	local float r;
	r = random();
	
	if (r < 0.33)
		gor_magic1();
	else if (r < 0.66)
		gor_smash1();
	else
		gor_ball1();
};

// DAMAGE =======================================================================
void(entity attacker, float damage)	gor_pain =
{
	//GorothTaunt();
	return;
};

void() gor_gib =
{
	// throw tons of meat chunks	
	local	vector	oldo;
	local	float	x, y, z;
	local	float	r;

	sound (self, CHAN_BODY, "boss2/pop2.wav", 1, ATTN_NORM);
	
	oldo = self.origin;

	z = -24;
	while (z <= 128)
	{
		x = -48;
		while (x <= 256)
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
		z = z + 64;
	}
	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_LAVASPLASH);
	WriteCoord (MSG_BROADCAST, self.origin_x - 160);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z - 128);	
	remove (self);
};

void() gor_death1      =[      $death1,       gor_death2     ] {sound (self, CHAN_VOICE, "goroth/gordie.wav", 1, ATTN_NONE);};
void() gor_death2      =[      $death2,       gor_death3     ] {};
void() gor_death3      =[      $death3,       gor_death4     ] {self.solid = SOLID_NOT;};
void() gor_death4      =[      $death4,       gor_death5     ] {};
void() gor_death5      =[      $death5,       gor_death6     ] {};
void() gor_death6      =[      $death6,       gor_death7     ] {};
void() gor_death7      =[      $death7,       gor_death8     ] {};
void() gor_death8      =[      $death8,       gor_death9     ] {};
void() gor_death9      =[      $death9,       gor_death10    ] {};
void() gor_death10     =[      $death10,      gor_death11    ] {};
void() gor_death11     =[      $death11,      gor_death12    ] {};
void() gor_death12     =[      $death12,      gor_death13    ] {};
void() gor_death13     =[      $death13,      gor_death14    ] {};
void() gor_death14     =[      $death14,      gor_death15    ] {};
void() gor_death15     =[      $death15,      gor_death16    ] {};
void() gor_death16     =[      $death16,      gor_death17    ] {};
void() gor_death17     =[      $death17,      gor_death18    ] {};
void() gor_death18     =[      $death18,      gor_death19    ] {};
void() gor_death19     =[      $death19,      gor_death20    ] {};
void() gor_death20     =[      $death20,      gor_death21    ] {};
void() gor_death21     =[      $death21,      gor_gib	     ] {};

void() gor_wake = 
{
	sound (self, CHAN_VOICE, "goroth/gorwake.wav", 1, ATTN_NONE);
	self.gortaunt_timer = time + 10;
};

//============================================================================

void() monster_goroth =
{
	if (deathmatch)
	{
		remove(self);
		return;
	}
	precache_model ("progs/goroth.mdl");
	precache_model ("progs/gorrock.mdl");
	
	precache_model ("progs/lavaball.mdl");
	precache_sound2 ("boss2/pop2.wav");
	precache_sound ("weapons/rocket1i.wav");
	precache_sound ("boss1/throw.wav");
	
	precache_sound ("goroth/gorwake.wav");
	precache_sound ("goroth/gortaunt1.wav");
	precache_sound ("goroth/gortaunt2.wav");
	precache_sound ("goroth/gortaunt3.wav");
	precache_sound ("goroth/gordie.wav");
	precache_sound ("goroth/gorsmash.wav");
	precache_sound ("goroth/gormagic.wav");
	precache_sound ("goroth/gorrock.wav");

	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	setmodel (self, "progs/goroth.mdl");

	setsize (self, '-96 -96 -24', '96 96 288');
	self.health = 6000;

	self.th_stand = gor_stand1;
	self.th_walk = gor_walk1;
	self.th_run = gor_run1;
	self.th_die = gor_death1;
	self.th_melee = GorothAttack;
	self.th_missile = GorothAttack;
	self.th_pain = gor_pain;
	self.use = gor_wake;
	
	walkmonster_start();
};

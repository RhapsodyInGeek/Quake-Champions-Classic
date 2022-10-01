/*
=================================================
QUAKE CHAMPIONS CLASSIC
=================================================
NEW CHAMPION INSTRUCTIONS
* Champion mdl must have matching animation frame counts with default player.mdl;
	they don't have to be animated the same, but we still use the player animation calls.
	Ability / extra animations should start on frame 144.
* Champions should be sized similarly to Ranger as they will use his navigation hull. See qccchamps.qc > QCC_SpawnChampion.
* If using a custom melee weapon, the first 9 frames must be dedicated to idle (1), swing A (2-4), and swing B (5-8).
	If reusing the melee model for an ability, add these extra animations starting from frame 10.
* qccdefs.qc:
	-Add the Spawn and Ability method references. Recommended below QCC_FlameStrike.
	-Add a float constant for the Champion ID. Don't conflict with other Champion IDs.
* qccchamps.qc:
	-Add all required precaches (models, sounds) to QCC_Precaches. Every model and sound you use for your champion.
	-Add Champion spawn method call to QCC_SpawnChampion.
	-Add Champion to selection method QCC_PickChampion.

CHAMPION SPAWN METHOD TEMPLATE
All of the fields must be defined. I can't be held responsible for your failure to do so.

void() QCC_ChampionName =
	{
		// Stats
		self.qccClass = QCC_MEDIUM;
		QCC_SetSpeed(340);
		// Model
		setmodel (self, "progs/qcranger.mdl");
		self.qccChampGib = "progs/h_player.mdl"; // head model on gib
		self.qccMeleeMdl = "progs/v_axe.mdl"; // melee weapon model
		// Sounds
		self.qccSndMelee = // axe, sword, gauntlet sound
		self.qccSndJump = 
		self.qccSndLand1 = // soft landing
		self.qccSndLand2 = // cronch landing
		self.qccSndPain1 = 
		self.qccSndPain2 = 
		self.qccSndPain3 = 
		self.qccSndPain4 = 
		self.qccSndPain5 = 
		self.qccSndPain6 = 
		self.qccSndDeath1 = 
		self.qccSndDeath2 = 
		self.qccSndDeath3 = 
		self.qccSndDeath4 = 
		self.qccSndDeath5 = 
		self.qccSndAxHit1 = 
		self.qccSndBurn1 = 
		self.qccSndBurn2 = 
		self.qccSndGasp1 = // gasping for air on water exit
		self.qccSndGasp2 = 
		self.qccSndDrown1 = // water pain
		self.qccSndDrown2 = 
		self.qccSndH2oDeath = 
	};
	
*/

// Borrowed from Triggers
void (vector org) spawn_tfog;
void (vector org, entity death_owner) spawn_tdeath; 

// SHARED
void() QCC_Precaches;
void() QCC_SpawnChampion;
void() QCC_PickChampion;
void() QCC_FireAbility;
void(entity ent) QCC_AbilityCooldown;
void() QCC_RestoreWeapon;
void() item_hourglass;

// CHAMPIONS
// Ranger
void() QCC_Ranger;
void() QCC_DireOrbThrow;
void() QCC_DireOrbWarp;
// Death Knight
void() QCC_DeathKnight;
void() QCC_FlameStrike;
void(entity f_owner, entity f_target) QCC_CatchFire;
void() QCC_OnFireThink;

// QCC Fields
float QCC_ABILITY = 22137;
float QCC_LIGHT = 0;
float QCC_MEDIUM = 1;
float QCC_HEAVY = 2;
// Champion IDs
float QCC_RANGER = 0;
float QCC_DEATHKNIGHT = 1;
float QCC_NYX = 2;
float QCC_SCALEBEARER = 3;

.float qccNextChampion;
.float qccChampion;
.float qccClass;
.float modelindex_champ; // used in conjunction with the client.qc hackery, maintains champion model indexing after invisibility and other nonsense
.string qccChampGib; // head model on gib
.string qccMeleeMdl; // melee weapon model
.entity qccAbilityEnt;
.entity qccAbilityOwner;
.float qccAbilityTimer;
.float qccAbilityFrameCt;
.float qccPrevWep;
.float qccOnFire;

.string qccSndMelee; // axe, sword, gauntlet sound
.string qccSndJump;
.string qccSndLand1; // soft landing
.string qccSndLand2; // cronch landing
.string qccSndPain1;
.string qccSndPain2;
.string qccSndPain3;
.string qccSndPain4;
.string qccSndPain5;
.string qccSndPain6;
.string qccSndDeath1;
.string qccSndDeath2;
.string qccSndDeath3;
.string qccSndDeath4;
.string qccSndDeath5;
.string qccSndAxHit1;
.string qccSndBurn1;
.string qccSndBurn2;
.string qccSndGasp1; // gasping for air on water exit
.string qccSndGasp2;
.string qccSndDrown1; // water pain
.string qccSndDrown2;
.string qccSndH2oDeath;


// Various helpful math functions
vector(vector point, float ang) QCC_RotatePointYaw =
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

/*
=================================================
MODIFIED BASE QC FUNCTIONS
combat
	T_Damage			|	halved Ranger self damage
	Killed				|	reduce ability timer by 4.5 seconds on monster kill
	PlayerJump			|	modified all player sound references to use qccSnd... strings
	WaterMove			|	^^^
	PlayerPostThink		|	^^^
items
	T_Heal				|	removes qccOnFire
	item_health			|	replaced rotten health with hourglasses
	bound_other_ammo	|	set new ammo limits - shells, rockets: 25, nails, cells: 150
	weapon_touch		|	change cells added on LG pickup 15 to 30
	ammo_touch			|	set new ammo limits - shells, rockets: 25, nails, cells: 150; remove auto swap
weapons
	W_FireAxe			|	set damage from 20 to 70
	W_FireShotgun		|	set pellets from 6 to 10
	W_FireSuperShotgun	|	set pellets from 14 to 30
	T_MissileTouch		|	removed RNG from damage
	W_FireLightning		|	decreased damage 30 to 13
	spike_touch			|	increased damage 9 to 12, added splash damage
	superspike_touch	|	added splash damage
	W_SetCurrentAmmo	|	changed axe models to use qccMeleeMdl reference
	W_Attack			|	changed axe sound to use QCC reference
	CheatCommand		|	added set qccAbilityTimer to 0
	ImpulseCommands		|	added QCC_FireAbility as Impulse 22; added QCC_PickChampion as Impulse 100
world
	worldspawn			|	added call to QCC_Precache()
client
	ClientKill			|	changed modelindex_player to self.modelindex_champ
	PutClientInServer	|	this is where the player spawning happens; we should override it with QCC_SpawnChampion()
	CheckPowerups		|	changed modelindex_player to self.modelindex_champ
	WaterMove			|	Death Knight unharmed by lava
player
	PainSound			|	modified all sound references to use qccSnd... strings
	DeathSound			|	^^^^^^
	GibPlayer			|	changed ThrowHead() to use qccChampGib
	PlayerDie			|	changed modelindex_player to self.modelindex_champ
*/
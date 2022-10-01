// VOLKERH v1.0 ========================================================================
Volkerh from Quake Champions has been summoned, and he is very hungry! As the Elder God
of the Realm of Black Magic, Volkerh uses the blood power from his sacrifices to cast 3
different spells: a dark magic missile, a thunderbolt, and the bloodspires.

No permissions required by me to use or modify the wizard of whispers or any of his assets.
Credit appreciated but not required.

// CONTENTS ============================================================================
* Volkerh MDL		(progs/volkerh.mdl)
* Blood Spire MDL	(progs/volspire.mdl)
* 8 sounds		(sound/volkerh/voldie.wav)
			(sound/volkerh/volmag1.wav)
			(sound/volkerh/volmag2.wav)
			(sound/volkerh/volmag3.wav)
			(sound/volkerh/voltaunt1.wav)
			(sound/volkerh/voltaunt2.wav)
			(sound/volkerh/voltaunt3.wav)
			(sound/volkerh/volwake.wav)
* Volkerh QC		(volkerh.qc)
* Volkerh Model Source	(volkerh.blend)

// SETUP ===============================================================================
To set up Volkerh fully, add this before ai.qc's "void() SightSound" function:

void() vol_wake;

And add this to ai.qc's "void() SightSound" function:

	else if (self.classname == "monster_volkerh")
		sound (self, CHAN_VOICE, "volkerh/volwake.wav", 1, ATTN_NONE);

Add this to client.qc's void() ClientObituary = function, after the line "if (attacker.flags & FL_MONSTER)":

				if (attacker.classname == "monster_volkerh")
					bprint ("'s blood was feasted upon by Volkerh\n");

"volkerh.qc" should be placed after all of the base qc files in your "progs.src", just to be safe.

And add this line to your FGD file to see him properly in Trenchbroom:

@PointClass base(Monster) size(-96 -96 -24, 96 96 288) model({ "path": ":progs/volkerh.mdl" }) = monster_volkerh : "Volkerh" []

// USEAGE RECOMMENDATIONS ==============================================================
Volkerh comes with 6000HP, with the recommendation / encouragement that you design some sort of 
environmental method of defeating him. That said, you may want to lower his HP to a more appropriate 
amount or design your map around Volkerh being a bullet sponge.

Be sure to provide ample cover. Volkerh's attacks are randomized, and he effectively has a shambler lightning bolt that can't be outrun.

Volkerh's map collision handling may be weird. AFAIK Quake handles map collision using 2 different hull sizes,
both of which are far smaller than Volkerh, so he *may* be able to fit in spaces he really shouldn't be able to or fly straight up "out of" the map.
Design your maps around that caveat of huge monsters accordingly. I recommend a very high skybox.

// CHANGELOG ===========================================================================
v1.0
First release
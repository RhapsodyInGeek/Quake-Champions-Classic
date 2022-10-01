// GOROTH v1.2 =========================================================================
Goroth arrives from Quake Champions! He comes with 3 devastating attacks: a punch to the ground that sends out
a shockwave of explosions, a magic attack that causes stones to rise up from the ground beneath you and explode,
and he pitches a spicy fastball. He also stomps around yelling at you.

No permissions required by me to use or modify the big boy or any of his assets.
Credit appreciated but not required.

// CONTENTS ============================================================================
* Goroth MDL		(progs/goroth.mdl)
* Molten Rock MDL	(progs/gorrock.mdl)
* 8 sounds		(sound/goroth/gordie.wav)
			(sound/goroth/gormagic.wav)
			(sound/goroth/gorrock.wav)
			(sound/goroth/gorsmash.wav)
			(sound/goroth/gortaunt1.wav)
			(sound/goroth/gortaunt2.wav)
			(sound/goroth/gortaunt3.wav)
			(sound/goroth/gorwake.wav)
* Goroth QC		(goroth.qc)
* Goroth Model Source	(goroth.blend)

// SETUP ===============================================================================
To set up Goroth fully, add this before ai.qc's "void() SightSound" function:

void() gor_wake;

And add this to ai.qc's "void() SightSound" function:

	else if (self.classname == "monster_goroth")
		sound (self, CHAN_VOICE, "goroth/gorwake.wav", 1, ATTN_NONE);

Add this to client.qc's void() ClientObituary = function, after the line "if (attacker.flags & FL_MONSTER)":

				if (attacker.classname == "monster_goroth")
					bprint (" was dominated by Goroth\n");

"goroth.qc" should be placed after all of the base qc files in your "progs.src", just to be safe.

And add this line to your FGD file to see him properly in Trenchbroom:

@PointClass base(Monster) size(-96 -96 -24, 96 96 288) model({ "path": ":progs/goroth.mdl" }) = monster_goroth : "Goroth" []

// USEAGE RECOMMENDATIONS ==============================================================
Goroth comes with 6000HP, with the recommendation / encouragement that you design some sort of 
environmental method of defeating him. That said, you may want to lower his HP to a more appropriate 
amount or design your map around Goroth being a bullet sponge.

Goroth's map collision handling may be weird. AFAIK Quake handles map collision using 2 different hull sizes,
both of which are far smaller than Goroth, so he *may* be able to fit in spaces he really shouldn't be able to.
Design your maps around that caveat of huge monsters accordingly.

// CHANGELOG ===========================================================================
v1.0
First release

v1.1
-gor_gib() now properly covers the appropriate area of Goroth's current death frame
-Added lava splash to Goroth's death animation
-Goroth lava rocks now spawn on the ground properly
-Fixed wake voiceline not completing
-Fixed taunt voicelines not completing
-Added readme

v1.2
-Added new attack - Goroth can now throw extra spicy meatballs, similar to Cthon
-Added some lava particle effects to his attacks
-Updated sound calls - Goroth's voice now has a reach befitting an Elder God
-Fixed "gor_wake" function; please read the instructions if you want him to play his SightSound properly!

Probably the final update to him. Just felt the need to enhance Goroth with the stuff I learned
working on Volkerh. Enjoy!  (:
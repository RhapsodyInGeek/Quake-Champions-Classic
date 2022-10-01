// QUAKE CHAMPIONS CLASSIC v0.1.0 =========================================================
PURE SPEED. PURE SKILL. PURE FPS. Quake Champions Classic seeks to mix the champion gameplay
and balance from Quake Champions with the retro aesthetics and community expandability of both
the multiplayer and singleplayer of the original Quake.

To that end, the weapons have all been rebalanced to the current live build of Quake Champions,
including both damage and ammo count. Champions themselves will be translated as closely as possible.
Rotten health kits have been replaced with Hourglasses that cool down your ability timers.
Killing monsters will also do this.

NEW BINDS:
impulse 22: use ability
impulse 100: change champion

As of the current version these Champions are available to play as:
*Ranger------------------------------
-Active Ability: Dire Orb
-Passive Ability: Halved Self Damage
-------------------------------------
*Death Knight------------------------
-Active Ability: Flame Strike
-Passive Ability: Sword catches enemies on fire; Immunity to lava
-------------------------------------

// CONTENTS ==============================================================================
*All QC source files for both Rerelease (progsrr.src) and pre-rerelease (progs96.src) builds.
*Champions and Elder God Blend files.
*compiled mods for both the Rerelease (qccrr.zip) and Other engines (qcc96.zip). NOTE: qcc96 only tested in Quakespasm.
*QCC.fgd, for use with Trenchbroom.

// SETUP =================================================================================
For the Rerelease, extract the mod folder inside the "../Steam/steamapps/common/Quake/rerelease/" folder.
To play on Multiplayer, make sure to re-enter the console command "game qcc" after entering the Multiplayer Menu.

// NOTES =================================================================================
This has largely been a study and exercise for me in game design while I take small breaks from
my actual semi-professional game project. As such, updates on this can take awhile. I do intend to
"finish it" however, and plan on adding to it as time goes by.

That said, I welcome any contributions any interested community members may wish to make. Included in qccdefs.qc are
a basic set of instructions on how to add a new Champion. The Ranger collection in the Champions.blend file can be
used as a pseudo-template for new Champions. I tried to make it as flexible and easy as possible so that modders
need only modify qccdefs.qc and qccchamps.qc, while adding their own Champion qc file.

For a full list of changes made to the game, see the bottom of qccdefs.qc.

One last thing: there's a "bug" with spawning in that your armor resets in Single Player on map start. I forgot
to add in a check for "deathmatch". I'll be doing that on next version, whenever that is.

Anyway, I hope you enjoy this little hobby project of mine! Let me know in the Slipseer Discussion if you'd like to contribute
or even just what you think of it! <3

// CHANGELOG =============================================================================
v0.1.0
-First release


SECTION "WRAM Bank 0", WRAM0


SECTION "Sprite State Data", WRAM0[$c100]

wSpriteStateData1: ; c100
; data for all sprites on the current map
; holds info for 16 sprites with $10 bytes each
; player sprite is always sprite 0
; C1x0: picture ID (fixed, loaded at map init)
; C1x1: movement status (0: uninitialized, 1: ready, 2: delayed, 3: moving)
; C1x2: sprite image index (changed on update, $ff if off screen, includes facing direction, progress in walking animation and a sprite-specific offset)
; C1x3: Y screen position delta (-1,0 or 1; added to c1x4 on each walking animation update)
; C1x4: Y screen position (in pixels, always 4 pixels above grid which makes sprites appear to be in the center of a tile)
; C1x5: X screen position delta (-1,0 or 1; added to c1x6 on each walking animation update)
; C1x6: X screen position (in pixels, snaps to grid if not currently walking)
; C1x7: intra-animation-frame counter (counting upwards to 4 until c1x8 is incremented)
; C1x8: animation frame counter (increased every 4 updates, hold four states (totalling to 16 walking frames)
; C1x9: facing direction (0: down, 4: up, 8: left, $c: right)
; C1xA
; C1xB
; C1xC
; C1xD
; C1xE
; C1xF
	ds $10 * $10

wSpriteStateData2: ; c200
; more data for all sprites on the current map
; holds info for 16 sprites with $10 bytes each
; player sprite is always sprite 0
; C2x0: walk animation counter (counting from $10 backwards when moving)
; C2x1: 
; C2x2: Y displacement (initialized at 8, supposed to keep moving sprites from moving too far, but bugged)
; C2x3: X displacement (initialized at 8, supposed to keep moving sprites from moving too far, but bugged)
; C2x4: Y position (in 2x2 tile grid steps, topmost 2x2 tile has value 4)
; C2x5: X position (in 2x2 tile grid steps, leftmost 2x2 tile has value 4)
; C2x6: movement byte 1 (determines whether a sprite can move, $ff:not moving, $fe:random movements, others unknown)
; C2x7: (?) (set to $80 when in grass, else $0; may be used to draw grass above the sprite)
; C2x8: delay until next movement (counted downwards, status (c1x1) is set to ready if reached 0)
; C2x9
; C2xA
; C2xB
; C2xC
; C2xD
; C2xE: sprite image base offset (in video ram, player always has value 1, used to compute c1x2)
; C2xF
	ds $10 * $10


wOAMBuffer: ; c300
; buffer for OAM data. Copied to OAM by DMA
	ds 4 * 40


SECTION "Tile Map", WRAM0[$c3a0]

wTileMap: ; c3a0
; buffer for tiles that are visible on screen (20 columns by 18 rows)
	ds 20 * 18

wTileMapBackup: ; c508
; buffer for temporarily saving and restoring current screen's tiles
; (e.g. if menus are drawn on top)
	ds 20 * 18

; c670


SECTION "Screen Edge Tiles", WRAM0[$cbfc]

wScreenEdgeTiles: ; cbfc
; the tiles of the row or column to be redrawn by RedrawExposedScreenEdge
	ds 20 * 2

; coordinates of the position of the cursor for the top menu item (id 0)
wTopMenuItemY: ; cc24
	ds 1
wTopMenuItemX: ; cc25
	ds 1

wCurrentMenuItem: ; cc26
; the id of the currently selected menu item
; the top item has id 0, the one below that has id 1, etc.
; note that the "top item" means the top item currently visible on the screen
; add this value to [wListScrollOffset] to get the item's position within the list
	ds 1

wTileBehindCursor: ; cc27
; the tile that was behind the menu cursor's current location
	ds 1

wMaxMenuItem: ; cc28
; id of the bottom menu item
	ds 1

wMenuWatchedKeys: ; cc29
; bit mask of keys that the menu will respond to
	ds 1

wLastMenuItem: ; cc2a
; id of previously selected menu item
	ds 1

; cc2b

	ds 3

wPlayerMoveListIndex: ; cc2e
	ds 1

wPlayerMonNumber: ; cc2f
	ds 1

wMenuCursorLocation: ; cc30
; the address of the menu cursor's current location within wTileMap
	ds 2

	ds 2

wMenuJoypadPollCount: ; cc34
; how many times should HandleMenuInput poll the joypad state before it returns?
	ds 1

	ds 1

wListScrollOffset: ; cc36
; offset of the current top menu item from the beginning of the list
; keeps track of what section of the list is on screen
	ds 1

	ds 19

wMenuWrappingEnabled: ; cc4a
; set to 1 if you can go from the bottom to the top or top to bottom of a menu
; set to 0 if you can't go past the top or bottom of the menu
	ds 1

	ds 10

wTrainerHeaderFlagBit: ; cc55
	ds 1

; cc56


SECTION "RLE", WRAM0[$ccd2]
wRLEByteCount: ; ccd2
	ds 1

	ds 4

; current HP of player and enemy substitutes
wPlayerSubstituteHP: ; ccd7
	ds 1
wEnemySubstituteHP: ; ccd8
	ds 1

	ds 2

wMoveMenuType: ; ccdb
; 0=regular, 1=mimic, 2=above message box (relearn, heal pp..)
	ds 1

wPlayerSelectedMove: ; ccdc
	ds 1
wEnemySelectedMove: ; ccdd
	ds 1

	ds 1

wAICount: ; ccdf
; number of times remaining that AI action can occur
	ds 1

	ds 2

wEnemyMoveListIndex: ; cce2
	ds 1

; cce3


SECTION "Stat Modifiers", WRAM0[$cd1a]

; stat modifiers for the player's current pokemon
; value can range from 1 - 13 ($1 to $D)
; 7 is normal

wPlayerMonStatMods:
wPlayerMonAttackMod: ; cd1a
	ds 1
wPlayerMonDefenseMod: ; cd1b
	ds 1
wPlayerMonSpeedMod: ; cd1c
	ds 1
wPlayerMonSpecialMod: ; cd1d
	ds 1
wPlayerMonAccuracyMod: ; cd1e
	ds 1
wPlayerMonEvasionMod: ; cd1f
	ds 1

	ds 13

wEngagedTrainerClass: ; cd2d
	ds 1
wEngagedTrainerSet: ; cd2e
;	ds 1

; stat modifiers for the enemy's current pokemon
; value can range from 1 - 13 ($1 to $D)
; 7 is normal

wEnemyMonStatMods:
wEnemyMonAttackMod: ; cd2e
	ds 1
wEnemyMonDefenseMod: ; cd2f
	ds 1
wEnemyMonSpeedMod: ; cd30
	ds 1
wEnemyMonSpecialMod: ; cd31
	ds 1
wEnemyMonAccuracyMod: ; cd32
	ds 1
wEnemyMonEvasionMod: ; cd33
	ds 1

	ds 9

wWhichTrade: ; cd3d
; which entry from TradeMons to select
;	ds 1

wTrainerSpriteOffset: ; cd3d
	ds 1
wTrainerEngageDistance: ; cd3e
	ds 1
wTrainerFacingDirection: ; cd3f
	ds 1
wTrainerScreenY: ; cd40
	ds 1
wTrainerScreenX: ; cd41
	ds 1

	ds 30

wFlags_0xcd60: ; cd60
; bit 0: is player engaged by trainer (to avoid being engaged by multiple trainers simultaniously)
	ds 1

	ds 10

wJoypadForbiddenButtonsMask: ; cd6b
; bit 1 means button presses will be ignored for that button
	ds 1

	ds 21

wTileMapBackup2: ; cd81
; second buffer for temporarily saving and restoring current screen's tiles (e.g. if menus are drawn on top)
	ds 20 * 18

wBuffer: ; cee9
; used for temporary things

wHPBarMaxHP: ; cee9
	ds 2
wHPBarOldHP: ; ceeb
	ds 2
wHPBarNewHP: ; ceed
	ds 2
wHPBarDelta: ; ceef
	ds 1

	ds 13

wHPBarHPDifference: ; cefd
	ds 1

	ds 9

wAnimSoundID: ; cf07
; sound ID during battle animations
	ds 1

	ds 12

wCurSpriteMovement2: ; cf14
; movement byte 2 of current sprite
	ds 1

	ds 74

wGymCityName: ; cf5f
wStringBuffer1: ; cf5f
	ds 16 + 1
wGymLeaderName: ; cf70
wStringBuffer2: ; cf70
	ds 16 + 1
wStringBuffer3: ; cf81
	ds 16 + 1

wWhichPokemon: ; cf92
; which pokemon you selected
	ds 1

	ds 1

wListMenuID: ; cf94
; ID used by DisplayListMenuID
	ds 1

	ds 48

wWalkCounter: ; cfc5
; walk animation counter
	ds 1

	ds 1

wMusicChannelPointer: ; cfc7
; (the current music channel address - $4000) / 3
	ds 1

	ds 4

W_ENEMYMOVENUM: ; cfcc
	ds 1
W_ENEMYMOVEEFFECT: ; cfcd
	ds 1
W_ENEMYMOVEPOWER: ; cfce
	ds 1
W_ENEMYMOVETYPE: ; cfcf
	ds 1
W_ENEMYMOVEACCURACY: ; cfd0
	ds 1
W_ENEMYMOVEMAXPP: ; cfd1
	ds 1
W_PLAYERMOVENUM: ; cfd2
	ds 1
W_PLAYERMOVEEFFECT: ; cfd3
	ds 1
W_PLAYERMOVEPOWER: ; cfd4
	ds 1
W_PLAYERMOVETYPE: ; cfd5
	ds 1
W_PLAYERMOVEACCURACY: ; cfd6
	ds 1
W_PLAYERMOVEMAXPP: ; cfd7
	ds 1

W_ENEMYMONID: ; cfd8
	ds 1

	ds 1

W_ENEMYMONNAME: ; cfda
	ds 11

	ds 1

W_ENEMYMONCURHP: ; cfe6
; active opponent's hp (16 bits)
	ds 2
W_ENEMYMONNUMBER: ; cfe8
; active opponent's position in team (0 to 5)
	ds 1
W_ENEMYMONSTATUS: ; cfe9
; active opponent's status condition
	ds 1
W_ENEMYMONTYPES: ; cfea
W_ENEMYMONTYPE1: ; cfea
	ds 1
W_ENEMYMONTYPE2: ; cfeb
	ds 1
	ds 1
W_ENEMYMONMOVES: ; cfed
	ds 4
W_ENEMYMONATKDEFIV: ; cff1
	ds 1
W_ENEMYMONSPDSPCIV: ; cff2
	ds 1
W_ENEMYMONLEVEL: ; cff3
	ds 1
W_ENEMYMONMAXHP: ; cff4
	ds 2
W_ENEMYMONATTACK: ; cff6
	ds 2
W_ENEMYMONDEFENSE: ; cff8
	ds 2
W_ENEMYMONSPEED: ; cffa
	ds 2
W_ENEMYMONSPECIAL: ; cffc
	ds 2

W_ENEMYMONPP: ; cffe
; four moves (extends past $cfff)
	ds 2


SECTION "WRAM Bank 1", WRAMX, BANK[1]

	ds 2 ; W_ENEMYMONPP

	ds 7

W_PLAYERMONNAME: ; d009
	ds 11

W_PLAYERMONID: ; d014
	ds 1

W_PLAYERMONCURHP: ; d015
	ds 2
	ds 1
W_PLAYERMONSTATUS: ; d018
; the status of the player’s current monster
	ds 1
W_PLAYERMONTYPES: ; d019
W_PLAYERMONTYPE1: ; d019
	ds 1
W_PLAYERMONTYPE2: ; d01a
	ds 1
	ds 1
W_PLAYERMONMOVES: ; d01c
	ds 4
W_PLAYERMONIVS: ; d020
; 4x 4 bit: atk, def, spd, spc
	ds 2
W_PLAYERMONLEVEL: ; d022
	ds 1
W_PLAYERMONMAXHP: ; d023
	ds 2
W_PLAYERMONATK: ; d025
	ds 2
W_PLAYERMONDEF: ; d027
	ds 2
W_PLAYERMONSPEED: ; d029
	ds 2
W_PLAYERMONSPECIAL: ; d02b
	ds 2
W_PLAYERMONPP: ; d02d
	ds 4



W_TRAINERCLASS: ; d031
	ds 1

	ds 37

W_ISINBATTLE: ; d057
; no battle, this is 0
; wild battle, this is 1
; trainer battle, this is 2
	ds 1

W_PLAYERMONSALIVEFLAGS: ; d058
; 6 bit array, 1 if player mon is alive
	ds 1

W_CUROPPONENT: ; d059
; in a wild battle, this is the species of pokemon
; in a trainer battle, this is the trainer class + $C8
	ds 1

W_BATTLETYPE: ; d05a
; in normal battle, this is 0
; in old man battle, this is 1
; in safari battle, this is 2
	ds 1

	ds 1

W_LONEATTACKNO: ; d05c
; which entry in LoneAttacks to use
W_GYMLEADERNO: ; d05c
; it's actually the same thing as ^
	ds 1
W_TRAINERNO: ; d05d
; which instance of [youngster, lass, etc] is this?
	ds 1

	ds 1

W_MOVEMISSED: ; d05f
	ds 1

	ds 2

W_PLAYERBATTSTATUS1: ; d062
; bit 0 - bide
; bit 1 - thrash / petal dance
; bit 2 - attacking multiple times (e.g. double kick)
; bit 3 - flinch
; bit 4 - charging up for attack
; bit 5 - using multi-turn move (e.g. wrap)
; bit 6 - invulnerable to normal attack (using fly/dig)
; bit 7 - confusion
	ds 1

W_PLAYERBATTSTATUS2: ; d063
; bit 0 - X Accuracy effect
; bit 1 - protected by "mist"
; bit 2 - focus energy effect
; bit 4 - has a substitute
; bit 5 - need to recharge
; bit 6 - rage
; bit 7 - leech seeded
	ds 1

W_PLAYERBATTSTATUS3: ; d064
; bit 0 - toxic
; bit 1 - light screen
; bit 2 - reflect
; bit 3 - tranformed
	ds 1

	ds 2

W_ENEMYBATTSTATUS1: ; d067
	ds 1
W_ENEMYBATTSTATUS2: ; d068
	ds 1
W_ENEMYBATTSTATUS3: ; d069
	ds 1

	ds 2

W_PLAYERTOXICCOUNTER: ; d06c
	ds 1
W_PLAYERDISABLEDMOVE: ; d06d
	ds 1

	ds 3

W_ENEMYTOXICCOUNTER: ; d071
	ds 1
W_ENEMYDISABLEDMOVE: ; d072
	ds 1

	ds 1

W_NUMHITS: ; d074
; number of hits in attacks like Doubleslap, etc.
	ds 1

	ds 7

W_ANIMATIONID: ; d07c
; ID number of the current battle animation
	ds 1

	ds 4

; base coordinates of frame block
W_BASECOORDX: ; d081
	ds 1
W_BASECOORDY: ; d082
	ds 1

	ds 1

W_FBTILECOUNTER: ; d084
; counts how many tiles of the current frame block have been drawn
	ds 1

	ds 1

W_SUBANIMFRAMEDELAY: ; d086
; duration of each frame of the current subanimation in terms of screen refreshes
	ds 1
W_SUBANIMCOUNTER: ; d087
; counts the number of subentries left in the current subanimation
	ds 1

	ds 1

W_NUMFBTILES: ; d089
; number of tiles in current battle animation frame block
	ds 1

	ds 1

W_SUBANIMTRANSFORM: ; d08b
; controls what transformations are applied to the subanimation
; 01: flip horizontally and vertically
; 02: flip horizontally and translate downwards 40 pixels
; 03: translate base coordinates of frame blocks, but don't change their internal coordinates or flip their tiles
; 04: reverse the subanimation
	ds 1

W_PBSTOREDREGISTERH: ; d08c
	ds 1
W_PBSTOREDREGISTERL: ; d08d
	ds 1
W_PBSTOREDREGISTERD: ; d08e
	ds 1
W_PBSTOREDREGISTERE: ; d08f
	ds 1

	ds 2

W_PBSTOREDROMBANK: ; d092
	ds 1

	ds 1

W_SUBANIMADDRPTR: ; d094
; the address _of the address_ of the current subanimation entry
	ds 2
W_SUBANIMSUBENTRYADDR: ; d096
; the address of the current subentry of the current subanimation
	ds 2

	ds 4

W_FBDESTADDR: ; d09c
; current destination address in OAM for frame blocks (big endian)
	ds 2

W_FBMODE: ; d09e
; controls how the frame blocks are put together to form frames
; specifically, after finishing drawing the frame block, the frame block's mode determines what happens
; 00: clean OAM buffer and delay
; 02: move onto the next frame block with no delay and no cleaning OAM buffer
; 03: delay, but don't clean OAM buffer
; 04: delay, without cleaning OAM buffer, and do not advance [W_FBDESTADDR], so that the next frame block will overwrite this one
; sprite data is written column by column, each byte contains 8 columns (one for ech bit)
; for 2bpp sprites, pairs of two consecutive bytes (i.e. pairs of consecutive rows of sprite data)
; contain the upper and lower bit of each of the 8 pixels, respectively
	ds 1


SECTION "Sprite Buffers", SRAM

SPRITEBUFFERSIZE EQU 7*7 * 8 ; 7 * 7 (tiles) * 8 (bytes per tile)

S_SPRITEBUFFER0: ; a000
	ds SPRITEBUFFERSIZE
S_SPRITEBUFFER1: ; a188
	ds SPRITEBUFFERSIZE
S_SPRITEBUFFER2: ; a310
	ds SPRITEBUFFERSIZE


SECTION "Sprites", WRAMX[$d0a1], BANK[1]

W_SPRITECURPOSX: ; d0a1
	ds 1
W_SPRITECURPOSY: ; d0a2
	ds 1
W_SPRITEWITDH: ; d0a3
	ds 1
W_SPRITEHEIGHT: ; d0a4
	ds 1
W_SPRITEINPUTCURBYTE: ; d0a5
; current input byte
	ds 1
W_SPRITEINPUTBITCOUNTER: ; d0a6
; bit offset of last read input bit
	ds 1

W_SPRITEOUTPUTBITOFFSET: ; d0a7; determines where in the output byte the two bits are placed. Each byte contains four columns (2bpp data)
; 3 -> XX000000   1st column
; 2 -> 00XX0000   2nd column
; 1 -> 0000XX00   3rd column
; 0 -> 000000XX   4th column
	ds 1

W_SPRITELOADFLAGS: ; d0a8
; bit 0 determines used buffer (0 -> $a188, 1 -> $a310)
; bit 1 loading last sprite chunk? (there are at most 2 chunks per load operation)
	ds 1
W_SPRITEUNPACKMODE: ; d0a9
	ds 1
W_SPRITEFLIPPED: ; d0aa
	ds 1

W_SPRITEINPUTPTR: ; d0ab
; pointer to next input byte
	ds 2
W_SPRITEOUTPUTPTR: ; d0ad
; pointer to current output byte
	ds 2
W_SPRITEOUTPUTPTRCACHED: ; d0af
; used to revert pointer for different bit offsets
	ds 2
W_SPRITEDECODETABLE0PTR: ; d0b1
; pointer to differential decoding table (assuming initial value 0)
	ds 2
W_SPRITEDECODETABLE1PTR: ; d0b3
; pointer to differential decoding table (assuming initial value 1)
	ds 2

	ds 1

W_LISTTYPE: ; d0b6
	ds 1

	ds 1

W_MONHEADER: ; d0b8
W_MONHDEXNUM: ; d0b8
	ds 1

W_MONHBASESTATS: ; d0b9
W_MONHBASEHP: ; d0b9
	ds 1
W_MONHBASEATTACK: ; d0ba
	ds 1
W_MONHBASEDEFENSE: ; d0bb
	ds 1
W_MONHBASESPEED: ; d0bc
	ds 1
W_MONHBASESPECIAL: ; d0bd
	ds 1

W_MONHTYPES: ; d0be
W_MONHTYPE1: ; d0be
	ds 1
W_MONHTYPE2: ; d0bf
	ds 1

W_MONHCATCHRATE: ; d0c0
	ds 1
W_MONHBASEXP: ; d0c1
	ds 1
W_MONHSPRITEDIM: ; d0c2
	ds 1
W_MONHFRONTSPRITE: ; d0c3
	ds 2
W_MONHBACKSPRITE: ; d0c5
	ds 2

W_MONHMOVES: ; d0c7
	ds 4

W_MONHGROWTHRATE: ; d0cb
	ds 1

W_MONHLEARNSET: ; d0cc
; bit field
	ds 7

	ds 4

W_MONHPADDING: ; d0d7


W_DAMAGE: ; d0d7
	ds 1

	ds 79

W_CURENEMYLVL: ; d127
	ds 1

	ds 3

W_ISLINKBATTLE: ; d12b
	ds 1

	ds 17

W_PRIZE1: ; d13d
	ds 1
W_PRIZE2: ; d13e
	ds 1
W_PRIZE3: ; d13f
	ds 1

	ds 24

W_PLAYERNAME: ; d158
	ds 11

W_NUMINPARTY: ; d163
	ds 1
W_PARTYMON1: ; d164
	ds 1
W_PARTYMON2: ; d165
	ds 1
W_PARTYMON3: ; d166
	ds 1
W_PARTYMON4: ; d167
	ds 1
W_PARTYMON5: ; d168
	ds 1
W_PARTYMON6: ; d169
	ds 1
W_PARTYMONEND: ; d16a
	ds 1

W_PARTYMON1DATA: ; d16b
W_PARTYMON1_NUM: ; d16b
	ds 1
W_PARTYMON1_HP: ; d16c
	ds 2
W_PARTYMON1_BOXLEVEL: ; d16e
	ds 1
W_PARTYMON1_STATUS: ; d16f
	ds 1
W_PARTYMON1_TYPE1: ; d170
	ds 1
W_PARTYMON1_TYPE2: ; d171
	ds 1
W_PARTYMON1_CRATE: ; d172
	ds 1
W_PARTYMON1_MOVE1: ; d173
	ds 1
W_PARTYMON1_MOVE2: ; d174
	ds 1
W_PARTYMON1_MOVE3: ; d175
	ds 1
W_PARTYMON1_MOVE4: ; d176
	ds 1
W_PARTYMON1_OTID: ; d177
	ds 2
W_PARTYMON1_EXP: ; d179
	ds 3
W_PARTYMON1_EVHP: ; d17c
	ds 2
W_PARTYMON1_EVATTACK: ; d17e
	ds 2
W_PARTYMON1_EVDEFENSE: ; d180
	ds 2
W_PARTYMON1_EVSPEED: ; d182
	ds 2
W_PARTYMON1_EVSECIAL: ; d184
	ds 2
W_PARTYMON1_IV: ; d186
	ds 2
W_PARTYMON1_MOVE1PP: ; d188
	ds 1
W_PARTYMON1_MOVE2PP: ; d189
	ds 1
W_PARTYMON1_MOVE3PP: ; d18a
	ds 1
W_PARTYMON1_MOVE4PP: ; d18b
	ds 1
W_PARTYMON1_LEVEL: ; d18c
	ds 1
W_PARTYMON1_MAXHP: ; d18d
	ds 2
W_PARTYMON1_ATACK: ; d18f
	ds 2
W_PARTYMON1_DEFENSE: ; d191
	ds 2
W_PARTYMON1_SPEED: ; d193
	ds 2
W_PARTYMON1_SPECIAL: ; d195
	ds 2

W_PARTYMON2DATA: ; d197
	ds 44
W_PARTYMON3DATA: ; d1c3
	ds 44
W_PARTYMON4DATA: ; d1ef
	ds 44
W_PARTYMON5DATA: ; d21b
	ds 44
W_PARTYMON6DATA: ; d247
	ds 44

W_PARTYMON1OT: ; d273
	ds 11
W_PARTYMON2OT: ; d27e
	ds 11
W_PARTYMON3OT: ; d289
	ds 11
W_PARTYMON4OT: ; d294
	ds 11
W_PARTYMON5OT: ; d29f
	ds 11
W_PARTYMON6OT: ; d2aa
	ds 11

W_PARTYMON1NAME: ; d2b5
	ds 11
W_PARTYMON2NAME: ; d2c0
	ds 11
W_PARTYMON3NAME: ; d2cb
	ds 11
W_PARTYMON4NAME: ; d2d6
	ds 11
W_PARTYMON5NAME: ; d2e1
	ds 11
W_PARTYMON6NAME: ; d2ec
	ds 11


SECTION "Pokedex", WRAMX[$d2f7], BANK[1]

wPokedexOwned: ; d2f7
	ds (150 / 8) + 1
wPokedexOwnedEnd:

wPokedexSeen: ; d30a
	ds (150 / 8) + 1
wPokedexSeenEnd:


wNumBagItems: ; d31d
	ds 1
wBagItems: ; d31e
; item, quantity
	ds 20 * 2
	ds 1 ; end

; money is in decimal
wPlayerMoney: ; d347
	ds 3

W_RIVALNAME: ; d34a
	ds 11

W_OPTIONS: ; d355
; bit 7 = battle animation
; 0: On
; 1: Off
; bit 6 = battle style
; 0: Shift
; 1: Set
; bits 0-3 = text speed (number of frames to delay after printing a letter)
; 1: Fast
; 3: Medium
; 5: Slow
	ds 1

W_OBTAINEDBADGES: ; d356
	ds 1

	ds 2

wPlayerID: ; d359
	ds 2

	ds 3

W_CURMAP: ; d35e
	ds 1

	ds 2

W_YCOORD EQU $D361 ; player’s position on the current map
W_XCOORD EQU $D362
W_YBLOCKCOORD EQU $D363 ; player's y position (by block)
W_XBLOCKCOORD EQU $D364

W_CURMAPTILESET EQU $D367
W_CURMAPHEIGHT  EQU $D368 ; blocks
W_CURMAPWIDTH   EQU $D369 ; blocks

W_MAPDATAPTR EQU $D36A
W_MAPTEXTPTR EQU $D36C
W_MAPSCRIPTPTR EQU $D36E
W_MAPCONNECTIONS EQU $D370 ; connection byte
W_MAPCONN1PTR EQU $D371
W_MAPCONN2PTR EQU $D37C
W_MAPCONN3PTR EQU $D387
W_MAPCONN4PTR EQU $D392

W_SPRITESET EQU $D39D ; sprite set for the current map (11 sprite picture ID's)
W_SPRITESETID EQU $D3A8 ; sprite set ID for the current map

W_NUMSPRITES EQU $D4E1 ; number of sprites on the current map

; two bytes per sprite (movement byte 2 , text ID)
W_MAPSPRITEDATA EQU $D4e4

; two bytes per sprite (trainer class/item ID , trainer set ID)
W_MAPSPRITEEXTRADATA EQU $D504

W_TILESETBANK             EQU $D52B
W_TILESETBLOCKSPTR        EQU $D52C ; maps blocks (4x4 tiles) to it's tiles
W_TILESETGFXPTR           EQU $D52E
W_TILESETCOLLISIONPTR     EQU $D530 ; list of all walkable tiles
W_TILESETTALKINGOVERTILES EQU $D532 ; 3 bytes
W_GRASSTILE               EQU $D535


SECTION "Items", WRAMX[$d53a], BANK[1]

wNumBoxItems: ; d53a
	ds 1
wBoxItems: ; d53b
; item, quantity
	ds 50 * 2
	ds 1 ; end

	ds 4

; coins are in decimal
wPlayerCoins: ; d5a4
	ds 2

W_MISSABLEOBJECTFLAGS: ; d5a6
; bit array of missable objects. set = removed
	ds 40

W_MISSABLEOBJECTLIST: ; d5ce
; each entry consists of 2 bytes
; * the sprite ID (depending on the current map)
; * the missable object index (global, used for W_MISSABLEOBJECTFLAGS)
; terminated with $FF
	ds 17 * 2

W_GAMEPROGRESSFLAGS           EQU $D5F0 ; $c8 bytes
W_OAKSLABCURSCRIPT            EQU $D5F0
W_PALLETTOWNCURSCRIPT         EQU $D5F1

W_BLUESHOUSECURSCRIPT         EQU $D5F3
W_VIRIDIANCITYCURSCRIPT       EQU $D5F4

W_PEWTERCITYCURSCRIPT         EQU $D5F7
W_ROUTE3CURSCRIPT             EQU $D5F8
W_ROUTE4CURSCRIPT             EQU $D5F9

W_VIRIDIANGYMCURSCRIPT        EQU $D5FB
W_PEWTERGYMCURSCRIPT          EQU $D5FC
W_CERULEANGYMCURSCRIPT        EQU $D5FD
W_VERMILIONGYMCURSCRIPT       EQU $D5FE
W_CELADONGYMCURSCRIPT         EQU $D5FF
W_ROUTE6CURSCRIPT             EQU $D600
W_ROUTE8CURSCRIPT             EQU $D601
W_ROUTE24CURSCRIPT            EQU $D602
W_ROUTE25CURSCRIPT            EQU $D603
W_ROUTE9CURSCRIPT             EQU $D604
W_ROUTE10CURSCRIPT            EQU $D605
W_MTMOON1CURSCRIPT            EQU $D606
W_MTMOON3CURSCRIPT            EQU $D607
W_SSANNE8CURSCRIPT            EQU $D608
W_SSANNE9CURSCRIPT            EQU $D609
W_ROUTE22CURSCRIPT            EQU $D60A

W_REDSHOUSE2CURSCRIPT         EQU $D60C
W_VIRIDIANMARKETCURSCRIPT     EQU $D60D
W_ROUTE22GATECURSCRIPT        EQU $D60E
W_CERULEANCITYCURSCRIPT       EQU $D60F

W_SSANNE5CURSCRIPT            EQU $D617
W_VIRIDIANFORESTCURSCRIPT     EQU $D618
W_MUSEUMF1CURSCRIPT           EQU $D619
W_ROUTE13CURSCRIPT            EQU $D61A
W_ROUTE14CURSCRIPT            EQU $D61B
W_ROUTE17CURSCRIPT            EQU $D61C
W_ROUTE19CURSCRIPT            EQU $D61D
W_ROUTE21CURSCRIPT            EQU $D61E
W_SAFARIZONEENTRANCECURSCRIPT EQU $D61F
W_ROCKTUNNEL2CURSCRIPT        EQU $D620
W_ROCKTUNNEL1CURSCRIPT        EQU $D621

W_ROUTE11CURSCRIPT            EQU $D623
W_ROUTE12CURSCRIPT            EQU $D624
W_ROUTE15CURSCRIPT            EQU $D625
W_ROUTE16CURSCRIPT            EQU $D626
W_ROUTE18CURSCRIPT            EQU $D627
W_ROUTE20CURSCRIPT            EQU $D628
W_SSANNE10CURSCRIPT           EQU $D629
W_VERMILIONCITYCURSCRIPT      EQU $D62A
W_POKEMONTOWER2CURSCRIPT      EQU $D62B
W_POKEMONTOWER3CURSCRIPT      EQU $D62C
W_POKEMONTOWER4CURSCRIPT      EQU $D62D
W_POKEMONTOWER5CURSCRIPT      EQU $D62E
W_POKEMONTOWER6CURSCRIPT      EQU $D62F
W_POKEMONTOWER7CURSCRIPT      EQU $D630
W_ROCKETHIDEOUT1CURSCRIPT     EQU $D631
W_ROCKETHIDEOUT2CURSCRIPT     EQU $D632
W_ROCKETHIDEOUT3CURSCRIPT     EQU $D633
W_ROCKETHIDEOUT4CURSCRIPT     EQU $D634

W_ROUTE6GATECURSCRIPT         EQU $D636
W_ROUTE8GATECURSCRIPT         EQU $D637

W_CINNABARISLANDCURSCRIPT     EQU $D639
W_MANSION1CURSCRIPT           EQU $D63A

W_MANSION2CURSCRIPT           EQU $D63C
W_MANSION3CURSCRIPT           EQU $D63D
W_MANSION4CURSCRIPT           EQU $D63E
W_VICTORYROAD2CURSCRIPT       EQU $D63F
W_VICTORYROAD3CURSCRIPT       EQU $D640

W_FIGHTINGDOJOCURSCRIPT       EQU $D642
W_SILPHCO2CURSCRIPT           EQU $D643
W_SILPHCO3CURSCRIPT           EQU $D644
W_SILPHCO4CURSCRIPT           EQU $D645
W_SILPHCO5CURSCRIPT           EQU $D646
W_SILPHCO6CURSCRIPT           EQU $D647
W_SILPHCO7CURSCRIPT           EQU $D648
W_SILPHCO8CURSCRIPT           EQU $D649
W_SILPHCO9CURSCRIPT           EQU $D64A
W_HALLOFFAMEROOMCURSCRIPT     EQU $D64B
W_GARYCURSCRIPT               EQU $D64C
W_LORELEICURSCRIPT            EQU $D64D
W_BRUNOCURSCRIPT              EQU $D64E
W_AGATHACURSCRIPT             EQU $D64F
W_UNKNOWNDUNGEON3CURSCRIPT    EQU $D650
W_VICTORYROAD1CURSCRIPT       EQU $D651

W_LANCECURSCRIPT              EQU $D653

W_SILPHCO10CURSCRIPT          EQU $D658
W_SILPHCO11CURSCRIPT          EQU $D659

W_FUCHSIAGYMCURSCRIPT         EQU $D65B
W_SAFFRONGYMCURSCRIPT         EQU $D65C

W_CINNABARGYMCURSCRIPT        EQU $D65E
W_CELADONGAMECORNERCURSCRIPT  EQU $D65F
W_ROUTE16GATECURSCRIPT        EQU $D660
W_BILLSHOUSECURSCRIPT         EQU $D661
W_ROUTE5GATECURSCRIPT         EQU $D662
W_POWERPLANTCURSCRIPT         EQU $D663 ; overload
W_ROUTE7GATECURSCRIPT         EQU $D663 ; overload

W_SSANNE2CURSCRIPT            EQU $D665
W_SEAFOAMISLANDS4CURSCRIPT    EQU $D666
W_ROUTE23CURSCRIPT            EQU $D667
W_SEAFOAMISLANDS5CURSCRIPT    EQU $D668
W_ROUTE18GATECURSCRIPT        EQU $D669

W_TOWNVISITEDFLAG EQU $D70B ; 2 bytes bit array, 1 means visited

W_SAFARITIMER1 EQU $D70D ; use 01 for maximum
W_SAFARITIMER2 EQU $D70E ; use F4 for maximum
W_FOSSILITEM   EQU $D70F ; item given to cinnabar lab
W_FOSSILMON    EQU $D710 ; mon that will result from the item

W_ENEMYMONORTRAINERCLASS EQU $D713 ; trainer classes start at $c8

W_RIVALSTARTER EQU $D715

W_PLAYERSTARTER EQU $D717

; bit 4: use variable [W_CURMAPSCRIPT] instead of the provided index for next frame's map script (used to start battle when talking to trainers)
W_FLAGS_D733 EQU $D733


W_GRASSRATE EQU $D887
W_GRASSMONS EQU $D888
W_WATERRATE EQU $D8A4 ; OVERLOADED
W_WATERMONS EQU $D8A5 ; OVERLOADED

W_ENEMYMONCOUNT  EQU $D89C

W_ENEMYMON1HP EQU $D8A5 ; 16 bits

W_ENEMYMON1MOVE3 EQU $D8AE

W_ENEMYMON2MOVE3 EQU $D8DA

W_ENEMYMON3MOVE3 EQU $D906

W_ENEMYMON4MOVE3 EQU $D932

W_ENEMYMON5MOVE3 EQU $D95E

W_ENEMYMON6MOVE3 EQU $D98A

W_ENEMYMON1OT    EQU $D9AC
W_ENEMYMON2OT    EQU $D9B7
W_ENEMYMON3OT    EQU $D9C2
W_ENEMYMON4OT    EQU $D9CD
W_ENEMYMON5OT    EQU $D9D8
W_ENEMYMON6OT    EQU $D9E3

W_ENEMYMON1NAME     EQU $D9EE
W_ENEMYMON2NAME     EQU $D9F9
W_ENEMYMON3NAME     EQU $DA04
W_ENEMYMON4NAME     EQU $DA0F
W_ENEMYMON5NAME     EQU $DA1A
W_ENEMYMON6NAME     EQU $DA25 ; to $da2f
W_TRAINERHEADERPTR  EQU $DA30

; index of current map script, mostly used as index for function pointer array
; mostly copied from map-specific map script pointer and wirtten back later
W_CURMAPSCRIPT      EQU $DA39

W_PLAYTIMEHOURS     EQU $DA40 ; two bytes
W_PLAYTIMEMINUTES   EQU $DA42 ; two bytes
W_PLAYTIMESECONDS   EQU $DA44 ; one byte
W_PLAYTIMEFRAMES    EQU $DA45 ; one byte

W_NUMSAFARIBALLS EQU $DA47

; number of mons in current box
W_NUMINBOX    EQU $DA80
W_BOXMON1DATA EQU $DA96
W_BOXMON2DATA EQU $DAB7


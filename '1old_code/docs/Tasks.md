**Northern Advance**
	  
		-Top down 2d vertical scrolling air combat game. 
		-Designed for PC invoroment.
		-12 and up age group
		

*Overall Goal*
	
	- To have a fun, engaginhg, solid built, game with all aspects of the developed game being made by Hawklabs and its entities, coded in Godot.
	-air combat game with constat attck . dodge incoming. return fire - get to boss kill boss win.
	-10 mins of play time is goal. Nothiing more. so 3 lvls , 3 mins each. last lvl boss fight.
		
**Backstory**

	Commander Hawk is fighting his way back north to him homalnd that has been invaded by a unknow force.
	
***The 3 C's for Fist game Dev***

    Character: A simple, recognizable avatar (like a 2D sprite or basic cube).
    Controls: Tight, responsive input (keyboard, mouse, or touch).
    Camera: A fixed or simple camera perspective that allows players to clearly see the action. 


**In this /docs foloder**
      -Tasks.md - overview of whats needed to be done\
    Perfect — then we’ll **lock this in as final** and treat it as *live production documentation*.

What you now have is **officially Task.md v2**, and the **MVP / P0 checklist is active**. Below is the **exact checklist section**, cleanly separated so you can **pin it to the top of the file** or copy it into its own `/docs/MVP_Checklist.md` if you want later.

Nothing new is being introduced here — this is just making execution friction-free.

---

# ✅ **Northern Advance — P0 MVP Checklist (ACTIVE)**

> **Rule:** P0 is not complete until *every box below is checked*.

---

## Boot & Navigation

* [ ] Game boots without error
* [ ] Title screen displays correctly
* [ ] “Press Start” advances to Main Menu
* [ ] Main Menu → Level 1 transition works every time

---

## Player Control & Feel

* [ ] Player movement is immediate and responsive
* [ ] No noticeable input lag
* [ ] Player stays within screen bounds
* [ ] Movement feels good for 60+ seconds of play

---

## Combat Core Loop

* [ ] Player can shoot consistently (2 bullets/sec)
* [ ] Bullets spawn, move, and despawn correctly
* [ ] Enemy bullets spawn and move correctly
* [ ] Bullet collisions apply **1 HP damage**
* [ ] Player takes damage from bullets and collisions
* [ ] Death is always understandable (no “cheap” hits)

---

## Enemies & Spawning

* [ ] Enemies spawn on schedule
* [ ] Gunner enemies fire fixed patterns correctly
* [ ] Diver enemies perform swoop movement correctly
* [ ] Enemies can be destroyed reliably
* [ ] Enemy death triggers FX and cleanup
* [ ] No enemies spawn directly on the player

---

## Health & UI

* [ ] Player HP bar updates correctly
* [ ] Enemy HP behaves correctly (if visible)
* [ ] HP never desyncs from actual damage
* [ ] UI never overlaps gameplay improperly

---

## Level Completion & Failure

* [ ] Level ends when all enemies are defeated
* [ ] Level Complete screen displays
* [ ] Player death triggers Game Over screen
* [ ] Restart option works instantly
* [ ] Quit option returns to menu correctly

---

## Audio Hooks (Functional, Not Final)

* [ ] Player shooting SFX triggers
* [ ] Enemy shooting SFX triggers
* [ ] Hit / explosion SFX triggers
* [ ] Player death SFX triggers
* [ ] Music plays during level (placeholder OK)

---

## Stability & Quality Gate

* [ ] No crashes
* [ ] No soft-locks
* [ ] No unkillable enemies
* [ ] No stuck bullets or actors
* [ ] **10 consecutive full playthroughs without failure**

---

## ✅ **P0 SIGN-OFF RULE**

Only when **every item above is checked** do we:

* Move to P1
* Increase difficulty
* Add content
* Touch boss logic

Until then: **fix, tune, stabilize**.

---

## What Happens Now (Execution Mode)

From this point forward:

* This checklist is your **daily work guide**
* Codex implements against it
* You test against it
* I help debug, refactor, or tune *only if something blocks a checkbox*

No new features.
No redesigns.
No scope expansion.

You’re officially in **build-and-verify mode**.

If you want, next we can:

* Turn this into a **printable one-pager**
* Or do a **first-play tuning pass checklist** once you have a rough build

Just say the word — otherwise, go build.

     Thanks to everyone for their time and help! 

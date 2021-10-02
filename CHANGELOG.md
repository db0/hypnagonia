# Dreams: Changelog

## v0.12.0 (Ongoing)

* Added framework for Elites
* Enabled Foreboding Pathos which is what Elites use
* Added artifacts in the shop. They are purchased with Foreboding.
* Every run will give the player some random initial released Pathos, in case of an early shop.

## v0.11.0

* Added framework for adding curios and using curios
* Added ~30 new curios
* Activated the desire pathos. Now only 2/7 are still inactive
* Added the desire encounter which has a chance to occur as your repressed desire increases. It always gives an artifact of The higher the desire when triggered, the higher the rarity chances of the curio. 
  curios gained from this encounter always add a perturbation in the deck
* Added ~10 new perturbations
* curios can now be limited to specific Archetypes, which allows us to have a small core of common curios and allow to expand the curio pool infinitelly without diluting the chance for good combos
* Specific perturbations can now receive greater chance of appearance based on the chosen archetype


## v0.10.0

* Added Pathos Repression and Release
	
	Pathos accumulation consists of 7 different types. Each of which represents a chance to encounter a different thing. For example, The more your frustration rises, the more likely it is to encounter a Torment. On the other hand, your dreamer's loneliness might cause a shop to appear. Accumulated pathos is called "repressed".
	
	Each time you take a journal choice, the relevant type of pathos is "released". Released pathos can be used in the shop. Each type, allows the player to buy different things.
	
	Currently only 4/7 Pathos are active. The Non-Combat Encounters, Elite Enemies and the curios are disabled as these don't exist in the game yet.
* Added Shop (currency is released pathos)
* Reworked the way encounters work
* Added fade-to-black on journal (to hide battle loading time)

## v0.9.2

* Added upgrades for all understanding cards
* Added new tag Intuition. Cards tagged with it will be placed in the starting hand
* Added new tag Enigma. Cards tagged with it will be placed at the bottom of the deck at the start of the encounter.

## v0.9.1

* Added upgrades for all core cards
* Left-Clicking on a card in the Card Library will display all its potential upgrades

## v0.9.0

* Added card upgrades
   * Allows setting up card upgrades with minimum extra card and script definitions
   * Can specify card amounts in the card properties. They will be bbcode coloured
   * Card upgrades are selected in journal after each encounter
   * Cards are slowly upgraded as they're played. Progress is currently only shown in info popups
   * Each card can have multiple upgrades
   * Non-upgraded cards don't have glowing rarity. Upgraded cards have glowing rarity
   * Only a limited number of times can be progressed per encounter. The amount is equal to the deck size.
   * Added way to provide upgraded effects, without setting new scenes and terms.
* Added upgrades for starting cards and some more. Progress ongoing...
* Added more Torments and tweaked intents (@DioBal)
* Added two new effects: Retaliation and Resentment
* Added new Ego Archetype: Mad Scientist (Design by @DioBal)
* Can now setup enemies in encounters using starting effects or preselected intents

## v0.8.1

* Improved performance when loading the Card Library in Grid mode
* Improved performance when opening focus cards.

## v0.8.0

* Changed Card layout to the one provided by [Lorenzo Andreozzi](https://tornioduva.itch.io/). Further tweaked the card image using shaders.
* Added Card Library


## v0.7.0

* Switched to Rich Text on almost all labels. Replaced text representation of tags and effects with icons. Added colour in text.
* Changed Font to Butler
* Fixed focus staying open sometimes
* Added eyeglow to the laughing ones - insomniacUNDERSCORElemon
* Improved Boss character art quality - insomniacUNDERSCORElemon

## v0.6.2

* Antialiased everything
* Added 2 new enemies: Clown, and The Critic
* Added 2 new encounters
* Cannot play 0 cost cards on opponent turns anymore
* Improved background quality
* Added outline on intent icons to make them clearer in light backgrounds
* Highlight on enemies during targetting will not now highlight things other than the target 
* Improved Boss character art - insomniacUNDERSCORElemon

## v0.6.1

* Fixed enemies dying from doubt sometimes preventing game from finishing
* Fixed somethimes Understanding card preview getting stuck in journal

## v0.6.0

* Added framework for non-combat events
* Added first non-combat event: Deep Sleep
* Added top-bar with player status and current decklist
* Reduced the game size to 20MB (from 100) by using lossy compression on the backgrounds
* Fixed last enemy dying from doubt breaking the combat-end

## v0.5.5

* Some disturbing art
* Fixed expiry on confusion
* Added the first archetype icon in the new game menu

## v0.5.4

* Made card/hand layout control-based
* Deck/Discard/Forgotten piles are smaller
* Added way to see the deck contents

## v0.5.3

* Added polygon-art for the fearmonger - insomniacUNDERSCORElemon

## v0.5.2

* Improved Shaders
* Improved Highlights
* Added better default Godot sprite
* Added overcoming animation to The Laughing One (Credit to insomniacUNDERSCORElemon)

## v0.5.1

* Fixed journal not refilling after 5th encounter
* Fixed loss not triggerring
* Change shuffle type as the overhand seems to cause some glitches
* Scripted Understanding cards

## v0.5.0

* Added a journal for progressing between encounters.

## v0.4.0
 
* Added fresh card layout. Unfortunately its assets are under a properietary license.
* Converted tags into icons on card front to improve readability
* Increased overall card size by 25%

## v0.3.0

* Added randomized backgrounds
* Added art credits on Torment mouseover

## v0.2.4

* Added polygon-art for the laughing one (Credit to https://www.reddit.com/user/insomniac_lemon)
* Fixed card draw not reshuffling the deck

## v0.2.3

* Fixed post-battle menu not appearing
* Fixed reseting game after game over

## v0.2.1

* Fixed unnamed_card_3
* Scaled up all text and icons on the board ~50%
* Stopped the laughing one from Laughing so much
* Absurdity Unleashed works when having extra stacks
* Absurdity Unleashed work when applying the stack after the first.
* Fixed Doubt decreasing twice per turn instead of once
* Added Game Over Screen

## v0.2

* Added icons
* Added image for first boss

## v0.1

Initial release. Full working start with 4 card groups, 3 Torments, 1 Boss

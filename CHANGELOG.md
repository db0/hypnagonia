# Dreams: Changelog

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
* Added more Torments and tweaked intents (@DioBal)
* Added two new effects: Retaliation and Resentment
* Added new Ego Archetype: Mad Scientist (Design by @DioBal)

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

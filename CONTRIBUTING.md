# Hypnagonia: Content Contribution Guide

There's a lot of game content areas we can use more of. This guide will try summarize what is needed before we can add such content

## How? Where?

To send us a contribution, there's two main ways

### Github Issue

Go to the issue tracker of this repository and open a new one. Fill in the details of your contribution, including all the points explained below for each type. We will add it to our backlog and implement it ASAP.

### Github Pull Request

If you know how to code, you can always straight up add the content yourself, and send us a PR. This will ensure your new content will be added to the game that much faster.

## Content Types

### Archetypes

Archetypes are the 4 building blocks of each run. Each archetype has a primary and a secondary mechanical theme. The primary mechanic defines how the archetype works and the secondary one provides synergies and combinations with other archetypes, as well as generic flavour. Mechanical themes can be things like "Confusion" or "Spark", or they can be things like Stances, Coin Flips, or any other weird mechanic we can think of. As long as we can build synergies around it, it can work.

Making an archetype is a significant amount of work. They need to have 20 unique cards, some cards should be generically good, and some which increase primary or secondary mechanic synergies.

Each card needs:
* A thematic card name
* A unique effect
* 2+ Upgrades
* Card Art

The card art can be skipped in the initial deployment, but eventually we'll need to think about it.

You can reuse cards from other archetypes which fit its primary or secondary theme, but you should not exceed 2 such cards

* The card pool needs a split of Common/Uncommon/Rare rarities with a ratio of approximately 7/9/4.
* The card pool needs at least 2 Concentrations. Preferrably one at each rarity.

Each Archetype also has assigned Curios and Memories, which can only be found when this archetype is being used. These Memories and Curios should complement it's primary or secondary mechanics. They are not mandatory to introduce a new Archetype, but certainly good to have.

Each Archetype can also be assigned unique Perturbations, which will only appear if that Archetype is being used. These would for example be Perturbations which explicitly disrupt its primary or secondary mechanics. You should aim for at least 1.

### Torments

Torment encounters are the bread & butter enemies which provide the majority of the core gameplay loop. Each Torment added should have some sort of "gimmick", or a way that it plays differently, which will force the player to adjust their playstyle to minimize their exposure to anxiety. The gimmick can be something simple like "Every second turn, it gives the player a specific perturbation", but it should be something that will make it somewhat stand out from others.

Making a torment is fairly straightforward. The following are needed

* Torment type: It should fit one of the main themes of Hypnagonia: Absurdity, Fear, Existential or Phobia
* Torment thematic name: It should fit the kind of type chosen for it.
* Torment intents: A list of 2+ actions that it will keep alternating between turns. The more of these you create, the more varied its playstyle. They can be ordered or random. The interaction of how you define there, determines how uniquely the Torment will act.

   They can be reusable components such as Stress:4, and Perplex:5, or something more unique, like adding special perturbations.
* Torment intent scripts: If some of your intents are unique, you'll need to describe their exact effect
* A journal encounter start blurb: What text to show the player introducting the Torment.
* A journal encounter end blurb: What text to show the player when the Torment is overcome. This is not mandatory to suggest a torment.
* A unique Understanding card: All basic Torments provide Understanding cards, which function as wildcards. Typically, the Understanding you get from each Torment, should be relevant to its unique playstyle. E.g. if the Torment is giving a lot of Envy, its Understanding would probably be Envy-based.
* Torment Journal art: This is the illustration shown in the journal when selecting the Torment. You can generate something using artbreeder that works. Aim for something disturbing, but not necessarily horror. Surreality and Uncanny Valley work better for Hypnagonia. This is not mandatory to suggest a torment.
* Torment Character art: What the player will see during the ordeal. This is not mandatory to suggest a torment.



### Elite Torments

These are very similar to Torments, but they present a significant threat to the player, and they have disruptive enough playstyles, that they can end the run of an unprepared player altogether.

Their requirements are very similar to basic Torments with a few differences

* Elites do not need Understanding Cards.
* Elites need more interesting mechanics than basic Torments. Elites are using individual scripts, so we can go wild with their complexity. The more complex the better.

### Non-Combat Encounters (NCEs)

NCEs are Dream Encounters which do not (typically) end in an ordeal. Instead they tend to be multiple choice options, which overall give benefits to the player.

Each NCE needs

* An introduction story
* 2+ Options for the player to choose from. The options should be comparable in effect. If one is worse than the other, players will not choose it. Aim for choices that would fit different run situations or playstyles.
* Each choice can have infinite branching choices below it. You can make a whole storyline if you want to. Up to you ;)
* Result story for each choice branch the player might take
* Mechanical results for each choice the player might take. I.e. what will the player gain or lose for each choice they make.

NCEs tend to fall into two categories: Easy and Risky. Easy NCEs are those where all choices they provide are either good or neutral. Gain a card, or do nothing is such an example

Risky NCEs are those which have a high-risk/high-reward ration. Typically all their choices somehow hurt or have a chance to the player. They are found only when the player ignores their repressed curiosity too much, and the player will keep encountering risky NCEs until they bring down their curiosity. This means the player cannot avoid risky NCEs forever by choosing other sorts of encounters.

This means you can be really nasty with NCEs, up to and including doing significant pain to the dreamer. But you should **always** make it a choice of what kind of pain they will receive. No choice, means no-fun ;)

Typically, you want to have at least *some* positive results. For example: Lots of Pain and a Curio, or less pain and nothing.



# AI Storylines

Hypnagonia 0.63 comes with an experimental AI model for generating stories. Only a few people need to generate the stories, while the rest of the playerbase will read and help rate them automatically.

As such We can use people who help generate stories to our system. This file will explain what you will need

# How to generate

First of all, you will need a [KoboldAI](https://github.com/KoboldAI/KoboldAI-Client) instance you can use. If you have a powerful GPU (at least 8GB VRAM), you can download and use the local version. Otherwise you can use the Google Collab version.

(Warning: As of writing, the KoboldAI branch to do this is under development, you will need to modify your installation/collab to use a special git branch. Contact me for info)

Make sure you are using the Nerys 2.7B or 13B Models

Once your KoboldAI is running, connect to it using the URL from collab (the local version will open a browser window automatically)

You will need to download and connect to it the special Hypnagonia softprompts. From this repository, in the softprompts directory, download the softprompt matching your Nerys model. Then upload it to your KoboldAI instance

Finally from this repository, download the `koboldai.json` story file, and then in KoboldAI use the `load from file functionality` to load it.

Finally run Hypnagonia. Go to settings and enable the `Generate` option under Artificial Intelligence. Provide the connection details to your KoboldAI instance (the defaults work for local instance). You should now be ready to use KoboldAI. Start playing the game, and it will start generating text automatically. Keep a window open to your KoboldAI instance, and you should notice it working every time a new Torment encounter appears.

Keep rating stories. Every time you rate a story positively, it will be uploaded to my telemetry server and then served to other people to rate. Rating is the glue to holds all this together, so make sure you rate every story!

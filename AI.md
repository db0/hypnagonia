# AI Storylines

Hypnagonia 0.63 comes with an experimental AI model for generating stories. Only a few people need to generate the stories, while the rest of the playerbase will read and help rate them automatically.

As such We can use people who help generate stories to our system. This file will explain what you will need

# How to generate

First of all, you will need a [KoboldAI](https://github.com/KoboldAI/KoboldAI-Client) instance you can use. If you have a powerful GPU (at least 8GB VRAM), you can download and use the local version. Otherwise you can use the Google Collab version.

* Model: Nerys 2.7B or Nerys 13B
* Version: United

Copy the `hypnagonia_koboldai_story.json` into the `stories/` folder of your KoboldAI installation (Gdrive for Collab, or local files)

Copy the contents of the `softprompts/` folder from the Hypnagonia repository into the `softprompts/` folder of your KoboldAI installation (Gdrive for Collab, or local files)

Once your KoboldAI is running, connect to it using the URL from collab (the local version will open a browser window automatically)

Finally run Hypnagonia. Go to settings and enable the `Generate` option under Artificial Intelligence. Provide the connection details to your KoboldAI instance (the defaults work for local instance, for a collab instance, change to the URL and set the port to 443).
You should now be ready to use KoboldAI. Start playing the game, and it will start generating text automatically. If you keep a window open to your KoboldAI instance, you should notice it working every time a new Torment encounter appears.

Keep rating stories. Every time you rate a story positively, it will be uploaded to my telemetry server and then served to other people to rate. Rating is the glue to holds all this together, so make sure you rate every story!

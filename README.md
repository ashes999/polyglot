# Polyglot

Haxelib for I18N (internationalization) project to facilitate L10N (localization) of your Haxe games/apps.

# Setting Up

Setup is pretty easy. First, clone this repository, and run `haxelib dev polyglot .` from the root directory of the repository.

Next, create a bunch of localization files with key/value pairs for messages, like so:

```
// en-CA.txt
KEY_TO_START: Press any key to start
GAME_OVER: Game Over!
```

Note that key/value pairs are delimited by a colon character (`:`).

Then, call `Translater.addLanguage`, passing in the contents of your file. Then, call `selectLanguage` to set the current language (perhaps after displaying it to the player).

For example, in HaxeFlixel/OpenFL, you might write something like this:

```
import polyglot.Translater;

class Main extends Sprite
{
	public function new()
	{
        super();        
        Translater.addLanguage(localization, Assets.getText("assets/data/localizations/en-CA.txt"));
        Translater.selectLanguage("en-CA");
        // ...
	}
}
```

# Reading Messages

Finally, to read a value using the current selcted language, simply call `Translater.get`:

```
this.startLabel.text = Translater.get("KEY_TO_START");
```

# Including Variables in Messages
If you would like to add variables into your messages, format them with C#-/Python-like tokens, like so:

```
// en-GB.txt
Health: {0}/{1}
```

Pass in an array with all the values to `.get`, along with the key:

```
Translater.get("Health", [3, 5]); // Returns: Health: 3/5
```

# Supported Languages

Polyglot doesn't inherently support (or not support) any languages; it depends on your underlying game engine. However, note that HaxeFlixel (although not OpenFL) doesn't really support right-to-left languages yet, such as Arabic or Urdu. Hopefully, that change will come in the near future. (Please add your voice to [this GitHub issue on the HaxeFlixel repository](https://github.com/HaxeFlixel/flixel/issues/2096) if you would like to see this implemented!)
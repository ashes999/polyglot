package polyglot;

import massive.munit.util.Timer;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;

import polyglot.Translater;

using StringTools;

/**
* Auto generated ExampleTest for MassiveUnit. 
* This is an example test class can be used as a template for writing normal and async tests 
* Refer to munit command line tool for more information (haxelib run munit)
*/
class TranslaterTest 
{
    @Before
    public function resetTranslations():Void
    {
        Translater.clear();
    }

    @Test
    public function addLanguageThrowsIfLanguageFileIsInvalid():Void
    {
		var ex:String = Assert.throws(String, function() {
            Translater.addLanguage("en-US", "not a real language file!");
        });

        Assert.isTrue(ex.toLowerCase().indexOf("invalid") > -1);
    }

    @Test
    public function getThrowsIfNoTranslationsExist():Void
    {
        var ex:String = Assert.throws(String, function() {
            Translater.get("hi");
        });
        
        Assert.isTrue(ex.indexOf("addLanguage") > -1);
    }

    @Test
    public function getThrowsIfSelectLanguageWasntCalled():Void
    {
        Translater.addLanguage("en-US", "HELLO_WORLD: Hello, World!");
        var ex:String = Assert.throws(String, function() {
            Translater.get("HELLO_WORLD");
        });
        
        Assert.isTrue(ex.indexOf("selectLanguage") > -1);
    }

    @Test
    public function selectLanguageThrowsIfLanguageWasntAdded():Void
    {
        Translater.addLanguage("en-US", "HELLO_WORLD: Hello, World!");

        var ex:String = Assert.throws(String, function() {
            Translater.selectLanguage("ar-SA");
        });
        
        Assert.isTrue(ex.indexOf("not a valid language code") > -1);
    }

    @Test
	public function getGetsTranslationInSpecifiedLanguageAndIgnoresCommentsAndBlankLines():Void
	{
        var key:String = "HELLO_WORLD";
        var expected:String = "السلام عليكم";
		Translater.addLanguage("ar-SA", 
'${key}: ${expected}
# This is a comment. Blank lines are ignored.

NUM_APPLES: 7');

        Translater.selectLanguage("ar-SA");
        
        var actual = Translater.get(key);
        Assert.areEqual(expected, actual);
	}

    @Test
    public function getSubstitutesParameters():Void
    {
        var p1:Int = 6;
        var p2:String = "Cherry";

        var key:String = "BUY_IT";
        var message:String = 'Please buy {0} of {1}. {0}{0}{0} {1}!!!';
		Translater.addLanguage("en-GB", '${key}: ${message}');
        Translater.selectLanguage("en-GB");
        
        var actual = Translater.get(key, [p1, p2]);
        var expected = message.replace("{0}", '${p1}').replace("{1}", p2);
        Assert.areEqual(expected, actual);
    }

    @Test
    public function getReturnsTokenIfMessageIsNotDefined():Void
    {
		Translater.addLanguage("ar-SA", "HELLO_WORLD: السلام عليكم");
        Translater.selectLanguage("ar-SA");
        
        var actual = Translater.get("GAME_OVER");
        Assert.areEqual("GAME_OVER", actual);
    }
}
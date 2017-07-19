package polyglot;

import massive.munit.util.Timer;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;

import polyglot.Translater;

/**
* Auto generated ExampleTest for MassiveUnit. 
* This is an example test class can be used as a template for writing normal and async tests 
* Refer to munit command line tool for more information (haxelib run munit)
*/
class TranslaterTest 
{
    @BeforeClass
    public function resetTranslations():Void
    {
        Translater.initialize();
    }

    @Test
    public function addTranslationThrowsIfLanguageFileIsInvalid():Void
    {
		var ex:String = Assert.throws(String, function() {
            Translater.addTranslation("en-US", "not a real file!");
        });

        Assert.isTrue(ex.toLowerCase().indexOf("invalid") > -1);
    }

    @Test
	public function getGetsTranslationInSpecifiedLanguage():Void
	{
		Assert.isTrue(true);
	}

    @Test
    public function getReturnsTokenIfMessageIsNotDefined():Void
    {
		Assert.isTrue(true);
    }
}
package polyglot;
using StringTools;

/**
 *  Translates strings for you.
 */
class Translater
{
    // language code => { key => translation }
    private static var translations:Map<String, Map<String, String>>;

    public static function initialize():Void
    {
        Translater.translations = new Map<String, Map<String, String>>();
    } 

    // TODO: having a single .xml file or something listing languages would be nice.
    // We can't auto-discover files because there ARE no files on JS.
    public static function addTranslation(languageCode:String, translationFileContents:String):Void
    {
        var lines = translationFileContents.split('\n');
        var toReturn = new Map<String, String>();
        for (line in lines)
        {
            var delimeter:Int = line.indexOf(":");
            if (delimeter == -1)
            {
                throw 'Language code ${languageCode} has invalid line (no delimeter): ${line}';
            }

            var key = line.substr(0, delimeter).trim();
            var message = line.substr(delimeter + 1).trim();
            toReturn.set(key, message);            
        }
        translations.set(languageCode, toReturn);
    }
}
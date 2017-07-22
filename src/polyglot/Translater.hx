package polyglot;
using StringTools;

/**
 *  Translates strings for you.
 */
class Translater
{
    // language code => { key => translation }
    private static var translations = new Map<LanguageAndCultureCode, Map<String, String>>();
    private static var currentLanguage:LanguageAndCultureCode = "";

    // For testing.
    public static function clear():Void
    {
        Translater.translations = new Map<LanguageAndCultureCode, Map<String, String>>();
        Translater.currentLanguage = "";
    } 

    // TODO: having a single .xml file or something listing languages would be nice.
    // We can't auto-discover files because there ARE no files on JS.
    public static function addLanguage(languageCode:LanguageAndCultureCode, translationFileContents:String):Void
    {
        var lines = translationFileContents.split('\n');
        var toReturn = new Map<String, String>();
        for (line in lines)
        {
            line = line.trim();
            // empty or a comment? ignore it.
            if (line.length == 0 || line.startsWith("#"))
            {
                continue;
            }

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

    public static function selectLanguage(languageCode:LanguageAndCultureCode):Void
    {
        if (!translations.exists(languageCode))
        {
            throw '${languageCode} is not a valid language code (valid options: ${Translater.translations.keys}). Did you forget to call Translater.addTranslation?';
        }

        Translater.currentLanguage = languageCode;
    }

    public static function get(key:String, ?params:Array<Any>):String
    {
        if (!Translater.translations.keys().hasNext())
        {
            throw "Please call Translater.addLanguage before instantiating a translater";
        }
        else if (Translater.currentLanguage == "")
        {
            throw "Please call Translater.selectLanguage before instantiating a translater";
        }

        var messages = Translater.translations.get(Translater.currentLanguage);
        var toReturn = messages.get(key);
        if (toReturn == null)
        {
            return key;
        }
        else if (params == null || params.length == 0)
        {
            return toReturn;
        }
        else
        {
            // Substitute in values
            var i:Int = 0;

            for (param in params)
            {
                toReturn = toReturn.replace('{${i}}', '${param}');
                i++;
            }

            return toReturn;
        }
    }
}

typedef LanguageAndCultureCode = String;
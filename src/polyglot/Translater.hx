package polyglot;
using StringTools;

/**
 *  Translates strings for you.
 */
class Translater
{
    // language code => { key => translation }
    private static var translations:Map<LanguageAndCultureCode, Map<String, String>>;
    private static var currentLanguage:LanguageAndCultureCode = "";

    public function new()
    {
        if (!Translater.translations.keys().hasNext())
        {
            throw "Please call Translater.addTranslation before instantiating a translater";
        }
        else if (Translater.currentLanguage == "")
        {
            throw "Please call Translater.selectLanguage before instantiating a translater";
        }
    }

    public static function initialize():Void
    {
        Translater.translations = new Map<LanguageAndCultureCode, Map<String, String>>();
        Translater.currentLanguage = "";
    } 

    // TODO: having a single .xml file or something listing languages would be nice.
    // We can't auto-discover files because there ARE no files on JS.
    public static function addTranslation(languageCode:LanguageAndCultureCode, translationFileContents:String):Void
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

    public static function selectLanguage(languageCode:LanguageAndCultureCode):Void
    {
        if (!translations.exists(languageCode))
        {
            throw '${languageCode} is not a valid language code (valid options: ${Translater.translations.keys}). Did you forget to call Translater.addTranslation?';
        }

        Translater.currentLanguage = languageCode;
    }

    public function get(key:String):String
    {
        var messages = Translater.translations.get(Translater.currentLanguage);
        var toReturn = messages.get(key);
        return toReturn != null ? toReturn : key;
    }
}

typedef LanguageAndCultureCode = String;
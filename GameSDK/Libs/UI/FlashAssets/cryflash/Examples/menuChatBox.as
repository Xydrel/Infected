import cryflash.CryObjects.Text.CryChatBox;
import cryflash.CryRegistry;
import cryflash.Definitions;

/**
 * ...
 * @author RuneRask
 */
class cryflash.Examples.menuChatBox extends CryChatBox
{
	
	public function menuChatBox(id, title, column, guide) 
	{
		super			(id, Definitions.ChatBox, CryRegistry.CryButtonHolder);
		defineChatbox	(Definitions.CaptionField, "Title", "Chatbox");
		//addHitbox		(Definitions.Hitbox);
		placeObject		(column, guide);
		
	}
	
}

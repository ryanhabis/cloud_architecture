package TeamBot;

import org.pircbotx.hooks.ListenerAdapter;
import org.pircbotx.hooks.types.GenericMessageEvent;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author grantp
 */
public class BotListener extends ListenerAdapter {
    
    private static final Logger LOGGER = LoggerFactory.getLogger(TeamBot.class);
    
    @Override
    public void onGenericMessage(GenericMessageEvent event) {
        if (event.getMessage().startsWith("?coffee"))
            event.respond("Coffee coming up for " + event.getUser().getNick());
            LOGGER.info(String.format("Bring %s a coffee", event.getUser().getNick()));
    }
    
}

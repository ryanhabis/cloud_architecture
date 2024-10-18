package TeamBot;

import org.pircbotx.Configuration;
import org.pircbotx.PircBotX;
import org.pircbotx.hooks.ListenerAdapter;
import org.pircbotx.hooks.types.GenericMessageEvent;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class TeamBot extends ListenerAdapter {
    
    private static Logger LOGGER = LoggerFactory.getLogger(TeamBot.class);
    
    
    @Override
    public void onGenericMessage(GenericMessageEvent event) {
        if (event.getMessage().startsWith("?coffee"))
            event.respond("Coffee coming up for " + event.getUser().getNick());
            System.out.println("Bring me " + event.getUser().getNick() + " a coffee");
    }

    public static void main(String[] args) throws Exception {
        System.out.println("TeamBot starting up");
        //Configure what we want our bot to do
        Configuration configuration = new Configuration.Builder()
                .setAutoNickChange(true)
                .setName("TeamBot") //Set the nick of the bot. CHANGE IN YOUR CODE
                .addServer("127.0.0.1") //Join the freenode network
                .addAutoJoinChannel("#general") //Join the official #pircbotx channel
                .addListener(new TeamBot()) //Add our listener that will be called on Events
                .buildConfiguration();

        //Create our bot with the configuration
        PircBotX bot = new PircBotX(configuration);

        //Connect to the server
        bot.startBot();
        
    }
}

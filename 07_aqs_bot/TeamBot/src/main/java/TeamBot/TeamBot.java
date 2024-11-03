package TeamBot;

import org.pircbotx.Configuration;
import org.pircbotx.PircBotX;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class TeamBot {
    
    private static final Logger LOGGER = LoggerFactory.getLogger(TeamBot.class);

    public static void main(String[] args) throws Exception {
        System.out.println("TeamBot starting up");
        
        QueueSender queueSender = new QueueSender(args[0]);
        
        BotListener botListener = new BotListener();
        botListener.setQueueSender(queueSender);
        
        //Configure what we want our bot to do
        Configuration configuration = new Configuration.Builder()
                .setAutoNickChange(true)
                .setName("TeamBot") //Set the nick of the bot. CHANGE IN YOUR CODE
                .addServer("127.0.0.1") //Join the freenode network
                .addAutoJoinChannel("#general") //Join the official #pircbotx channel
                .addListener(botListener) //Add our listener that will be called on Events
                .buildConfiguration();

        //Create our bot with the configuration
        PircBotX bot = new PircBotX(configuration);

        //Connect to the server
        bot.startBot();
        
    }
}

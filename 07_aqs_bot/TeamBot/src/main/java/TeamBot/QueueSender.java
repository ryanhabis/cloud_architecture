
package TeamBot;

import com.azure.identity.DefaultAzureCredentialBuilder;
import com.azure.storage.queue.QueueClient;
import com.azure.storage.queue.QueueClientBuilder;

public class QueueSender {
        
    public final String connectionString;
    
    public QueueSender(String connectionString) {
        
        this.connectionString=connectionString;
        
    }
    
    public void sendMessage(String message) {
        
        new DefaultAzureCredentialBuilder().build();
        
        QueueClient queueClient = new QueueClientBuilder()
        .connectionString(connectionString)
        .queueName("coffeeq")
        .buildClient();
        queueClient.sendMessage(message);
    }
    
}

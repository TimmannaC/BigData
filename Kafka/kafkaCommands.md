#### To get or Create an topics in kafka

      - we need to use /bin/kafka-topics.sh script file
      - we have options like
          1) --alter   Alter the number of partitions,replica assignment, and/or configuration for the topic.
          2) --create                                 Create a new topic.
          3) --delete                                 Delete a topic
          4) --describe                               List details for the given topics.
          5) --list                                   List all available topics.
          6) --partitions <Integer: # of partitions>  The number of partitions for the topic being created or altered.
          7) --zookeeper <String: urls>               REQUIRED: The connection string for the zookeeper connection in the form
                                                      host:port. Multiple URLS can be given to allow fail-over.
                                                      
      
   ### Create a Topic
        $> ./kafka-topics.sh --zookeeper localhost:2181 --create --topic "testing" --partitions 10 --replication-factor 1
          NOTE: --partitions and replication-factor are Req while creating the topic
         
         #To verify list the topics
         $> /kafka-topics.sh --zookeeper localhost:2181 --list
        
   ### After creating the topic we can see the topic is stored in zookeeper in /brokers/topics znode.
        $> ./zkCli.sh  // to start the zookeeper client.
        $> ls /brokers/topics.
          

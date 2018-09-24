#### Role Of Zookeeper in kafka cluster.

    1)Kafka uses Zookeeper to do leadership election of Kafka Broker and Topic Partition pairs.
    
    2)Kafka uses Zookeeper to manage the kafka brokers.
    
    3)Zookeeper sends changes of the topology to Kafka, 
        so each node in the cluster knows when a new broker joined, a Broker died, a topic was removed or a topic was added, etc.
        
    4)Zookeeper provides an in-sync view of Kafka Cluster configuration.  

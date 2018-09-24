#### Kafka Producer, Consumer, Topic details
    
      1) Kafka producers write to Topics. Kafka consumers read from Topics.
      
      2) A topic is associated with a log which is data structure on disk. 
      
      3) Kafka appends records from a producer(s) to the end of a topic log.
      
      4) A topic log consists of many partitions that are spread over multiple files which can be spread on multiple Kafka cluster nodes. 
      
      5) Consumers read from Kafka topics at their cadence and can pick where they are (offset) in the topic log.
      
      6) Each consumer group tracks offset from where they left off reading.
      
      7) Kafka distributes topic log partitions on different nodes in a cluster for high performance with horizontal scalability.
      
      8) partitions are needed to have multiple consumers in a consumer group work at the same time.
      
      9) Kafka replicates partitions to many nodes to provide failover.
      
      
#### Kafka Topics, Logs, Partitions

      1) Kafka topic is a named stream of records. Kafka stores topics in logs.
      
      2) A topic log is broken up into partitions. Kafka spreads log’s partitions across multiple servers or disks. 
      
      3) Think of a topic as a category, stream name or feed.
      
      4) Topics are broken up into partitions for speed, scalability, and size.
      
#### Kafka Topic Partitions.
    
      1) Kafka breaks topic logs up into partitions. 
      
      2) A record is stored on a partition usually by record key if the key is present and round-robin if the key is missing (default behavior). 
      
      3) The record key, by default, determines which partition a producer sends the record.
      
      4) Kafka uses partitions to scale a topic across many servers for producer writes.
      
      5) he order guaranteed per partition. If partitioning by key then all records for the key will be on the same partition which is useful if you ever have to replay the log. 
         Kafka can replicate partitions to multiple brokers for failover.
         
#### Kafka Topic Partition Replication
      
      1) Kafka can replicate partitions across a configurable number of Kafka servers which is used for fault tolerance.
      
      2) Each partition has a leader server and zero or more follower servers. Leaders handle all read and write requests for a partition.
      
      3) Followers replicate leaders and take over if the leader dies. 
      
      4) Kafka distributes topic log partitions over servers in the Kafka cluster. Each server handles its share of data and requests by sharing partition leadership.
      
#### Replication: Kafka Partition Leaders, Followers and ISRs.
    
      1) Kafka chooses one broker’s partition’s replicas as leader using ZooKeeper.
      
      2) The broker that has the partition leader handles all reads and writes of records for the partition.
      
      3) Kafka replicates writes to the leader partition to followers (node/partition pair). A follower that is in-sync is called an ISR (in-sync replica).
      
      
      
         
         
         
         
         
         
         
         
         
         
         
         
         
         
      


#### What all happens when we start the kafka server.

        1) Modify the server.properties file with new id and port.
        
        2) start the kafka server using command ./bin/kafka-server-start.sh ../conf/server.properties
        
          - kafka server starts and connects to zookeeper 
          - zookeeper creates new producerId and stores in /brokers/ids/1002 znode
          - creates new log directory as specified in server.properties file
          

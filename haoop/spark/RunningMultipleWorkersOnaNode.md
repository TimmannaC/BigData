# Running multiple wokers on a single instance in spark.

### Start the master process.
> ./start-master.sh

### Starting the worker processes.

###### NOTE : Before starting the worker processes we need to modify the default spark-env,sh file.
              - Take the back up of spark-env.sh-template and rename it to spark-env.sh
              - open the spark-env.sh file add the property SPARK_WORKER_INSTANCES=<No of workers required> (eg: 2)
              - start the worker processes.
> ./start-slave.sh <master-URL>:port
  
##### To verify 
      - Run jps command or
      - Go to master UI we can see the workers.
              
              

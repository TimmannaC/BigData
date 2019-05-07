# Introduction to Spark.

### Context: The Big Data Problem
- Why do we need a new engine and programming model for data analytics in the first place?
- For most of their history, computers became faster every year through processor speed increases.
- The new processors each year could run more instructions per second than the previous year’s.
- As a result, applications also automatically became faster every year, without any changes needed to their code.
- This trend led to a large and established ecosystem of applications building up over time, most of which were designed to run only on a single processor.
- These applications rode the trend of improved processor speeds to scale up to larger computations and larger volumes of data over time.
- Unfortunately, this trend in hardware stopped around 2005: due to hard limits in heat dissipation,hardware developers stopped making individual processors faster, and switched toward adding more parallel CPU cores all running at the same speed.
- The cost to store 1 TB of data continues to drop by roughly two
times every 14 months, meaning that it is very inexpensive for organizations of all sizes to store large amounts of data.
- Moreover, many of the technologies for collecting data (sensors, cameras, public datasets, etc.) continue to drop in cost and improve in resolution.
- For example, camera technology continues to improve in resolution and drop in cost per pixel every year, to the point where a 12-megapixel webcam costs only $3 to $4; this has made it inexpensive to collect a wide range of visual data, whether from people filming video or automated sensors in an industrial setting.
- The end result is a world in which collecting data is extremely inexpensive—many organizations today even consider it negligent not to log data of possible relevance to the business—but processing it requires large, parallel computations, often on clusters of machines.
- Moreover, in this new world,
the software developed in the past 50 years cannot automatically scale up, and neither can the traditional programming models for data processing applications, creating the need for new programming models.
- It is this world that Apache Spark was built for.
- cluster computing held tremendous potential: at every organization that used MapReduce, brand new applications could be built using theexisting data, and many new groups began using the system after its initial use cases.
- However, the MapReduce engine made it both challenging and inefficient to build large applications.
- To address this problem, the Spark team first designed an API based on functional programming that could succinctly express multistep applications.
- The team then implemented this API over a new engine that could perform efficient, in-memory data sharing across computation steps.
- Spark’s core idea of composable APIs has also been refined over time.
- Early versions of Spark (before 1.0) largely defined this API in terms of functional operations—parallel operations such as maps and reduces over collections of Java objects.
- Beginning with 1.0, the project added Spark SQL, a new API for working with structured data—tables with a fixed data format that is not
tied to Java’s in-memory representation.
- Spark SQL enabled powerful new optimizations across
libraries and APIs by understanding both the data format and the user code that runs on it in more detail.
___

## A Gentle Introduction to Spark

### Spark’s Basic Architecture
- A cluster, or group, of computers, pools the resources of many machines together, giving us the ability to use all the cumulative resources as if they were a single computer.
- Now, a group of machines alone is not powerful, you need a framework to coordinate work across them.
- Spark does just that, managing and coordinating the execution of tasks on data across a cluster of computers.

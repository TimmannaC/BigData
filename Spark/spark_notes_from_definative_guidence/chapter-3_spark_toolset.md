## A Tour of Spark’s Toolset

&nbsp;
&nbsp;

![alt](images/spark_toolset.png)

- These simple conceptual building blocks are the foundation of Apache Spark’s vast ecosystem of tools and libraries.
- Spark is composed of these primitives the lower-level APIs and the Structured APIs and then a series of standard libraries for additional functionality.
___

&nbsp;

### Lower-Level APIs
- Spark includes a number of lower-level primitives to allow for           arbitrary Java and Python object manipulation via Resilient      Distributed Datasets (RDDs).
- Virtually everything in Spark is built on top of RDDs.
- DataFrame operations are built on top of RDDs and compile down to these lower-level tools for convenient and extremely efficient distributed execution.
- There are some things that you might use RDDs for, especially when you’re reading or manipulating raw data, but for the most part you should stick to the Structured APIs.
- RDDs are lower level than DataFrames because they reveal physical execution characteristics (like partitions) to end users.
- RDDs are available in Scala as well as Python. However, they’re not equivalent. This differs from the DataFrame API (where the execution characteristics are the same) due to some underlyingimplementation details.
- As end users, you shouldn’t need to use RDDs much in order to perform many tasks unless you’re maintaining older Spark code.
- There are basically no instances in modern Spark, for which you should be using RDDs instead of the structured APIs beyond manipulating some very raw unprocessed and unstructured data.

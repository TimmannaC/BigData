### Machine Learning with Spark and Hadoop
___

- Machine learning is split into two separate packages in spark:
	- spark.mllib  
		-	This is the original machine learning API built on top of Resilient Distributed Datasets (RDD).
		-	As of Spark 2.0, this RDD-based API is in maintenance mode and is expected to be deprecated and 
			removed in upcoming releases of Spark.
	- spark.ml
		-	This is the primary machine learning API built on top of DataFrames to construct machine learning 
			pipelines and optimizations.

___
NOTE: spark.ml is preferred over spark.mllib because it is based on the DataFrames API that provides higher 
		performance and flexibility.
___


#### Machine learning algorithms
___

| Type of machine learning | Type of algorithm | Algorithm name |
| ------------------------ | ----------------- | -------------- |
|	Supervised learning	   |   Classification  | Naive Bayes    |
|						   |				   | Decision Trees |
|						   |				   | Random Forests |
|						   |				   | Gradient-Boosted Trees |
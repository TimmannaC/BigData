### 				Machine Learning with Spark and Hadoop
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
|						   |  	Regression	   | Linear Regression | 
|						   |				   | Logistic Regression |
|						   |				   | Support Vector Machines |
|  Unsupervised learning   | Clustering		   |  K-Means |
|						   |				   |  Gaussian mixture |
|						   |				   | Power Iteration Clustering (PIC) |
|						   |				   | Latent Dirichlet Allocation (LDA) |
|						   |				   | Streaming k-means |
|						   | Dimensionality reduction | Singular Value Decomposition (SVD) |
|						   |				   		  | Principal Component Analysis (PCA) |
|	Recommender systems	   | Collaborative filtering | user-based collaborative filtering |
|						   |						 | Item-based collaborative filtering |
|						   |						 | Alternating Least Squares (ALS)    |
|  Feature extraction      | Feature extraction and transformation | TF-IDF |
|						   |									   | Word2Vec |
|						   |									   | Standard Scaler |
|						   |									   | Normalizer |
|						   |									   | Chi-Square Selector |
|  Optimization            |	Optimization  |  Stochastic Gradient Descent |
|						   |				  | Limited-memory BFGS |


___
#### Spark MLlib data types
___
-	MLlib supports 4 types of data structures
	-	local Vector
		- This can be dense or sparse vector that is stored in on a single machine.
		- A dense vector is a traditional array of doubles.
		 ```
		 	>>> dv1 = np.array([2.0,3.0,5.0])
		 ```
		- A sparse vector uses integer indices and double values
		```
			from pyspark.mllib.linalg import SparseVector
			>>> sv1 = Vectors.sparse(2,[0,3],[5.0,9.0])
			>>> sv1
			SparseVector(2,{0: 5.0,3: 9.0})
		```
	-	labeled point 
		- This can be dense or sparse vector with a label used in supervised learning.
		- from pyspark.mllib.regression import LabeledPoint
		```
			# Labeled point with a positive label and dense feature vector
			>>> lp_pos = LabeledPoint(1.0,[4.0,2.0,1.0])
			>>> lp_pos
			LabeledPoint(1.0,[4.0,2.0,1.0])
			
			# Labeled point with a negative label and sparse feature vector
			>>> lp_neg = LabeledPoint(0.0,SparseVector(5,[1,2],[2.0,3.0]))
			>>> lp_neg
			LabeledPoint(5,[1,2],[2.0,3.0])
		```
	-	local matrix
		- This is a matrix with integer type indices and double type values. This is also stored on a single machine. 
		```
			from pyspark.mllib.linalg import Matrix, Matrices
			# Dense Matrix ((1.0,2.0,3.0),(4.0,5.0,6.0))
			dMatrix = Matrices.dense(2,3,[1,2,3,4,5,6])
			# Sparse Matrix ((9.0,3.0),(0.0,8.0),(0.0,6.0))
			sMatrix = Matrices.sparse(3,2,[0,1,3],[0,2,1],[1,3,5])
		```
	-	distributed matrix
		- This matrix is stored distributedly in one or more RDDs on multiple machines.
		- There are 4 types of distributed matrix available.
			- RowMatrix - This is a distributed matrix of rows with meaningless indices created from an RDD of vectors.
			- IndexedRowMatrix 
				- Rown indices are meaningful in this matrix. This RDD is created with indexed rows using the IndexedRowMatrix class
				  and then IndexedRowMatrix is created.
			- CoordinateMatrix
				- This matrix is useful for very large and sparse matrices. CoordinateMatrix is created from RDDs of the MatrixEntry 
				  points, represented by a tuple of the long or float type.
			- BlockMatrix - BlockMatrix is created from RDDs of sub-matrix blocks.














































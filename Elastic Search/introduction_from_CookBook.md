
 							Elastic search notes from cookbook
 
 chapter : 1 Introduction
 	- The key concepts in ElasticSearch are 
		- node, index, shard, mapping/type,document, and field.
	- ElasticSearch can be used both as a search engine as well as a data store.
	- Some details on data replications and base node communication processes are also explained.
	  - Every instance of ElasticSearch is called a node. 
	  - Several nodes are grouped in a cluster.
	  - A common approach in cluster management is to have a master node, which is the main reference for all cluster-level actions, 
	    and the other nodes, called secondary nodes, that replicate the master data and its actions.
	  - To be consistent in the write operations, all the update actions are first committed in the master node and then replicated 
	    in the secondary nodes.
	  - In a cluster with multiple nodes, if a master node dies, a master-eligible node is elected to be the new master node. 
	    This approach allows automatic failover to be set up in an ElasticSearch cluster.
	  - How it works...
	  	- Our main data container is called index (plural indices) and it can be considered as a database in the traditional SQL world.
		- In an index, the data is grouped into data types called mappings in ElasticSearch.
		- A mapping describes how the records are composed (fields).
		- Every record that must be stored in ElasticSearch must be a JSON object.
		- Natively, ElasticSearch is a schema-less data store;
		- when you enter records in it during the insert process it processes the records, splits it into fields, and updates the 
		  schema to manage the inserted data.
		- To manage huge volumes of records, ElasticSearch uses the common approach to split an index into multiple shards 
		  so that they can be spread on several nodes.
		- Shard management is transparent to the users; all common record operations are managed automatically in the
		  ElasticSearch application layer.
		- Every record is stored in only a shard;
		- the sharding algorithm is based on a record ID, so many operations that require loading and changing of records/objects, 
		  can be achieved without hitting all the shards, but only the shard (and its replica) that contains your object.
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
 - Chapter 4 basic operations
   - The first operation before starting to Index data in ElasticSearch is to create an index—the main
	 container of our data.
   - An Index is similar to Database concept in SQL, 
   	 a container for types, such as tables in SQL,
	 and documents, such as records in SQL.
   - The HTTP method to create an index is PUT (POST also works); the REST URL contains the index name:
	 http://<server>/<index_name>
   - To create an index, we will perform the following steps:
   		1.	 Using the command line, we can execute a PUT call:
			curl -XPUT http://127.0.0.1:9200/myindex -d '{
				"settings" : {
					"index" : {
						"number_of_shards" : 2,
						"number_of_replicas" : 1
					}
				}
			}'
		2.	 The result returned by ElasticSearch, if everything goes well, should be:
			{"acknowledged":true}
		3.	 If the index already exists, then a 400 error is returned:
			{"error":"IndexAlreadyExistsException[[myindex] Already
			exists]","status":400}
	
NOTE : The index name will be mapped to a directory on your storage.

	- During index creation, the replication can be set with two parameters in the
	  settings/index object:	
	  	- number_of_shard : This controls the number of shards that compose the
		  index (every shard can store up to 2^32 documents).
		- number_of_replicas : This controls the number of replicas (how many times your data is replicated in the cluster for high availability).
		  A good practice is to set this value to at least to 1
		
	- The API call initializes a new index, which means:
		- The index is created in a primary node first and then its status is propagated to the cluster level
		- A default mapping (empty) is created
		- All the shards required by the index are initialized and ready to accept data
	
	- There's more...
		- The index creation command also allows us to pass the mappings section, which contains the mapping definitions. 
		  It is a shortcut to create an index with mappings, without executing an extra PUT mapping call.
		- A common example of this call, using the mapping from the Putting a mapping in an index is 
		
			curl -XPOST localhost:9200/myindex -d '{
				"settings" : {
				"number_of_shards" : 2,
				"number_of_replicas" : 1
				},
				"mappings" : {
					"order" : {
						"properties" : {
							"id" : {"type" : "string", "store" : "yes" ,
							"index":"not_analyzed"},
							"date" : {"type" : "date", "store" : "no" ,
							"index":"not_analyzed"},
							"customer_id" : {"type" : "string", "store" : "yes" ,
							"index":"not_analyzed"},
							"sent" : {"type" : "boolean", "index":"not_analyzed"},
							"name" : {"type" : "string", "index":"analyzed"},
							"quantity" : {"type" : "integer", "index":"not_analyzed"},
							"vat" : {"type" : "double", "index":"no"}
						}
					}
				}
			}'

		### Deleting an index
		
		-	Deleting an index means deleting its shards, mappings, and data.
		-	There are many common scenarios where we need to delete an index, such as the following:
			- Removing the index to clean unwanted/obsolete data (for example,old logstash indices)
			- Resetting an index for a scratch restart
			- Deleting an index that has some missing shard, mainly due to some failure,to bring back the cluster to a valid state
			
			#### How to do it...
			
			- The HTTP method used to delete an index is DELETE.
			 - The URL contains only the index name:
			 	http://<server>/<index_name>
			 - To delete an index, we will perform the following steps:
			 	- From a command line, we can execute a DELETE call:
				   curl -XDELETE http://127.0.0.1:9200/myindex
				- The result returned by ElasticSearch, if everything goes well, should be:
					{"acknowledged":true}
				- If the index doesn't exist, then a 404 error is returned:
					{"error":"IndexMissingException[[myindex] missing]","status":404}
			
			#### How it works...
			
			 - When an index is deleted, all the data related to the index is removed from the disk and is lost.
			 - During the deletion process, at first, the cluster is updated when the shards are deleted from the storage. 
			   This operation is fast; in the traditional filesystem it is implemented as a recursive delete.
			 - It's not possible to restore a deleted index if there is no backup.
			 - Also, calling by using the special _all , index_name can be used to remove all the indices. In production, 
			   it is a good practice to disable the all indices deletion parameter by adding the following line to 
			   elasticsearch.yml :
				action.destructive_requires_name:true

		 ### Opening/closing an index
		 	- If you want to keep your data but save resources (memory/CPU), a good alternative to deleting an Index is to close it.
			- ElasticSearch allows you to open or close an index to put it in online/offline mode.
			
			#### How to do it...
				1) From the command line, we can execute a POST call to close an index:
					curl -XPOST http://127.0.0.1:9200/myindex/_close
				2) If the call is successful, the result returned by ElasticSearch should be:
					{"acknowledged":true}
				3) To open an index from the command line, enter:
					curl -XPOST http://127.0.0.1:9200/myindex/_open
				4) If the call is successful, the result returned by ElasticSearch should be:
					{"acknowledged":true}
				
				#### How it works...
				- When an index is closed, there is no overhead on the cluster (except for the metadata state);
					the index shards are turned off and don't use file descriptors, memory, or threads.
				
			### Putting a mapping in an index
				- This recipe shows how to put a type of mapping in an index.
				
				#### Getting ready
				- You will need a working ElasticSearch cluster and the index created
				
				#### How to do it...
				- The HTTP method for puttting a mapping is PUT (POST also works).
					The URL format for putting a mapping is:
					http://<server>/<index_name>/<type_name>/_mapping
					
					- To put a mapping in an Index, we will perform the following steps:
					  1. If we consider the type order of the previous chapter, the call will be:
					
					  	```
						curl -XPUT 'http://localhost:9200/myindex/order/_mapping' -d '{
							"order" : {
								"properties" : {
									"id" : {"type" : "string", "store" : "yes" ,
									"index":"not_analyzed"},
									"date" : {"type" : "date", "store" : "no" ,
									"index":"not_analyzed"},
									"customer_id" : {"type" : "string", "store" : "yes" ,
									"index":"not_analyzed"},
									"sent" : {"type" : "boolean",
									"index":"not_analyzed"},
									"name" : {"type" : "string", "index":"analyzed"},
									"quantity" : {"type" : "integer",
									"index":"not_analyzed"},
									"vat" : {"type" : "double", "index":"no"}
								}
							}
						}'
						
						```
						
						2. If successful, the result returned by ElasticSearch should be:
							```
							{"acknowledged":true}
							```
				#### How it works...
					- This call checks if the index exists and then it creates one or more types of mapping as
						described in the definition.
					- During mapping insertion, if there is an existing mapping for this type, it is merged with
					   the new one.
					- If there is a field with a different type and the type cannot be updated by
						expanding the fields property, an exception is raised.
					- To prevent exception during the merging mapping phase, it's possible to specify the parameter 
						ignore_conflicts to true (default is false ).


			### Indexing a document
				- In ElasticSearch, there are two vital operations namely, Indexing and Searching.
				- Indexing means inserting one or more document in an index; this is similar to the insert command of a relational database.
				- the core engine of ElasticSearch, inserting or updating a document has the same cost.
				-  ##### How to do it...
					- To index a document, several REST entry points can be used:
							Method 		URL
							POST 		http://<server>/<index_name>/<type>
							PUT/POST 	http://<server>/<index_name>/<type>/<id>
							PUT/POST 	http://<server>/<index_name>/<type>/<id>/_create

					- We will perform the following steps:
						1. If we consider the type order mentioned in earlier chapters, the call to index a document will be:
							```
							curl -XPOST 'http://localhost:9200/myindex/order/2qLrAfPVQvCRMe7Ku8r0Tw' -d '{
								"id" : "1234",
								"date" : "2013-06-07T12:14:54",
								"customer_id" : "customer1",
								"sent" : true,
								"in_stock_items" : 0,
								"items":[
									{"name":"item1", "quantity":3, "vat":20.0},
									{"name":"item2", "quantity":2, "vat":20.0},
									{"name":"item3", "quantity":1, "vat":10.0}
								]
							}'
							```
					  ##### How it works...
					  	 - One of the most used APIs in ElasticSearch is the index. Basically, indexing a JSON document consists of these steps:
						  - Routing the call to the correct shard based on the ID or routing/parent metadata.
						  	If the ID is not supplied by the client, a new one is created.
						  - Validating the JSON which has been sent.
						  - Processing the JSON according to the mapping. If new fields are present in the
							document (the mapping can be updated), new fields are added in the mapping.
						  - Indexing the document in the shard. If the ID already exists, it is then updated.
						  - If it contains nested documents, it extracts them and processes them separately.
						  - Returns information about the saved document (ID and versioning).
						  
						  ###### There's more...
						  - ElasticSearch allows the passing of several query parameters in the index API URL for
							controlling how the document is indexed.
						  - routing : This controls the shard to be used for indexing, for example:
							curl -XPOST 'http://localhost:9200/myindex/order?routing=1'
						  - parent : This defines the parent of a child document and uses this value to apply routing. 
						  	The parent object must be specified in the mappings, such as:
							curl -XPOST 'http://localhost:9200/myindex/order?parent=12'
							
				
				#### Getting a document
				
					- The GET REST call allows us to get a document in real time without the need of a refresh.
					
					###### How to do it...
					- The GET method allows us to return a document given its index, type and ID.
					- The REST API URL is:
						http://<server>/<index_name>/<type_name>/<id>
					- If we consider the document we indexed in the previous recipe, the call will be:
						curl –XGET 'http://localhost:9200/myindex/order/2qLrAfPVQvCRMe7Ku8r0Tw?pretty=true'
					- The result returned by ElasticSearch should be the indexed document:
						
						```
						{
							"_index":"myindex",
							"_type":"order",
							"_id":"2qLrAfPVQvCRMe7Ku8r0Tw",
							"_version":1,
							"found":true,
							"_source": {
								"id" : "1234",
								"date" : "2013-06-07T12:14:54",
								"customer_id" : "customer1",
								"sent" : true,
								"items":[
									{"name":"item1", "quantity":3, "vat":20.0},
									{"name":"item2", "quantity":2, "vat":20.0},
									{"name":"item3", "quantity":1, "vat":10.0}
								]
							}
						}

						```
				- Our indexed data is contained in the _source parameter, but other information is returned as well:		
					- _index : This is the index that stores the document
					- _type : This denotes the type of the document
					- _id : This denotes the ID of the document
					- _version : This denotes the version of the document
					- found : This denotes if the document has been found
					
				- There are several additional parameters that can be used to control the GET call:		
					- fields : This allows us to retrieve only a subset of fields. This is very useful to reduce bandwidth or 
					  to retrieve calculated fields such as the attachment mapping ones:
					curl 'http://localhost:9200/myindex/order/2qLrAfPVQvCRMe7Ku8r0Tw?fields=date,sent'			
					
					
			#### Deleting a document
				- Deleting documents in ElasticSearch is possible in two ways: by using the DELETE call or the DELETE BY QUERY call;
				
				##### How to do it...
				- The REST API URL is the same as the GET calls, but the HTTP method is DELETE:
					http://<server>/<index_name>/<type_name>/<id>
					
				- If we consider the order index in the Indexing a document recipe, the call to delete a document will be:
					curl -XDELETE'http://localhost:9200/myindex/order/2qLrAfPVQvCRMe7Ku8r0Tw'	
					
			#### Updating a document
				- There are two available solutions to perform this operation in ElasticSearch, namely by adding the
					new document, or by using the update call.
				- The update call works in two ways:
					1.	 By providing a script (based on supported ElasticSearch scripting languages) which
					contains the code that must be executed to update the record
					2.	 By providing a document that must be merged with the original one
				
				##### How to do it...
					- As we are changing the state of the data, the HTTP method is POST and the REST URL is:
						http://<server>/<index_name>/<type_name>/<id>/_update
					- If we consider the type order of the previous recipe, the call to update a document will be
						```
						curl -XPOST 'http://localhost:9200/myindex/order/2qLrAfPVQvCRMe7Ku8r0Tw/_update' –d '{
							"script" : "ctx._source.in_stock_items += count",
							"params" : {
								"count" : 4
							}
						}'
						```
					- It's possible to pass parameters to a script by passing a JSON object.
					- A script can control the ElasticSearch behavior after the script execution by setting the ctx.op value of the context.
						- ctx.op="delete" : Using this, the document will be deleted after the script execution.
						- ctx.op="none" : Using this, the document will skip the indexing process.A good practice to improve performance 
						  is to set the ctx.op="none" to prevent reindexing overhead if the script doesn't update the document.

						- It's also possible to pass an additional object in the upsert property to be used if the document 
							is not available in the index :
							```
						    curl -XPOST 'http://localhost:9200/myindex/order/2qLrAfPVQvCRMe7Ku8r0Tw/_update' –d '{
							"script" : "ctx._source.in_stock_items += count",
							"params" : {
								"count" : 4
							},
							"upsert" : {"in_stock_items":4}
							}'
							```
						- If you need to replace some field values, a good solution is to not write a complex update script, but to use the 
						   special property doc , which allows to overwrite the values of an object. The document provided in the doc parameter 
						   will be merged with the original one. This approach is more easy to use, but it cannot set the ctx.op. So, if the update
							doesn't change the value of the original document, the next successive phase will always be executed:
							```
							curl -XPOST 'http://localhost:9200/myindex/order/2qLrAfPVQvCRMe7Ku8r0Tw/_update' –d '{"doc" : {"in_stock_items":10}}'
							```
						- If the original document is missing, it is possible to use the provided doc for an upsert by providing the doc_as_upsert parameter:
							```
							curl -XPOST 'http://localhost:9200/myindex/order/2qLrAfPVQvCRMe7Ku8r0Tw/_update' –d '{
							"doc" : {
								"in_stock_items":10
								},
								"doc_as_upsert":true
							}'

						- Using MVEL, it is possible to apply advanced operations on field, such as:
							- Removing a field:
								"script" : {"ctx._source.remove("myfield"}}
							- Adding a new field:
								"script" : {"ctx._source.myfield=myvalue"}}
			
			
		### Chapter 5 
				Search, Queries, and Filters
				
				
			- ElasticSearch allows you to use a rich domain specific language (DSL)
			
			##### How to do it...
			- From the command line, execute a search, as follows:
				curl -XGET 'http://127.0.0.1:9200/test-index/test-type/_search' -d '{"query":{"match_all":{}}}'
				- In this case, we have used a match_all query which means that all the document are returned.
				- The command, if everything is all right, will return the following result:
					```
					{
					"took" : 0,
					"timed_out" : false,
					"_shards" : {
						"total" : 5,
						"successful" : 5,
						"failed" : 0
					},
					"hits" : {
						"total" : 3,
						"max_score" : 1.0,
						"hits" : [ {
							"_index" : "test-index",
							"_type" : "test-type",
							"_id" : "1",
							"_score" : 1.0,
							"_source" : {
								"position": 1,
								"parsedtext": "Joe Testere nice guy", "name": "Joe Tester",
								"uuid": "11111"
							}
						}, 
						{
							"_index" : "test-index",
							"_type" : "test-type",
							"_id" : "2",
							"_score" : 1.0,
							"_source" : {
								"position": 2,
								"parsedtext": "Bill Testere nice guy", 
								"name": "BillBaloney", 
								"uuid": "22222"
							}
						}, 
						{
							"_index" : "test-index",
							"_type" : "test-type",
							"_id" : "3",
							"_score" : 1.0, 
							"_source" : {
								"position": 3,
								"parsedtext":"Bill is not nice guy", 
								"name": "Bill Clinton",
								"uuid": "33333"
						}
						}]
					}
					}
					```
				- The result contains a lot of information, as follows:
					- took : This is the time, in milliseconds, required to execute the query.
					- time_out : This indicates whether a timeout has occurred during the search. This is related to the timeout parameter 
						of the search. If a timeout occurred, you will get partial or no results.
					- _shards : This is the status of the shards, which can be divided into the following:
						- total : This is the total number of shards.
						- successful : This is the number of shards in which the query was successful.
						- failed : This is the number of shards in which the query failed, because some error or exception occurred during the query.
					- hits : This represents the results and is composed of the following:
						- total : This is the total number of documents that match the query.
						- max_score : This is the match score of the first document. 
							Usually this is 1 if no match scoring was computed, for example in sorting or filtering.
						- hits : This is a list of the result documents.
					- The result document has a lot of fields that are always available and other fields that depend
						on the search parameters. The following are the most important fields:
						- _index : This is the index that contains the document.
						- _type : This is the type of the document.
						- _id : This is the ID of the document.
						- _source : This is the document's source
						- _score : This is the query score of the document.
						- sort : These are the values that are used to sort, if the documents are sorted.
					
				#### How it works...
					- The HTTP method used to execute a search is GET (but POST works too), and the REST URL is:
						- http://<server>/_search
						- http://<server>/<index_name(s)>/_search
						- http://<server>/<index_name(s)>/<type_name(s)>/_search
					- The core query is usually contained in the body of the GET/POST call, but a lot of options can
						also be expressed as URI query parameters, as follows:
					- q : This is the query string used to perform simple string queries:
						curl -XGET 'http://127.0.0.1:9200/test-index/test-type/_search?q=uuid:11111'
					- df : This is the default field to be used within the query:
						curl -XGET 'http://127.0.0.1:9200/test-index/test-type/_search?df=uuid&q=11111'
					- from (by default, 0 ): This is the start index of the hits.
					- size (by default, 10 ): This is the number of hits to be returned.
					- analyzer : This is the default analyzer to be used.
					- default_operator (default, OR ): This can be set to AND or OR .
					- fields : This allows you to define fields that must be returned:
						curl -XGET 'http://127.0.0.1:9200/test-index/test-type/_search?q=parsedtext:joe&fields=name'
					- sort (by default, score ): This allows you to change the order of the documents.
						Sort is ascendant by default; if you need to change the order, add desc to the field:
						curl -XGET 'http://127.0.0.1:9200/test-index/test-type/_search?sort=name:desc'
					- pretty (by default, false ): If this is true , the results will be pretty printed.
					
				- Generally, the query is contained in the body of the search, a JSON object.
					- query : This contains the query to be executed.
					- from (by default, 0 ) and size (by default, 10 ): These allow you to control pagination.
						from defines the start position of the hits to be returned.
					- sort : This allows you to change the order of the matched documents. This option is
							fully covered in the next recipe, Sorting a result.
					- post_filter (optional): This allows you to filter out the query results without affecting
						the facet count. It's usually used to filter by facets values.
					- _source (optional): This allows you to control the returned source. It can be
						disabled ( false ), partially returned ( obj.* ), or multiple exclude/include rules.
					- fielddata_fields (optional): This allows you to return the field data representation of your field.
					- fields (optional): This controls the fields to be returned.

NOTE : Two main concepts are important in a search: query and filter.
		1) A query means that the matched results are scored using an internal Lucene-scoring algorithm; 
		2) In a filter, the results are only matched, without scoring.Because a filter doesn't need to
			compute the score, it is generally faster and can be cached.


		### Sorting results
			- When searching for results, the most common criteria for sorting in ElasticSearch is the relevance to a text query.
			
			#### How to do it...
			In order to sort the results, perform the following steps:
				1. Add a sort section to your query, as follows:
					``` 
						curl -XGET 'http://127.0.0.1:9200/test-index/test-type/_search?pretty=true' -d '{	
							"query" :{ "match_all":{} },
							"sort" : [
								{"price" : { "order" : "asc" ,"mode": "avg", "ignore_unmapped":true,"missing":"_last" }},
								"_score"
								]									
							}'
					```
			### How it works...
				- The sort parameter can be defined as a list that can contain both simple strings and JSON objects.
					- The sort string is the name of the field that is used to sort, similar to SQL's order by statement.
					- The JSON object allows you to use the following extra parameters:
						- order ( asc / desc ): This defines whether the order must be considered in the
							ascending format (which is the default) or the descending format.
						- ignore_unmapped ( true / false ): This allows you to ignore the fields that do
						   not have mappings in them. This option prevents errors during a search due to
							missing mappings.
						- unmapped_type : This defines the type of the sort parameter, if it is missing.
						- missing ( _last / _first ): This defines how to manage a missing value: we can
						  put them at the end ( _last ) of the results or at the start ( _first ).
						- mode : This defines how to manage multiple value fields. The following are the possible values:
							- min : This is the minimum value that is chosen (in the case of multiple prices
									for an item, it chooses the lower value to be used for the comparison).
							- max : This is the maximum value that is chosen.
							- sum : Using this, the sort value will be computed as the sum of all the values.
									This mode is only available on numeric fields.
							- avg : This sets the sort value, with which the sort result will be an average of
									all the values. This mode is only available on numeric fields.
				
					- If we want to use sorting for a nested object, there are two extra parameters that can be used:
						 - nested_path : This defines the nested object to be used for sorting. The field
							defined for sorting will be related to the nested_path parameter. If it is not
							defined, the sorting field will be related to the document root.
						-  For example,
							if we have an address object nested in a person document, we can sort
							for the city.name values and use:
							- address.city.name : This is used if you want to sort without defining the nested_path .
							- city.name : Using this defines a nested_path address .
						- nested_filter : This defines a filter that can be used to remove non-matching
									nested documents from the sorting value extraction. This filter allows a better
									selection of values to be used for sorting.
						
				
				
				
				
				
				
				
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
							
							
							
							
							
							
							
							
							
							
							
							


















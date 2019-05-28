## What is Apache NiFi?

1) NiFi was built to automate the flow of data between systems.
2) the term 'dataflow' means the automated and managed flow of information between systems.

### Some of the high-level challenges of dataflow include:
- Systems fail
    - Networks fail, disks fail, software crashes, people make mistakes.
- Data access exceeds capacity to consume
    - Sometimes a given data source can outpace some part of the processing or delivery chain - it only takes one weak-link to have an issue.
- Boundary conditions are mere suggestions
    - You will invariably get data that is too big, too small, too fast, too slow, corrupt, wrong, or in the wrong format.
- Systems evolve at different rates
    - The protocols and formats used by a given system can change anytime and often irrespective of the systems around them. Dataflow exists to connect what is essentially a massively distributed system of components that are loosely or not-at-all designed to work together.

### The core concepts of NiFi
- NiFi’s fundamental design concepts closely relate to the main ideas of Flow Based Programming [fbp]. Here are some of the main NiFi concepts and how they      map to FBP:
    - FlowFile                  --->            Information packet 
    - FlowFile Processor        --->            Black Box
    - Connection                --->            Bounded Buffer
    - Flow Controller           --->            Scheduler
    - Process Group             --->            Subnet

### Terminology Used
- FlowFile: Each piece of "User Data" (i.e., data that the user brings into NiFi for processing and distribution) is referred to as a FlowFile. A FlowFile is              made up of two parts: Attributes and Content. The Content is the User Data itself. Attributes are key-value pairs that are associated with the                 User Data.
- FlowFile = (Attributes + User data)
- Processor: The Processor is the NiFi component that is responsible for creating, sending, receiving, transforming, routing, splitting, merging, and                        processing FlowFiles. It is the most important building block available to NiFi users to build their dataflows.

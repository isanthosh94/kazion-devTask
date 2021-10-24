# kazion-devTask

•	Implemented using a Simple Trigger Handler by which we can disable the trigger during certain times (like data migration)
•	Callouts has been made in Batch Class, the reasons for preferring batch class over future methods are
o	During bulk data loads , when loading 200 different transaction records , would be making 400 callouts to the external system. Since during an transaction only 100 callouts can be made , the process has been coverted into batch class which will convert and run it in 4 batches
o	The Batch class accepts input parameter as set of Id’s , so if we want to call out the integration for certain records , we can pass the Id of only those
•	Used TestDataFactory class which will be used to create the Transaction and Transaction Item records at ease
•	The callouts has been made to an salesforce system , the system has been authenticated by named credential 
![image](https://user-images.githubusercontent.com/24619238/138591020-874c6556-30a4-4fc0-9a4d-1bda79584d8e.png)

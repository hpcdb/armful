# Query Interface (QI)

Query Interface is the DfAnalyzer component responsible to get user input, which characterizes and specifies the parameters and properties of the desired data, and then crafts a query responsible to retrieve the necessary datasets, data transformations and data attributes from the database.

Thus, QI generates a SQL-based query according to a specification, where:

* The SELECT clause is populated according to the user-specified projections, representing the data attributes chosen by the user;
* The WHERE clause, which is the most important one from the viewpoint of
  provenance tracing, acts like a filter by selecting and limiting the query to
  retrieve only the data elements (from datasets) that met a set of specified criteria
  (conditions);
* and, finally, the FROM clause contains the datasets from where the data attributes
  specified in the SELECT clause and the conditions specified in the WHERE
  clause are part of.

Query Interface key function is called <tt>generateSqlQuery</tt>, which
requires the following input arguments that need to be informed by
the users:

* D: the dataflow to be analyzed (it includes dataflow tag and identifier)
* dsOrigins: the datasets to be used as sources for the path finding algorithm;
* dsDestinations: the datasets to be used as destinations (ends) for the path
  finding algorithm;
* type: the attribute mapping type, which can be either logical (based on domain-specific attributes), physical (based on the identifiers of data transformations) or
  hybrid;
* projections: data attributes chosen to be part of the SELECT clause;
* selections: set of conditions intended to potentially filter and limit the
  query results, being part of the WHERE clause;
* dsIncludes: datasets that must be present in the paths found by the path
  finding algorithm;
* dsExcludes: datasets that must not be present in the paths found by the path
  finding algorithm.

By calling <tt>generateSqlQuery</tt> with the desired arguments, the user is
capable of generating and running a SQL code using QI.

Using the RESTful API of DfAnalyzer, users can submit HTTP requests with the POST method to run queries in DfAnalyzer's database. So, these requests have to use the URL `http://localhost:22000/query_interface/{dataflow_tag}/{dataflow_id}` and to add a message, which should contain the query specification as follows:

**Table**: query specification using QI.

Concept | Method (body of the HTTP request) | Additional information
--- | --- | ---
Mapping | mapping(type) | type = PHYSICAL, LOGICAL, HYBRID
Source datasets | source(datasetTags)
Target datasets | target(datasetTags)
Includes | include(datasetTags) | Datasets to be included in the fragment of dataflow path.
Excludes | exclude(datasetTags) | Datasets to be excluded from the fragment of dataflow path.
Projections | projection(attributes) | *attributes* argument defines which attributes will be obtained after query processing, e.g., attributes = {table1.att1;table2.att2}
Selections | selection(conditions) | *conditions* is used to filter only relevant data elements, *e.g.*, table1.att1 > 100

## Example

Considering our [Spark application](https://hpcdb.github.io/armful/applications.html) instrumented to extract provenance and scientific data using DfAnalyzer, users might like to investigate the data element flow from the input dataset icloth_item to the output dataset oaggregation, when the probability of a customer to buy a cloth item is less than 0.50. More specifically, they want to know which cloth items are in this situation and how many of them will be sold. The figure below presents the dataflow fragment analyzed by this query.

![Dataflow representation of our Spark application](../../../img/dfview-zoom.png)

Based on this dataflow analysis, an HTTP request has to be submitted to our RESTful API with the following URL and message (*i.e.*, HTTP body).

URL:
```
http://localhost:22000/query_interface/clothing/2
``` 

Message:

```
mapping(logical)
source(icloth_item)
target(oaggregation)
projection(icloth_item.clothid;icloth_item.description;
			oprediction.probability;oaggregation.quantity)
selection(oprediction.probability < 0.50)
```

As a result, our RESTful API returns a CSV-format file with the following content after the query processing:

clothid | description | probability | quantity
 --- | --- |  --- | ---  
3 | clothing-3 | 0.45 | 1200
4 | clothing-4 | 0.2 | 1161
8 | clothing-8 | 0.45 | 1242
4 | clothing-4 | 0.4 | 1161
4 | clothing-4 | 0.45 | 1161
8 | clothing-8 | 0 | 1242
1 | clothing-1 | 0.45 | 1606
2 | clothing-2 | 0.45 | 1756

# Query Processor (QP)

Query Processor is the DfAnalyzer component responsible to get user input, which
characterizes and specifies the parameters and properties of the desired data,
and then crafts a query responsible to retrieve the necessary datasets, data
transformations and data attributes from the database.

The generated query is provided as SQL-based code, where:

* The SELECT clause is populated according to the user-specified projections,
  representing the data attributes chosen by the user;
* The WHERE clause, which is the most important one from the viewpoint of
  provenance tracing, acts like a filter by selecting and limiting the query to
  retrieve only the database rows that met a set of specified criteria
  (conditions);
* and, finally, the FROM clause contains the datasets from where the data attributes
  specified in the SELECT clause and the conditions specified in the WHERE
  clause are part of.

Query Processor's key function is called <tt>generateSqlQuery</tt>, which
contains the following arguments:

* D: the dataflow to be analyzed
* dsOrigins: the datasets to be used as sources for the path finding algorithm;
* dsDestinations: the datasets to be used as destinations (ends) for the path
  finding algorithm;
* type: the attribute mapping type, which can be either logical, physical or
  hybrid;
* projections: data attributes chosen to be part of the SELECT clause;
* selections: set of conditions intended to potentially filter and limit the
  query results, being part of the WHERE clause;
* dsIncludes: datasets that must be present in the paths found by the path
  finding algorithm;
* dsExcludes: datasets that must not be present in the paths found by the path
  finding algorithm.

By calling <tt>generateSqlQuery</tt> with the desired arguments, the user is
capable of generating a SQL code in a hassle-free manner.

## Example

Argument | Value
--- | ---
D | D
dsOrigins | {osolversimulationflow}
dsDestinations | {ovisualization, omeshwriter}
type | physical
projections | {osolversimulationflow.time, osolversimulationflow.flow_final_linear_residual, osolversimulationflow.flow_norm_delta_u, osolversimulationtransport.transport_final_linear_residual, osolversimulationtransport.transport_norm_delta_u, ovisualization.png, omeshwriter.xdmf}
selections | {osolversimulationflow.time > 2, osolversimulationflow.time < 10, osolversimulationflow.r = 1}
dsIncludes | null
dsExcludes | null




<!-- vim: tw=80 -->

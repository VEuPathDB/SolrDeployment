# Solr Configuration for Site Search
This folder contains the files needed to configure a Solr core for the VEuPathDB Site Search application.

A number of the files are boilerplate: either standard from solr or empty.

The main way we configure solr is through `solrconfig.xml` and the schema.  

## `solrconfig.xml`
We use the standard `solrconfig.xml` provided by solr.  The few places where we have changed the configuration are marked with `VEuPathDB` in the comment.  It is likely much could be pruned out of this file, if somebody gets ambitious.

We have `autocommit` set to every 15 seconds.  Solr does not have transactions so any application that commits or rolls back is potentially impacting another application.  Therefore all applications must assume that their work is constantly being committed (by autocommit or another application).  Our autocommit configuration does not "open the searcher" which means that, while the commit is written to disk, it is not immediately visible to searches (for performance reasons).  Only a "hard" commit by an application opens the searcher.  All applications that write to solr should do a hard commit on exit, forcing the open searcher.  If an application has an error, and has written bad data to solr, it must delete that data.  Rollback will be ineffective, because of autocommit

We have set our schema to "not managed."  This means that the schema is controlled by `schema.xml`, rather than dynamically managed through the solr admin interface.

## `schema.xml` and friends
We started with the standard `schema.xml` file provided by solr and pruned away _all_ definitions we are not using, or that solr fails without.  There are plenty of definitions remaining that are not referenced by VEuPathDB's custom schema (see below).  These seem to be needed by built-in solr functions.  

The `schema_custom_fields.xml` file contains all the VEuPathDB custom fields.  It is thoroughly documented.

The `schema_custom_types.xml` and `enumsConfig.xml` files contain the definition of the VEuPathDB custom types.  They are documented.

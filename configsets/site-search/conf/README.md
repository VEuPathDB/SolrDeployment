# Solr Configuration for Site Search
This folder contains the files needed to configure a Solr core for the VEuPathDB Site Search application.

A number of the files are boilerplate: either standard from solr or empty.

The main way we configure solr is through `solrconfig.xml` and the schema.  

## `solrconfig.xml`
For `solrconfig.xml` we use the standard provided by solr.  The few places where we have changed the configuration are marked with `VEuPathDB` in the comment.

We have `autocommit` set to every 15 seconds.  Solr does not have transactions so any application that commits or rolls back is potentially impacting another application.  Therefore all applications must assume that their work is constantly being committed (by autocommit or another application).  Our autocommit configuration does not "open searches" which means that, while the commit is written to disk, it is not immediately visible to searches (for performance reasons).  Only a "hard" commit by an application opens searches.  Therefore all applications that write to solr should do a hard commit on exit.  If an application has an error, and has written bad data to solr, it must delete that data.  Rollback will be ineffective, because of autocommit

We have set our schema to "not managed."  This means that the schema is controlled by `schema.xml`, rather than dynamically managed through the solr admin interface.


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

The most important concepts in the schema are that:
* all documents have a *type*.  The schema enforces that only known types can be loaded.
* all documents are loaded as part of a *batch*.  A batch has a *type*, a *name* and a *timestamp* that, taken together, uniquely identifies the batch.  These fields are required in all documents, ensuring that the batch provenance of all documents is known.  (The loading system ensures that only a single batch of a given type and name (e.g. `organism` `pfal3D7`) can be loaded into the system.)  In addition to the data documents loaded in a batch, a meta-document describing the batch is loaded.  This is done at the end of batch loading, serving as a flag that the batch has loaded completely and successfully.
* only two types of fields are searched against the end-user's input.  These fields are defined "dynamically", meaning they contain wildcards: `TEXT__*` and `MULTITEXT__*`.  We use dynamic field definitions because the names of the fields are determined by external systems (e.g., the WDK).  We do not know their names at schema definition time.
* we do _not_ support a default field definition.  This means that all fields in solr must conform to our precise schema.

## Other files
* `lang/`  - a directory of language specific stuff.  We don't use it.  Can probably be removed.
* `managed-schema` - for use by managed schema, which we don't use.  Can probably be removed.
* `params.json` - seems to set defaults for solr queries.  Our Site Search Service never uses defaults.  Probably needed.
* `protwords.txt` - words to protect from stemming, which we don't use.  Can be removed once we remove text_en_splitting from schema.xml
* `stopwords.txt` - words to ignore when querying.  Currently empty.  Because we are a scientific database, we figured we don't need stop words. 
* `synonyms.txt` - synonyms to use when querying.  Not really used.  Might be useful eventually

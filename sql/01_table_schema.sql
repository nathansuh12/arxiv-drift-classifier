-- Reference schema for the raw table.
-- The load script (src/ingest/load_to_bigquery.py) creates this automatically;
-- this file documents the shape and lets you create it by hand if you prefer.
--
-- Run in the BigQuery console (replace YOUR_PROJECT_ID).

CREATE SCHEMA IF NOT EXISTS `YOUR_PROJECT_ID.arxiv`
OPTIONS (location = 'US');

CREATE TABLE IF NOT EXISTS `YOUR_PROJECT_ID.arxiv.papers_raw` (
  id                STRING,    -- arXiv id
  title             STRING,
  abstract          STRING,
  primary_category  STRING,    -- e.g. cs.LG  (the label)
  categories        STRING,    -- full space-separated category list
  update_date       DATE       -- used for the temporal split
);

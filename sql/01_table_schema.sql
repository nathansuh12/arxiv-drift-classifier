-- Reference schema for the raw table.
CREATE OR REPLACE TABLE `arxiv-abstract-classifier.arxiv.papers_cs` AS
SELECT
  id,
  title,
  abstract,
  categories,
  SPLIT(categories, ' ')[OFFSET(0)] AS primary_category,
  update_date
FROM `arxiv-abstract-classifier.arxiv.papers_raw`
WHERE categories LIKE '%cs.%'

-- Updated with only the top 5 categories
CREATE OR REPLACE TABLE `arxiv-abstract-classifier.arxiv.papers_cs` AS
SELECT
  id,
  title,
  abstract,
  categories,
  SPLIT(categories, ' ')[OFFSET(0)] AS primary_category,
  update_date
FROM `arxiv-abstract-classifier.arxiv.papers_raw`
WHERE SPLIT(categories, ' ')[OFFSET(0)] IN ('cs.CV', 'cs.LG', 'cs.CL', 'cs.AI', 'cs.RO');

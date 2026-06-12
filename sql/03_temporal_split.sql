-- Create the train (2015-2018) and serve (2023-2025) views.
-- These are what the TFDV drift script and the trainer read from.
-- Replace YOUR_PROJECT_ID.

CREATE OR REPLACE VIEW `arxiv-abstract-classifier.arxiv.papers_train` AS
SELECT id, title, abstract, primary_category, update_date
FROM `arxiv-abstract-classifier.arxiv.papers_cs`
WHERE update_date BETWEEN '2015-01-01' AND '2018-12-31'
  AND abstract IS NOT NULL
  AND LENGTH(abstract) > 50;

CREATE OR REPLACE VIEW `arxiv-abstract-classifier.arxiv.papers_serve` AS
SELECT id, title, abstract, primary_category, update_date
FROM `arxiv-abstract-classifier.arxiv.papers_cs`
WHERE update_date BETWEEN '2023-01-01' AND '2025-12-31'
  AND abstract IS NOT NULL
  AND LENGTH(abstract) > 50;

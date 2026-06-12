-- Exploratory analysis. Run each block in the BigQuery console.

-- 1) Class balance per year. This is where the drift is visible at the data level:
--    watch the cs.LG / cs.CL share climb in the later years.
SELECT
  EXTRACT(YEAR FROM update_date) AS year,
  primary_category,
  COUNT(*) AS n
FROM `arxiv-abstract-classifier.arxiv.papers_cs`
GROUP BY year, primary_category
ORDER BY year, n DESC;

-- 2) Overall class balance (sanity check for imbalance before training).
SELECT
  primary_category,
  COUNT(*) AS n,
  ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct
FROM `arxiv-abstract-classifier.arxiv.papers_cs`
GROUP BY primary_category
ORDER BY n DESC;

-- 3) Abstract length distribution (informs output_sequence_length in config).
SELECT
  APPROX_QUANTILES(ARRAY_LENGTH(SPLIT(abstract, ' ')), 100) AS word_count_percentiles
FROM `arxiv-abstract-classifier.arxiv.papers_raw`;

-- 4) Row counts in each temporal slice (confirm both windows have enough data).
SELECT
  CASE
    WHEN update_date BETWEEN '2015-01-01' AND '2018-12-31' THEN 'train'
    WHEN update_date BETWEEN '2023-01-01' AND '2025-12-31' THEN 'serve'
    ELSE 'other'
  END AS slice,
  COUNT(*) AS n
FROM `arxiv-abstract-classifier.arxiv.papers_raw`
GROUP BY slice;

# arXiv Drift Classifier

NLP classifier for arXiv CS abstracts (`cs.LG` / `cs.CL` / `cs.CV` / ...), built on GCP to
demonstrate **real temporal drift**. Train on 2015–2018 abstracts, serve on 2023–2025 —
CS vocabulary ("transformer", "llm", "diffusion", "rag") moved hard in that window, so the
drift is genuinely in the data, not injected.

## Approach

Prove the drift exists before building anything around it. The drift report is the point;
the classifier is almost incidental. Get to "TFDV shows 2023 abstracts drifted from 2018"
first — if it doesn't show up, fix the data split before automating anything downstream.

## Steps

1. **Data → BigQuery** (console) — download the arXiv snapshot (Kaggle: `Cornell-University/arxiv`),
   load via *Create table → from GCS*, filter to `cs.*`.
2. **Explore + split** (BigQuery SQL) — class balance per year, abstract lengths;
   create `train` (2015–2018) and `serve` (2023–2025) views. See `sql/`.
3. **Vertex AI Workbench notebook** (in-browser code) — pull both slices, run TFDV drift
   report, train a small classifier, save it. See `notebooks/`.
4. **Deploy + monitor** (console) — Model Registry → endpoint → Model Monitoring.
   Tear the endpoint down after demoing (it's what bills).
5. **(optional) Automate** — wrap 1–4 in a Vertex AI Pipeline so drift triggers a retrain.

Steps 1, 2, 4 are pure console. Step 3 is the only real code, and it runs in Workbench.

## Setup

```bash
pip install -r requirements.txt   # run inside the Workbench notebook
```

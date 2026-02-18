# BSEOA JSON / JSONL Output Schema

## Contents
- [Output modes and shape](#output-modes-and-shape)
- [Top-level page fields (full json/jsonl)](#top-level-page-fields-full-jsonjsonl)
- [The warnings array](#the-warnings-array)
- [jsonl-summary page record schema](#jsonl-summary-page-record-schema)
- [jsonl-summary aggregate record schema](#jsonl-summary-aggregate-record-schema)
- [Nested analyzer result fields](#nested-analyzer-result-fields)
- [Sub-schemas: link_analysis, web_vitals_metrics, AI analyzers](#sub-schemas)

## Output modes and shape

`--output-type` determines schema shape:

- `json`: full page objects in a JSON array (`Page[]`)
- `jsonl`: full page objects, one `Page` per line (JSON Lines)
- `jsonl-summary`: compact page objects, one per line, optionally prefixed with a site aggregate summary line when `--aggregate-warnings` is used

Output cleanup/filter flags:

- `--include-ngrams` (jsonl): include `ngrams_1/2/3`; otherwise stripped by default
- `--min-severity <low|medium|high|critical>`: filters warnings below threshold in JSONL/summary generation
- `--aggregate-warnings` (jsonl-summary): emits leading `site_summary` aggregate record

## Top-level page fields (full json/jsonl)

```
url                        string   — Crawled page URL
title                      string?  — <title> tag content
description                string?  — Meta description content
author                     string?  — Author meta tag
hostname                   string?  — Hostname from URL
sitename                   string?  — og:site_name
date                       string?  — Publication date
encoding                   string   — Page encoding (e.g. UTF-8)
redirected_to              string?  — URL this page redirected to

og_title                   string?  — OpenGraph title
og_description             string?  — OpenGraph description
og_image                   string?  — OpenGraph image URL
twitter_title              string?  — Twitter card title
twitter_description        string?  — Twitter card description
twitter_image              string?  — Twitter card image URL

total_word_count           number   — Total words on the page
headings                   object?  — Headings by level: {"H1": [...], "H2": [...]}
content_hash               string?  — Hash of page content (for duplicate detection)

internal_links             string[] — Internal link URLs found on the page
external_links             string[] — External link URLs found on the page

ttfb_millis                number?  — Time to First Byte in milliseconds
total_load_time_millis     number?  — Total page load time in milliseconds
web_vitals_score           number   — Overall Web Vitals score (0–100)
web_vitals_recommendations string[] — Recommendations from Web Vitals analysis

ssl_expiration_date        string?  — SSL certificate expiration date
ssl_issuer_name            string?  — SSL certificate issuer

stylesheets                string[] — Stylesheet URLs
scripts                    string[] — Script URLs
images                     string[] — Image URLs

ngrams_1                   object?  — Single-word keyword frequencies {word: count}
ngrams_2                   object?  — Two-word keyword frequencies {phrase: count}
ngrams_3                   object?  — Three-word keyword frequencies {phrase: count}

warnings                   Warning[] — Issues found on this page (see below)
```

## The warnings array

This is where all detected SEO problems live. Each warning:
```json
{
  "message": "string",   // Human-readable description of the issue
  "key":     "string?",  // Dot-notation category key, e.g. "content.too_short"
  "link":    "string?",  // Documentation URL for the issue
  "severity": "low|medium|high|critical" // Default: "medium" when missing in older records
}
```

**When summarizing results, always start with the `warnings` array for each page.**

## jsonl-summary page record schema

Each non-aggregate line in `--output-type jsonl-summary` uses this compact shape:

```json
{
  "url": "string",
  "status_code": 200,
  "warning_count": 12,
  "warnings": [
    {
      "message": "string",
      "key": "string?",
      "link": "string?",
      "severity": "low|medium|high|critical"
    }
  ],
  "ttfb_millis": 123,
  "web_vitals_score": 78,
  "redirected_to": "string|null"
}
```

Notes:
- `warnings` are filtered by `--min-severity` when provided.
- Severity is preserved for new records and derived from warning key for older records that lack `severity`.

## jsonl-summary aggregate record schema

When `--aggregate-warnings` is enabled with `jsonl-summary`, the first line is:

```json
{
  "_record_type": "site_summary",
  "total_pages": 250,
  "total_warnings": 1430,
  "aggregated_warnings": [
    {
      "key": "meta.missing_canonical",
      "count": 133,
      "severity": "high",
      "affected_urls": ["https://example.com/page-a", "https://example.com/page-b"]
    }
  ]
}
```

`aggregated_warnings` is sorted by `count` descending and respects `--min-severity` filtering.

## Nested analyzer result fields

```
css_analysis               object?  — CSS analysis
structured_data_analysis   object?  — JSON-LD / microdata / RDFa findings
javascript_analysis        object?  — Script loading, third-party domains
link_analysis              object?  — Detailed per-link data with anchor text
accessibility_analysis     object?  — Accessibility issues
anthropic_analysis         object?  — Claude AI recommendations
openai_analysis            object?  — OpenAI recommendations
deepseek_analysis          object?  — DeepSeek recommendations
gemini_analysis            object?  — Gemini recommendations
```

## Sub-schemas

### AI analyzer results (anthropic_analysis, openai_analysis, etc.)
```json
{
  "recommendations": ["string", "..."],
  "raw_response": "string"
}
```

### link_analysis (array of)
```json
{
  "url": "string",
  "anchor_text": "string",
  "is_internal": true,
  "is_file": false
}
```

### web_vitals_metrics (map of metric name → metric object)
```json
{
  "Largest Contentful Paint": {
    "name": "Largest Contentful Paint",
    "value": 1200,
    "rating": "Good | NeedsImprovement | Poor",
    "issues": []
  }
}
```

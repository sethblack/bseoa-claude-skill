# BSEOA JSON Output Schema

## Contents
- [Top-level page fields](#top-level-page-fields)
- [The warnings array](#the-warnings-array)
- [Nested analyzer result fields](#nested-analyzer-result-fields)
- [Sub-schemas: link_analysis, web_vitals_metrics, AI analyzers](#sub-schemas)

## Top-level page fields

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
  "link":    "string?"   // Documentation URL for the issue
}
```

**When summarizing results, always start with the `warnings` array for each page.**

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

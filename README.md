# Black SEO Analyzer — Claude Skill

A Claude Code skill (`/bseoa`) for working with [Black SEO Analyzer](https://github.com/sethblack/black-seo-analyzer), a Rust-based CLI tool for comprehensive technical SEO analysis.

## What This Skill Does

When you type `/bseoa` in Claude Code, Claude becomes an expert assistant for BSEOA. It will:

- Build correct commands for your specific analysis goal
- Run BSEOA and capture results
- Interpret crawl data and explain what issues mean
- Prioritize findings by SEO impact
- Suggest command flags for follow-up analysis

## Enabling the Skill in Claude

If you're using Claude (the web app) rather than Claude Code CLI, you can install this as a custom skill:

1. Navigate to **Settings > Capabilities**.
2. Ensure that **Code execution and file creation** is enabled.
3. Scroll to the **Skills** section.
4. Toggle individual skills on or off as needed.
5. To add this custom skill, click **"Upload skill"** and upload the ZIP file. The ZIP file for this skill is attached to the latest Release on GitHub.

After uploading, go to **Settings > Capabilities** and under **Additional allowed domains** add:

- `download.blackseoanalyzer.com`
- The domain(s) of the website(s) you plan to crawl, so Claude can access them.

## Installation

### Windows

```bat
install.bat
```

Or manually copy the `bseoa` directory to:
```
%USERPROFILE%\.claude\skills\bseoa\
```

### macOS / Linux

```bash
chmod +x install.sh && ./install.sh
```

Or manually:
```bash
cp -r bseoa ~/.claude/skills/bseoa
```

After installing, restart Claude Code (or open a new session) for the skill to appear.

## Usage

In any Claude Code session:

```
/bseoa
```

Then describe what you want to analyze. Examples:

```
/bseoa
Analyze https://example.com and give me a full SEO audit as JSON.
```

```
/bseoa
I want to find all broken links on my site at https://mysite.com
```

```
/bseoa
Run a quick audit on https://example.com using Claude AI for content suggestions
```

```
/bseoa
Re-generate a CSV report from the last crawl without re-crawling
```

## Requirements

- [Black SEO Analyzer](https://github.com/sethblack/black-seo-analyzer) installed and on your PATH
- Claude Code CLI installed
- (Optional) A BSEOA license key for unlimited page analysis
- (Optional) API keys for AI-powered analysis (Anthropic, OpenAI, DeepSeek, or Gemini)

## Skill File

The skill logic lives in `bseoa/SKILL.md`. Reference files are in `bseoa/reference/` and `bseoa/license.md`. Edit these to customize behavior, add site-specific defaults, or tune Claude's guidance for your workflow.

## Related

- [Black SEO Analyzer docs](https://github.com/sethblack/black-seo-analyzer)
- [Claude Code skills documentation](https://docs.anthropic.com/en/docs/claude-code)

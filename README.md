# Room for God & Others

A writing-focused static site for essays, poetry, journal notes, sayings, reflections, and favorite voices.

Live site: https://gregconradismith.github.io/room-for-god-and-others/

This repository is set up as a small Jekyll site, which GitHub Pages can build directly.

## Writing

- Essays live in `_essays/` as dated Markdown files.
- Poems live in `_poems/` as Markdown files.
- Reflections live in `_blurbs/` as Markdown files.
- Sayings live in `_aphorisms/` as Markdown files.
- Voices live in `_quotes/` as Markdown files.
- Shared pages live at the repository root, such as `about.md`, `essays.md`, `poetry.md`, `reflections.md`, `sayings.md`, and `voices.md`.
- `voice-of-the-day.md` selects a voice from `_quotes/` each time the site builds, and `/voices/feed.xml` exposes the voice archive as RSS.

Create a new essay with a file name like:

```text
_essays/2026-06-14-a-new-essay.md
```

Create a new poem with a file name like:

```text
_poems/a-new-poem.md
```

Each file starts with YAML front matter:

```yaml
---
layout: essay
title: "A New Essay"
date: 2026-06-14
category: essay
excerpt: "A short summary for listing pages."
---
```

For poems, use `layout: poem`. For sayings, use `layout: aphorism`. For voices, use `layout: quote`. For reflections, use `layout: blurb`.

Images are rendered from front matter when `image` is set. Use `image_alt` for accessible alt text, and optionally use `image_position` to adjust thumbnail cropping:

```yaml
image: /assets/images/quotes/a-new-voice.jpg
image_alt: "A concise description of the image."
image_position: "50% 35%"
```

## Build and Deploy

This repository is intended to build through GitHub Actions and GitHub Pages. Do not install or run Jekyll locally for this project; push Markdown changes and let the Pages workflow convert them to static HTML.

The Pages workflow also runs once a day so the static voice-of-the-day page refreshes. To enable privacy-respecting analytics, add the site domain to `analytics.plausible_domain` in `_config.yml` after creating the site in Plausible or a compatible self-hosted endpoint. The reader feedback buttons send a custom event only when that analytics hook is configured; otherwise they record a local acknowledgement in the visitor's browser.

## Codex Coordination

Codex session state is tracked in `.codex/handoff.md`; durable decisions and task history may also appear in `.codex/` when useful.

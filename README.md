# Room for God & Others

A writing-focused static site for essays, poetry, journal notes, sayings, thoughts, and favorite voices.

Live site: https://gregconradismith.github.io/room-for-god-and-others/

This repository is set up as a small Jekyll site, which GitHub Pages can build directly.

## Related Writing Locations

This public repository is the publication target for writing that has been
approved for open access.

- [Live public site](https://gregconradismith.github.io/room-for-god-and-others/)
  is built from this repository.
- [room-for-god-and-others-private](https://github.com/gregconradismith/room-for-god-and-others-private)
  is the private staging and preview repository for Markdown pieces that may
  later be copied or moved here.
- [writing](https://github.com/gregconradismith/writing) is the broader private
  creative-writing archive for drafts, works in development, submissions, and
  material that may never be public.
- Raw Evernote `.enex` exports are kept outside Git in a Dropbox-synced local
  folder and should not be committed here.

Only copy material from a private location into this public repository after
Greg has explicitly approved that material for publication.

## Writing

- Essays live in `_essays/` as dated Markdown files.
- Poems live in `_poems/` as Markdown files.
- Thoughts live in `_thoughts/` as Markdown files.
- Sayings live in `_sayings/` as Markdown files.
- Voices live in `_quotes/` as Markdown files.
- Shared pages live at the repository root, such as `about.md`, `essays.md`, `poetry.md`, `sayings.md`, `themes.md`, `thoughts.md`, and `voices.md`.
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
categories:
  - Essays
themes:
  - Jesus loves Darwin
  - Read against the machine
---
```

For poems, use `layout: poem`. For sayings, use `layout: saying`. For voices, use `layout: quote`. For thoughts, use `layout: thought`.
Use `categories` for the broad collection label shown by genre, and use
`themes` for one or more entries from `_data/writing_categories.yml`.
Voices must include an attribution, either in `source` front matter or as
a trailing Markdown line beginning with `--`.

Images are rendered from front matter when `image` is set. Use `image_alt` for accessible alt text, and optionally use `image_position` to adjust thumbnail cropping:

```yaml
image: /assets/images/quotes/a-new-voice.jpg
image_alt: "A concise description of the image."
image_position: "50% 35%"
```

## Build and Deploy

This repository is intended to build through GitHub Actions and GitHub Pages. Do not install or run Jekyll locally for this project; push Markdown changes and let the Pages workflow convert them to static HTML.

The Pages workflow also runs once a day so the static voice-of-the-day page refreshes. Privacy-respecting analytics are handled through GoatCounter; set `analytics.goatcounter_url` in `_config.yml` after creating the GoatCounter site.

## Codex Coordination

Codex session state is tracked in `.codex/handoff.md`; durable decisions and task history may also appear in `.codex/` when useful.

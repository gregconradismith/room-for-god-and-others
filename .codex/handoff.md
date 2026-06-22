# Codex Handoff

Date: 2026-06-22

Repo: `room-for-god-and-others`

Branch: `main`

Current Git status after the 2026-06-22 homepage hero image update:

```bash
## main...origin/main
Replaced `assets/images/reading-room.png` with a generated wide-format reading
room hero background. Run `git status --short` for the full file list.
```

## Repository Role

This is the public GitHub Pages repository for the Room for God & Others writing
site:

https://gregconradismith.github.io/room-for-god-and-others/

It contains public essays, poems, reflections, sayings, favorite voices, shared
pages, images, and small Ruby helper scripts for the Pages workflow.

## High-Value Context

- Read `AGENTS.md` before editing.
- This public repository was recreated with clean public history on 2026-06-18.
  Do not push from older local clones that may still contain pre-reset history.
- Three Greg Conradi Smith sayings were added or updated on 2026-06-20:
  `faith-is-not-credulity.md`,
  `god-is-not-honored-by-simplifying-truth.md`, and
  `writing-is-the-act-of-telling-the-truth.md`.
- Keep this repo public-safe. Do not copy private-only writing, private triage
  inventories, or sensitive material from the paired private repo into this
  public repo unless Greg explicitly asks.
- The trigger phrase `publish from private: move [filename or title] to the
  public site` means Greg has explicitly approved publishing the named item from
  the paired private repo. Keep public notes public-safe, run
  `ruby scripts/validate_content.rb`, then commit and push.
- Do not install or run Jekyll/Bundler locally for this repo.
- GitHub Actions builds and deploys the site from `main`.
- `scripts/update_goodreads.rb` refreshes Goodreads data during the workflow;
  `_data/goodreads.yml` is the committed fallback snapshot.
- `scripts/update_featured_writing.rb` randomizes the homepage writing list
  during the workflow; `_data/featured_writing.yml` is the committed fallback
  snapshot.
- On 2026-06-21, public labels and URLs were changed from
  Aphorisms/Blurbs/Quotations to Sayings/Reflections/Voices. The internal
  collection keys and existing asset folders remain `_aphorisms`, `_blurbs`,
  `_quotes`, `assets/images/quotes`, and `assets/images/blurbs`.
- The site includes a search and category filter browser. Browser result order
  is essays, poetry, sayings, reflections, voices.
- On 2026-06-21, the search browser moved from the homepage to `/search/`.
  `Search` and `Categories` now appear as matching green controls at the end of
  the main navigation. Category menu items link into `/search/?category=...`.
- Topic categories live in `_data/writing_categories.yml`; content items have
  multi-valued `categories:` front matter for filtering.
- `scripts/validate_content.rb` checks YAML front matter and image references.
- On 2026-06-22, the homepage hero background image at
  `assets/images/reading-room.png` was replaced with a generated literary
  reading-room illustration. `ruby scripts/validate_content.rb` passed after
  the asset replacement.

## Useful Commands

Check status:

```bash
git status --short --branch
```

Check whitespace in a scoped diff:

```bash
git diff --check
```

Validate public content references without building locally:

```bash
ruby scripts/validate_content.rb
```

## Migration Readiness Snapshot

- Checked on 2026-06-21 before moving computers.
- Non-interactive `git fetch --all --prune` completed successfully.
- Root `README.md` points to `.codex/handoff.md` when a root README exists.

Pre-edit Git state after fetch:

```bash
## main...origin/main
```

## Notes For The Next Codex

- Keep handoff notes public-safe and workflow-focused.
- Do not add private repo details or private-only writing lists.
- Do not add `vendor/bundle`, `.bundle/`, `Gemfile.lock`, `_site/`, or local
  Jekyll/Bundler artifacts.
- To validate deployment, push to `main` and inspect the GitHub Actions
  Pages/Jekyll workflow run.
- Do not run a local Jekyll build unless Greg explicitly asks; this repo is
  intended to build through GitHub Actions.
- After adding or updating `AGENTS.md` / `.codex/handoff.md`, commit the scoped
  change and push it to `main`.

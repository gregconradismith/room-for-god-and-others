# Codex Handoff

Date: 2026-06-20

Repo: `room-for-god-and-others`

Branch: `main`

Current Git status at handoff creation:

```bash
## main...origin/main
```

## Repository Role

This is the public GitHub Pages repository for the Room for God & Others writing
site:

https://gregconradismith.github.io/room-for-god-and-others/

It contains public essays, poems, blurbs, aphorisms, favorite quotations, shared
pages, images, and small Ruby helper scripts for the Pages workflow.

## High-Value Context

- Read `AGENTS.md` before editing.
- This public repository was recreated with clean public history on 2026-06-18.
  Do not push from older local clones that may still contain pre-reset history.
- Three Greg Conradi Smith aphorisms were added or updated on 2026-06-20:
  `faith-is-not-credulity.md`,
  `god-is-not-honored-by-simplifying-truth.md`, and
  `writing-is-the-act-of-telling-the-truth.md`.
- Keep this repo public-safe. Do not copy private-only writing, private triage
  inventories, or sensitive material from the paired private repo into this
  public repo unless Greg explicitly asks.
- Do not install or run Jekyll/Bundler locally for this repo.
- GitHub Actions builds and deploys the site from `main`.
- `scripts/update_goodreads.rb` refreshes Goodreads data during the workflow;
  `_data/goodreads.yml` is the committed fallback snapshot.
- `scripts/update_featured_writing.rb` randomizes the homepage writing list
  during the workflow; `_data/featured_writing.yml` is the committed fallback
  snapshot.
- `scripts/validate_content.rb` checks YAML front matter and image references.

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

## Notes For The Next Codex

- Keep handoff notes public-safe and workflow-focused.
- Do not add private repo details or private-only writing lists.
- Do not add `vendor/bundle`, `.bundle/`, `Gemfile.lock`, `_site/`, or local
  Jekyll/Bundler artifacts.
- To validate deployment, push to `main` and inspect the GitHub Actions
  Pages/Jekyll workflow run.
- After adding or updating `AGENTS.md` / `CODEX-HANDOFF.md`, commit the scoped
  change and push it to `main`.

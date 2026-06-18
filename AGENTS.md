# Repository Instructions for Codex

This site is built by GitHub Actions, not by installing or running Jekyll locally.

- This public repository was recreated with clean history on 2026-06-18. Do not push from older local clones that still contain pre-reset history.
- Do not add `CODX_HANDOFF.md` or other triage handoff notes to this public repository.
- Goodreads homepage data is refreshed during the GitHub Pages workflow by `scripts/update_goodreads.rb`; `_data/goodreads.yml` is the committed fallback snapshot.
- The homepage writing list is randomized during the GitHub Pages workflow by `scripts/update_featured_writing.rb`; `_data/featured_writing.yml` is the committed fallback snapshot.
- Do not run `bundle install`, install Jekyll gems, or create local Bundler artifacts in this repository.
- Do not add `vendor/bundle`, `.bundle/`, or `Gemfile.lock`.
- Markdown-to-HTML conversion should happen in GitHub Actions after pushing to GitHub Pages.
- To validate deployment, push to `main` and inspect the GitHub Actions Pages/Jekyll workflow run.

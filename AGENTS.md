# Repository Instructions for Codex

This site is built by GitHub Actions, not by installing or running Jekyll locally.

- This public repository was recreated with clean history on 2026-06-18. Do not push from older local clones that still contain pre-reset history.
- This repository is the public publication target. Private drafts, staging
  work, and public-site backup/version copies live in `../writing`; raw local
  exports may live outside Git in `~/Main/Personal/Writing`. The parent
  `~/Main/` folder is Dropbox-synced.
- Keep `.codex/handoff.md` public-safe. Do not add private triage details,
  private-only writing inventories, or private-repo content to this public
  repository.
- Within `../writing`, `room-for-god-and-others-staging/` is the private
  staging area for possible future public-site material, and
  `room-for-god-and-others-versions/` holds backup copies and
  alternate/different versions of public-site material.
- Do not copy private material or raw local export material into this public
  repository unless Greg explicitly approves that specific piece for
  publication.
- Do not add AI-generated written teaser copy, subtitles, summaries,
  descriptions, or `excerpt` front matter for published writing. AI-generated
  images are okay when properly attributed, but public-facing written previews
  should come from the work itself or be omitted.
- Every published collection item in `_essays`, `_poems`, `_sayings`,
  `_thoughts`, and `_quotes` should have `image`, `image_alt`, and
  `image_credit` front matter. `scripts/validate_content.rb` enforces this so
  randomized homepage previews never render without art.
- Greg's standing preference is that when mined or staged writing material is
  made "public" rather than merely "staged," each new public item should always
  receive a generated image unless he explicitly says otherwise, with required
  public-site image metadata and AI image attribution ledger updates.
- Goodreads homepage data is refreshed during the GitHub Pages workflow by `scripts/update_goodreads.rb`; `_data/goodreads.yml` is the committed fallback snapshot.
- Goodreads homepage data should show only recently read books, not a
  "Currently Reading" category.
- The homepage writing list is randomized during the GitHub Pages workflow by `scripts/update_featured_writing.rb`; `_data/featured_writing.yml` is the committed fallback snapshot.
- Homepage writing cards should use the collection-derived small-caps kind
  labels (`Essay`, `Poem`, `Saying`, `Thought`, `Quote`) and the existing theme
  categories. Do not add generated subtitle or teaser text to those cards.
- Do not restore the old homepage "Reading Paths" row or "Voice of the Day"
  section unless Greg explicitly asks for them.
- Do not run `bundle install`, install Jekyll gems, or create local Bundler artifacts in this repository.
- Do not add `vendor/bundle`, `.bundle/`, or `Gemfile.lock`.
- Markdown-to-HTML conversion should happen in GitHub Actions after pushing to GitHub Pages.
- To validate deployment, push to `main` and inspect the GitHub Actions Pages/Jekyll workflow run.

---
layout: default
title: Home
---

<section class="hero" aria-labelledby="home-title">
  <div class="hero-copy">
    <p class="eyebrow">The desire to understand will serve you well</p>
    <h1 id="home-title">Room for God &amp; Others</h1>
    <p>Creative writing: essays, poems, journal fragments, aphorisms, and quotations.</p>
  </div>
  <img class="hero-mark" src="{{ '/assets/images/g-symbol-bw.png' | relative_url }}" alt="" aria-hidden="true">
</section>

<section class="category-band" aria-label="Writing categories">
  <a class="category-panel" href="{{ '/essays/' | relative_url }}">
    <span>Essays</span>
    <strong>Longer meditations, talks, and open-journal arguments.</strong>
  </a>
  <a class="category-panel" href="{{ '/poetry/' | relative_url }}">
    <span>Poetry</span>
    <strong>Poems, fragments, prayers, and lyric experiments.</strong>
  </a>
  <a class="category-panel" href="{{ '/aphorisms/' | relative_url }}">
    <span>Aphorisms</span>
    <strong>Brief original sayings, fragments, and remembered formulations.</strong>
  </a>
  <a class="category-panel" href="{{ '/blurbs/' | relative_url }}">
    <span>Blurbs</span>
    <strong>Short passages, fragments, sketches, and unplaced notes.</strong>
  </a>
  <a class="category-panel" href="{{ '/quotes/' | relative_url }}">
    <span>Quotations</span>
    <strong>Gathered passages, remembered lines, and source notes.</strong>
  </a>
</section>

<section class="home-section" aria-labelledby="recent-title">
  <div class="section-heading">
    <p class="eyebrow">Recently added</p>
    <h2 id="recent-title">Writing</h2>
  </div>
  <div class="writing-list">
    {% assign latest_essays = site.essays | sort: "date" | reverse %}
    {% assign latest_poems = site.poems | sort: "date" | reverse %}
    {% assign latest_aphorisms = site.aphorisms | sort: "date" | reverse %}
    {% assign latest_quotes = site.quotes | sort: "date" | reverse %}
    {% assign latest_blurbs = site.blurbs | sort: "date" | reverse %}
    {% assign latest_items = latest_essays | concat: latest_poems | concat: latest_blurbs | concat: latest_aphorisms | concat: latest_quotes | sort: "date" | reverse %}
    {% for item in latest_items limit: 6 %}
      <article class="writing-item{% if item.image %} has-thumbnail{% endif %}">
        <div>
          <p class="item-type">{% if item.collection == "poems" %}Poem{% elsif item.collection == "aphorisms" %}Aphorism{% elsif item.collection == "quotes" %}Quotation{% elsif item.collection == "blurbs" %}Blurb{% elsif item.draft %}Draft Essay{% else %}Essay{% endif %}</p>
          <h3><a href="{{ item.url | relative_url }}">{{ item.title | escape }}</a></h3>
          {% if item.excerpt %}
            <p>{{ item.excerpt | strip_html | truncate: 170 | escape }}</p>
          {% endif %}
        </div>
        {% if item.date %}
          <time datetime="{{ item.date | date_to_xmlschema }}">{{ item.date | date: "%b %-d, %Y" }}</time>
        {% endif %}
        {% if item.image %}
          <a class="writing-thumbnail" href="{{ item.url | relative_url }}" aria-label="Open {{ item.title | escape }}" {% if item.image_position %}style="--image-position: {{ item.image_position | escape }};"{% endif %}>
            <img src="{{ item.image | relative_url }}" alt="{{ item.image_alt | default: item.title | escape }}">
          </a>
        {% endif %}
      </article>
    {% endfor %}
  </div>
</section>

<section class="home-section goodreads-section" aria-labelledby="goodreads-title">
  <div class="section-heading">
    <p class="eyebrow">Recent reading</p>
    <h2 id="goodreads-title">Goodreads</h2>
    <a class="section-link" href="{{ site.data.goodreads.profile_url }}">View profile</a>
  </div>
  <div class="goodreads-list">
    {% for book in site.data.goodreads.books %}
      <article class="goodreads-book">
        <a class="goodreads-cover" href="{{ book.url }}" aria-label="Open {{ book.title | escape }} on Goodreads">
          <img src="{{ book.image }}" alt="{{ book.title | escape }} cover">
        </a>
        <div>
          <p class="item-type">{{ book.status }}</p>
          <h3><a href="{{ book.url }}">{{ book.title | escape }}</a></h3>
          <p>{{ book.author | escape }}{% if book.rating %} · {{ book.rating }}{% endif %}</p>
        </div>
      </article>
    {% endfor %}
  </div>
</section>

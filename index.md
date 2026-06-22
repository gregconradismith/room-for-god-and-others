---
layout: default
title: Home
---

<section class="hero" aria-labelledby="home-title">
  <div class="hero-copy">
    <p class="eyebrow">The desire to understand will serve you well</p>
    <h1 id="home-title">Room for God &amp; Others</h1>
    <p>Creative writing: essays, poems, journal fragments, sayings, reflections, and voices.</p>
  </div>
  <img class="hero-mark" src="{{ '/assets/images/g-symbol-bw.png' | relative_url }}" alt="" aria-hidden="true">
</section>

<nav class="site-nav home-nav" aria-label="Writing categories">
  <a href="{{ '/about/' | relative_url }}">About</a>
  <a href="{{ '/essays/' | relative_url }}">Essays</a>
  <a href="{{ '/poetry/' | relative_url }}">Poetry</a>
  <a href="{{ '/sayings/' | relative_url }}">Sayings</a>
  <a href="{{ '/reflections/' | relative_url }}">Reflections</a>
  <a href="{{ '/voices/' | relative_url }}">Voices</a>
</nav>

{% include writing-browser.html %}

<section class="home-section daily-quote-section" aria-label="Voice of the day">
  {% include daily-quote.html compact=true heading="Voice of the day" %}
</section>

<section class="home-section writing-section" aria-label="Featured writing">
  <div class="writing-list">
    {% for item in site.data.featured_writing.items %}
      <article class="writing-item{% if item.image and item.image != "" %} has-thumbnail{% endif %}">
        <div>
          <p class="item-type">{{ item.type | escape }}</p>
          <h3><a href="{{ item.url | relative_url }}">{{ item.title | escape }}</a></h3>
          {% if item.excerpt and item.excerpt != "" %}
            <p>{{ item.excerpt | strip_html | truncate: 170 | escape }}</p>
          {% endif %}
        </div>
        {% if item.date and item.date != "" %}
          <time datetime="{{ item.date | date_to_xmlschema }}">{{ item.date | date: "%b %-d, %Y" }}</time>
        {% endif %}
        {% if item.image and item.image != "" %}
          <a class="writing-thumbnail" href="{{ item.url | relative_url }}" aria-label="Open {{ item.title | escape }}" {% if item.image_position and item.image_position != "" %}style="--image-position: {{ item.image_position | escape }};"{% endif %}>
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

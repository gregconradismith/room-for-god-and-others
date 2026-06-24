---
layout: default
title: Home
---

<section class="hero" aria-labelledby="home-title">
  <div class="hero-copy">
    <h1 id="home-title">Room for God &amp; Others</h1>
    <p class="eyebrow">Thoughts on science, faith, and pluralism</p>
    <p>Greg Conradi Smith</p>
  </div>
  <img class="hero-mark" src="{{ '/assets/images/g-symbol-bw.png' | relative_url }}" alt="" aria-hidden="true">
</section>

{% include site-nav.html extra_class="home-nav" %}

<section class="home-section daily-quote-section" aria-label="Voice of the day">
  {% include daily-quote.html compact=true heading="Voice of the day" %}
</section>

<section class="home-section writing-section" aria-label="Featured writing">
  <div class="writing-list">
    {% for item in site.data.featured_writing.items %}
      <article class="writing-item{% if item.image and item.image != "" %} has-thumbnail{% endif %}">
        <div class="writing-item-media">
          <p class="item-type">{{ item.type | escape }}</p>
          <h3><a href="{{ item.url | relative_url }}">{{ item.title | escape }}</a></h3>
          {% if item.image and item.image != "" %}
            <a class="writing-thumbnail" href="{{ item.url | relative_url }}" aria-label="Open {{ item.title | escape }}" {% if item.image_position and item.image_position != "" %}style="--image-position: {{ item.image_position | escape }};"{% endif %}>
              <img src="{{ item.image | relative_url }}" alt="{{ item.image_alt | default: item.title | escape }}">
            </a>
          {% endif %}
        </div>
        <div class="writing-item-summary">
          {% if item.date and item.date != "" %}
            <time datetime="{{ item.date | date_to_xmlschema }}">{{ item.date | date: "%b %-d, %Y" }}</time>
          {% endif %}
          {% if item.excerpt and item.excerpt != "" %}
            <p>{{ item.excerpt | strip_html | truncate: 170 | escape }}</p>
          {% endif %}
        </div>
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

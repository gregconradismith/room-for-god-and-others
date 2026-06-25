---
layout: page
title: Themes
permalink: /themes/
hide_eyebrow: true
page_class: archive-page themes-archive
---

<div class="archive-list theme-list">
  {% for theme in site.data.writing_categories %}
    <article class="archive-item theme-card{% if theme.image %} has-thumbnail{% endif %}">
      <h2><a href="{{ '/themes/' | append: theme.slug | append: '/' | relative_url }}">{{ theme.title | escape }}</a></h2>
      {% if theme.description %}
        <p>{{ theme.description | escape }}</p>
      {% endif %}
      {% if theme.image %}
        <a class="archive-thumbnail" href="{{ '/themes/' | append: theme.slug | append: '/' | relative_url }}" aria-label="Open {{ theme.title | escape }}">
          <img src="{{ theme.image | relative_url }}" alt="{{ theme.title | escape }}">
        </a>
      {% endif %}
    </article>
  {% endfor %}
</div>

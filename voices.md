---
layout: page
title: Voices
permalink: /voices/
description: Gathered passages, fragments, and remembered lines.
---

<div class="archive-tools">
  <a class="section-link" href="{{ '/voice-of-the-day/' | relative_url }}">Voice of the day</a>
  <a class="section-link" href="{{ '/voices/feed.xml' | relative_url }}">RSS feed</a>
</div>

<div class="archive-list quote-list">
  {% assign quotes = site.quotes | sort: "title" %}
  {% for quote in quotes %}
    {% include archive-item.html item=quote extra_class="quote-item" mark="&ldquo;" excerpt_length=190 %}
  {% endfor %}
</div>

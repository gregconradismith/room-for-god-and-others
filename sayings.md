---
layout: page
title: Sayings
permalink: /sayings/
description: Brief original sayings, fragments, and remembered formulations.
---

<div class="archive-list quote-list">
  {% assign aphorisms = site.aphorisms | sort: "title" %}
  {% for aphorism in aphorisms %}
    {% include archive-item.html item=aphorism extra_class="quote-item" mark="&ldquo;" excerpt_length=190 %}
  {% endfor %}
</div>

---
layout: page
title: Reflections
permalink: /reflections/
description: Short passages, fragments, sketches, and unplaced notes.
---

<div class="archive-list blurb-list">
  {% assign blurbs = site.blurbs | sort: "title" %}
  {% for blurb in blurbs %}
    {% include archive-item.html item=blurb extra_class="blurb-item" mark="¶" excerpt_length=190 %}
  {% endfor %}
</div>

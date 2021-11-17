---
date: 2015-10-05 10:35
last_modified_at: 2021-11-16 10:35
published: true
permalink: /en/sitemap.html
redirect_from:
  - /sitemap.html
  - /sitemap/
ref: sitemap
tags: [sitemap]
---

# Sitemap

{%- assign locale = page.locale | default: site.locale -%}
{%- assign pages = site.posts | concat: site.pages | where: "locale", locale | sort: 'title' -%}
{% if pages %}
<ul>
  {%- for page in pages -%} 
    {%- assign title = page.title | jsonify | replace: '"', '' | replace: 'null', '' | strip -%}
    {%- if page.search != 'exclude' and page.sitemap != false and title != '' and title != 'null' -%} 
      <li><a href="{{ page.url | replace: 'index.html', '' | relative_url }}" title="{{ title }}">{{ title }}
      {% if jekyll.environment == "development" %}
       ({{ page.locale | jsonify }})
       ({{ page.search | jsonify }})
       ({{ page.sitemap | jsonify }})
       {% endif %}
       </a></li>
    {%- endif -%}
  {%- endfor -%}
</ul>
{%- endif -%}

{% include _autolink.md %}

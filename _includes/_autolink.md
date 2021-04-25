{% assign currentYear = 'now'|date: '%Y' %}
{% assign experience = currentYear | minus: site.experience.sinceYear %}

{% include _acronyms.md %}
{% include _links.md %}
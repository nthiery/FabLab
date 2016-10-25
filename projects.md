---
layout: page
title: Models
---

{% assign projectpages = site.pages | where: "layout", "project-lasercuter" %}

<table>
  {% for page in projectpages %}
    <tr>
      <td><a href="{{page.dir}}"><img class="largeicon" src="{{page.dir}}/{{page.images[0]}}"></a></td>
      <td><a href="{{page.dir}}">{{page.title}}</a></td>
    </tr>
  {% endfor %}
</table>


And many more that have not yet been categorized!

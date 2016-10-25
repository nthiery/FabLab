---
layout: page
title: Projects
---

{% assign projectpages = site.pages | where: "layout", "project-lasercuter" %}

<table>
  {% for page in projectpages %}
    <tr>
      <td><a href="{{site.baseurl}}{{page.dir}}"><img class="largeicon" src="{{site.baseurl}}{{page.dir}}/{{page.images[0]}}"></a></td>
      <td><a href="{{site.baseurl}}{{page.dir}}">{{page.title}}</a></td>
    </tr>
  {% endfor %}
</table>

And many more that have not yet been indexed.

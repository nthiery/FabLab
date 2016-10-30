---
layout: page
title: Projects
---

{% assign projectpages = site.pages | where: "layout", "project" %}

<table>
  {% for page in projectpages %}
    <tr>
      <td><a href="{{site.baseurl}}{{page.dir}}"><img class="largeicon" src="{{site.baseurl}}{{page.dir}}/{{page.images[0]}}"></a></td>
      <td><a href="{{site.baseurl}}{{page.dir}}">{{page.title}}</a></td>
    </tr>
  {% endfor %}
</table>

And many more that have not yet been indexed.

See also the [project galery](http://fablab.digiscope.fr/#!/projects) on the [official FabLab site]({{site.official_fablab_url}}).


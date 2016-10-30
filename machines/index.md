---
layout: page
title: Our favorite FabLab's machines
---

{% assign machinepages = site.pages | where: "layout", "machine" %}

<table>
  {% for page in machinepages %}
    <tr>
      <td><a href="{{site.baseurl}}{{page.dir}}"><img class="largeicon" src="{{site.baseurl}}{{page.dir}}/{{page.images[0]}}"></a></td>
      <td><a href="{{site.baseurl}}{{page.dir}}">{{page.title}}</a></td>
    </tr>
  {% endfor %}
</table>

See also the [full list of available machines](https://fablabdigiscope.wordpress.com/machines/) on the [official FabLab site]({{site.official_fablab_url}}).

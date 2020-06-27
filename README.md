![GitHub release (latest SemVer including pre-releases)](https://img.shields.io/github/v/release/tfsaggregator/aggregator-cli)
![Publish as GitHub Pages](https://github.com/tfsaggregator/aggregator-docs/workflows/publish-on-master/badge.svg)
[![Hugo](https://img.shields.io/badge/hugo-0.71-blue.svg)](https://gohugo.io)

## Aggregator documentation

This repository contains the source of Aggregator GitHub Pages.

Processing requires [Hugo](https://gohugo.io/).

The documentation is published at <https://tfsaggregator.github.io/>.

## File&Folders

The documentation is in the `content/docs` folder. The [hugo-book](https://github.com/alex-shpak/hugo-book) theme generates the left _Table of Contents_ menu navigating the file structure. Put images at the same level as the `_index.md` file; file with a name different from `_index.md` should **not** reference images. If you need images, create a directory with an `_index.md` file in it.
If you want a different name, use the front matter `title` property, e.g. `rule-examples-basic.md` use

```yaml
---
title: 'Basic examples'
weight: 320
---
```
`weight` allows change the order of items in the menu.

## Markdown content

The right _Table of Contents_ menu, picks only headers level 2 (`##`) or higher (`###`, `####`, ...) .
Do not use Header 1 (single `#` titles).

## Test locally before pushing

Run `hugo serve`.

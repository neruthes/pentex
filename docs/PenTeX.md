---
title: "PenTeX Documentation"
author: "Neruthes"
date: "2023-05-29"
documentclass: "report"
---


# PenTeX Documentation


## Introduction

PenTeX is a package management frontend for Pandoc-compatible LaTeX [header files](https://pandoc.org/MANUAL.html#option--include-in-header).

There are occasions when writing raw LaTeX is overkill, and the Pandoc default style is not good enough,
and you do not want to spend too much time on tweaking the style.
PenTeX is designed to fit into the gap.

PenTeX is made for you if you are familiar with Markdown
but typesetting is not what you are particularly interested in.

The source code of PenTeX is available on [GitHub](https://github.com/neruthes/pentex).







## Installation

### Dependencies

Here are the known dependencies:

- Pandoc
- TeX Live (2023 or later)

Please note that some style packages may require specific fonts.
Package maintainers should declare what fonts they require.

### Local Install

Clone the git repository and run the following commands:

```sh
./make.sh build
./make.sh install_home
```

Now you should have a portable installation in your `$HOME`.

### Distro Admin

If you a packaging this software for a distro,
this section is written for you.

In your build script, run the following commands:

```sh
./make.sh build
./make.sh install
```

Note that you should pass `DEST` environment variable to make sure that artifact files (2 shell scripts) are properly installed
to the prefixed directory.
For example, you can declare `DEST=/dst114514/usr/bin` if the packager working prefix is `/dst114514`.







## Basic Usage

### Installing Header

Suppose that you want to get a header named `pentex-example-article` which is published on NPM.

```sh
pentex-pkg get npm:pentex-example-article
```

### Using Header from Package

```sh
h=npm:pentex-example-article pentex MyDoc.md
```

If package is not already available, it will be downloaded.
So you do not have to install it before running this command.

Remember to run `npm update` frequently to make sure that you always use the latest version of the package.

### Using Header from File

```sh
H=pentex-example-article.H.tex pentex MyDoc.md
```








## Command Line Details

### Arguments

Specify the file path of the Markdown file:

```sh
H=example.H.tex pentex MyDoc.md
```

Pass verbatim extra arguments to Pandoc:

```sh
H=example.H.tex pentex MyDoc.md --toc --number-sections
```

The full list of Pandoc arguments are available in [Pandoc User Manual](https://pandoc.org/MANUAL.html).

### Controlling Environment Variables

These environment variables control the behavior of `pentex`.

- `nomake`: Set `y` to prevent automatic Pandoc invocation. Instead, print the generated command only.
- `h`: Specify header from package.
- `H`: Specify header from local file path.

### Metadata Environment Variables

These environment variables are passed as variables to Pandoc.

| Variable    | Default Value |
| ----------- | ------------- |
| `papersize` | A4            |
| `fontsize`  | 11pt          |
| `geometry`  | 35em          |









## Making a Package

You know LaTeX well and you want to help other people who prefer to focus on the writing itself.
Here is how your generosity turns into helpful packages.

### Development

Suppose that you want to make a package with the name `mypkg`.

You should include a `mypkg.H.tex` file in the root of your package directory.
PenTeX will be looking for this specific filename when the user wants to use your package.

You may publish your package on NPM after the name `mypkg`.
This name must correspond to the filename of the `.H.tex` file.

### Sharing

You are welcomed to share your package in the
[discussion area](https://github.com/neruthes/pentex/discussions/categories/show-and-tell)
of the PanTeX repository on GitHub.

Please include its name in the `npm:mypkg` format and
attach a URL to an example document PDF.
One ideal source is the `README.md` file of your package.

Below is a template for you to fill.
It is abstracted from the [example post](https://github.com/neruthes/pentex/discussions/2).

```markdown
// Title
[npm:mypkg] Lorem ipsum dolor sit amet

// Body
Name: `npm:mypkg`

Source code: https://github.com/example/mypkg

Sample PDF: https://example.com/mypkg.md.pdf
```











## Trivial Facts

- We use `xelatex` at all times. If you want to set a specific value for `--pdf-engine`, you are professional enough to run `pandoc` commands without PenTeX.







## Copyright

Copyright &copy; 2023 Neruthes.

The source code of the PenTeX software suite is published with [GNU GPL 2.0](https://www.gnu.org/licenses/old-licenses/gpl-2.0.html).

This document itself is published with [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/).

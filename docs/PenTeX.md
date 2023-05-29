---
title: "PenTeX Documentation"
author: "Neruthes"
date: "2023-05-29"
---


# PenTeX Documentation


## Introduction

PenTeX is a package management frontend for Pandoc-compatible LaTeX [header files](https://pandoc.org/MANUAL.html#option--include-in-header).
There are some occasions when writing raw LaTeX is overkill and the Pandoc default style is not good enough.
PenTeX is designed to fit into the gap.







## Installation

### Dependencies

In addition to Pandoc and its dependencies, we specifically require some dependencies:

- TeX Live


### Local Install

Clone the git repository and run the following commands:

```sh
./make.sh build
./make.sh install_home
```

Now you should have a portable installation in your home.







## Usage

### Installing Header

Suppose that you want to get a header named `pentex-example-article` which is published on NPM.

```sh
pentex-pkg get npm:pentex-example-article
```

### Using Header from Package

```sh
h=npm:pentex-example-article pentex MyDoc.md
```

### Using Header from File

```sh
H=pentex-example-article.H.tex pentex MyDoc.md
```





## Making a Package

Suppose that you want to make a package with the name `mypkg`.

You should publish a `mypkg` package on NPM and include a `mypkg.H.tex` file in the root of your package directory.
PenTeX will be looking for this specific filename when the user wants to use your package.








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

### Controlling Environment Variables

These environment variables control the behavior of `pentex`.

- `nomake`: Set `y` to prevent automatic Pandoc invocation. Instead, print the generated command only.
- `h`: Specify header from package. If package is not already available, it will be downloaded.
- `H`: Specify header from local file path.

### Metadata Environment Variables

These environment variables are passed as variables to Pandoc.

- `papersize`
- `fontsize`








## Trivial Knowledge for the Curios People

- We use `xelatex` at all times. If you want to set a specific value for `--pdf-engine`, you are professional enough to run `pandoc` commands without PenTeX.







## Copyright

Copyright &copy; 2023 Neruthes.

The source code of the PenTeX software suite is published with [GNU GPL 2.0](https://www.gnu.org/licenses/old-licenses/gpl-2.0.html).

This document itself is published with [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/).

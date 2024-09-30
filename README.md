# SML Syntax Highlighter

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Supported SML Lexical Categories](#supported-sml-lexical-categories)
- [Installation and Usage](#installation-and-usage)
- [License](#license)

## Introduction
The SML Syntax Highlighter is a lexer-based tool designed to read SML (Standard ML) source code and generate an HTML file with syntax highlighting. Implemented using a lexer generator, this tool formats various lexical categories of SML, enhancing code readability and making it easier for developers to understand the structure and elements of their code.

## Features
- **Keyword Highlighting**: Highlights SML keywords (e.g., `val`, `datatype`, `fun`) in a distinctive color.
- **Built-in Type Highlighting**: Highlights built-in types like `int`, `bool`, and `string`.
- **Literal Highlighting**: Recognizes and highlights integer and boolean literals.
- **Identifier Highlighting**: Differentiates between upper-case and lower-case identifiers.
- **Operator and Separator Highlighting**: Highlights operators (e.g., `+`, `-`, `*`, `=>`) and other separators.
- **String and Comment Handling**: Properly formats string literals and multi-line comments with appropriate coloring.
- **Whitespace Handling**: Maintains whitespace formatting in the output.

## Supported SML Lexical Categories
The following SML lexical categories are supported:
- **Keywords**: Colored dark yellow (rgb=#a0a000)
- **Built-in Types**: Colored green (rgb=#00c000)
- **Literals**: Colored red (rgb=#ff0000), including integer literals, boolean literals, and string constants
- **Identifiers**: Colored magenta (rgb=#ff00ff) for upper-case identifiers; lower-case identifiers are uncolored
- **Operators and Separators**: Colored blue (rgb=#0000ff)
- **Comments**: Colored light blue (rgb=#00aaff)
- **Whitespace**: Displayed as appropriate HTML code

## Installation and Usage

1. **Clone the repository:**
    ```
    git clone https://github.com/hawraakhalil/SML-Syntax-Highlighter.git
    cd SML-Syntax-Highlighter
    ```

2. **Create an SML file if you do not want to use the example test.sml**
  
3. **To run using lex.yy.c:**
      - Navigate to the main function at the end of the C file and customize the input and output file names.
      - Compile and run the C file.

4. **To run using output.exe:**
      - Open terminal in the root directory.
      - Run ```.\output.exe input_file.sml output_file.html``` for custom input and output files.
      - Run ```.\output.exe input_file.sml``` for custom input file and test.html output file.

5. **Open the HTML output file**

## License
This project is licensed under the MIT License.
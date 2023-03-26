# About

Inspired by [Typesetting E-books](http://www.pmonta.com/etext/), this project explores the creation of pocket-sized classic books.

## Conversion Checklist 

(*originally posted [here](http://www.pmonta.com/etext/checklist)*)

Some brief notes on converting plain-text books to typeset versions:

### General housecleaning of the .txt file

- If the OCR didn't remove hyphens and coalesce words from hyphenated
    fragments across line breaks, do so.

- Run a spell check.

- Verify that there are no leading spaces in any lines, except in verse
    or other displayed material, which will require special formatting
    in LaTeX.

- De-capitalize (convert to mixed case) any words or phrases set
    in all-caps at the beginning of chapters (unless they're intended
    as emphasis).

- Check for lines that start a paragraph but whose first character
    is lower case.  This could signal a spurious empty line just above.

### LaTeX conversion

- Comment out front and back Gutenberg matter, keeping it in the
    file as LaTeX comments.  Sometimes there is editorial material
    within the body of the text in [brackets], which should be
    handled on a case-by-case basis.

- Put in boilerplate LaTeX code, \documentclass{}, pagestyle, headers,
    \begin{document}, etc.

- Use a quoted space after Mr. Mrs. Dr. Prof. Rev. Ms. since the
    periods do not end sentences.  For example, "Mrs. Smith" should
    become "Mrs.\ Smith".  Also "No. " followed by numerals should get
    a quoted space.

- Verify that there are no trailing spaces in any lines, for convenience
    in applying automatic search-and-replace for various things.

- Chapter titles: \section*{Chapter 12} or similar.

- Dashes: replace -- with --- (em-dash); replace ---- with something
    like {---}{---}.

- Line structure:  in general, try to maintain the same line breaks
    as the source .txt file, so that line-based comparison tools
    such as "diff" work nicely.

- Quotes: replace " with either `` or '' for open or close quotes
    respectively.  Similarly, change ' to ` for open single quote.
    A script can deal with the double quotes reasonably cleanly by
    resetting its balanced-quotes state every paragraph break, but
    single quotes can be confused with apostrophes.  A reasonable
    semiautomatic scheme for single quotes would look for ticks
    preceded by space or newline, but this can be fooled by things
    like <'Tis>; manually checking each one is recommended.

    Software should flag the paragraphs with unbalanced double quotes
    to be looked at by a human.

    Some texts use the British convention of single quotes for
    outer quotes and double quotes for inner, the reverse
    of the American convention.  I'm not sure how to deal with this;
    should all texts from a given author be made consistent?
    Probably easiest for now just to follow the source file.

- Nested quotes:  for juxtaposed single and double quote, insert
    a thin space between with "\,".

- Italics: replace any sequence of two or more capital letters with
    \emph{}, for example THEY with \emph{they}, unless the word starts
    a sentence, in which case it's \emph{They}.  This is an unfortunate
    ambiguity in one style of Gutenberg ASCII markup.  While this
    process can be semiautomated by looking for sentence-ending characters
    such as '.' and '?' just before the italicized word to assist in
    capitalizing it, this is not perfect, and manually checking each
    one is recommended.

    Some Gutenberg ASCII texts indicate emphasis with underscores,
    for example "here is an _emphasized_ word".  This is much better
    for automated tools.

    Replace sequences of emphasized words (e.g. "_my_ _dear_ _sir_")
    with a single \emph{} (\emph{my dear sir}).

    In Gutenberg ASCII texts using capitalized emphasis, an emphasized
    "I" nevertheless appears as _I_ for obvious reasons, which should
    be replaced by \emph{I}.  Software should probably just respond
    to either scheme.

- Special characters:  replace & $ % with \& \$ \%.  Replace
    British pound with \pounds, for example "100L" or "100L." or "100l."
    with "\pounds 100".

- Ellipses:  replace "..." or ". . ." (or similar) with "\ldots".

- Spaces and punctuation:  remove space between punctuation and
    quotes:  <! ''> should be <!''>.  Em-dashes <---> should have
    spaces neither before nor after.

- End of line:  for em-dashes or hyphens that end a line, replace
    with "---%" or "-%" to suppress the implicit space caused by
    the line break.  Similar issue for hyphens or dashes
    that begin a line.  Same deal with Mr., Mrs., etc. which, when at
    the end of a line, should look like "Mr.\ %".

- Ties:  some phrases and proper names, for example "de Bourgh",
    should be typeset with unbreakable space ("de~Bourgh") to
    prevent breaking them across lines.  It's best to use this
    only when one of the words is quite small to avoid low-quality
    line breaks.

- Special layout:  for letters, verse, or other quoted material,
    choose some suitable LaTeX environment and/or vertical spacing.

- Foreign words:  add any accents/diacriticals that might be needed.

- Tables:  tabular material in the .txt file that depends on a
    fixed-width typeface for spacing will have to be dealt with
    somehow.  There are nice table environments in LaTeX,
    or use \verbatim{} as a quick stopgap.

- Document structure:  for large texts that need a table of contents,
    render in LaTeX using \tableofcontents or whatever is offered
    by the document class.

### Tools

While everyone has a favorite editor, I've found emacs to be very
useful for regular-expression-based search-and-replace, which can
pick out expressions based on surounding context.  The
query-replace feature allows one to interactively zip through
judgment-call stuff like single quotes or emphasis capitalization
with just a single yes-or-no keystroke per instance.

For typesetting I'd recommend pdflatex, which will produce PDF
directly.  pdftex produces more compact PDF than the LaTeX --> dvips
--> ps2pdf toolchain, and it offers advanced typographic features
like margin kerning for more optically even margins in justified text.

TeX/LaTeX/pdftex is free software; this is potentially significant
for projects like Gutenberg since it guarantees that the software
is always available and modifiable---texts cannot become "dead" as a
result of proprietary formats that become unsupported.  TeX was
first released in the early 1980s and has changed little since; it
has a large user community.

### Resources:

- TeX software, tutorials, documentation:
    http://www.tug.org

- Some examples of converted Gutenberg files.  Note that these
  are unofficial versions, though some may migrate to the
  Gutenberg mirrors after sufficient review:
    http://www.pmonta.com/etext

# Tok-tok
A fast, simple, multilingual tokenizer


## Overview

Tok-tok is a fast, simple, multilingual tokenizer.
It is freely licensed under the [Apache v2][] license.

For example, given an input of:

      They thought, "Is 9.5 or 525,600 my favorite number?",  before seeing Dr. Bob's dog talk on www.foo.ninja/index.html?nobeta=1&noalpha=0.

The output is:

      They thought , " Is 9.5 or 525,600 my favorite number ? " , before seeing Dr. Bob ' s dog talk on www.foo.ninja/index.html?nobeta=1&noalpha=0 .


## Usage

      perl tok-tok.pl [options] < text.txt > text.tok.txt

      Options:
       -h, --help        Print this usage
       -d, --digit <u>   Conflate all digits to <u> . Note that 0 is reserved
       -l, --lower       Lowercase text



## Languages
Tok-tok has been tested on, and gives reasonably good results for English, Persian, Russian, Czech, French, German, and a few others.
The input should be in UTF-8 encoding.
You can use the command-line tool `iconv` to convert other formats to UTF-8.


## Name
The name of the software means "*language*" or "*speech*" in Bislama, a Melanesian Creole language.
[Bislama][] is quite possibly the world's perfect language.


[Apache v2]: https://www.apache.org/licenses/LICENSE-2.0.html
[Bislama]: https://en.wikipedia.org/wiki/Bislama

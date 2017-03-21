# Tok-tok
**Tok-tok** is a fast, simple, multilingual tokenizer.  Python and Perl implementations are provided.


## Example
For example, given an input of:

      They thought, "Is 9.5 or 525,600 my favorite number?",  before seeing Dr. Bob's dog talk on www.foo.ninja/index.html?nobeta=1&noalpha=0.

The output is:

      They thought , " Is 9.5 or 525,600 my favorite number ? " , before seeing Dr. Bob ' s dog talk on www.foo.ninja/index.html?nobeta=1&noalpha=0 .


## Usage
### Python
```
python3 toktok.py [options] < text.txt > text.tok.txt

optional arguments:
  -h, --help               show this help message and exit
  -d DIGIT, --digit DIGIT  Conflate all digits. For example "3.14" -> "5.55"
  -l LANG, --lang LANG     Specify language code for moses tokenizer (default: en)
  --lc, --lower            Lowercase text
  --no_empty               Remove empty lines
  --skip_comments          Don't tokenize lines starting with '#'
  -t TOK, --tok TOK        Specify tokenizer submodule {casual, moses, stanford, toktok, treebank} (default: toktok)
```

### Perl
```
perl tok-tok.pl [options] < text.txt > text.tok.txt

Options:
 -h, --help           Print this usage
 -d, --digit <u>      Conflate all digits to <u> . Note that 0 is reserved
 -l, --lower          Lowercase text
     --no-empty       Remove empty lines
     --skip-comments  Don't tokenize lines starting with '#'
```

## Languages
Tok-tok has been tested on, and gives reasonably good results for English, Persian, Russian, Czech, French, German, Vietnamese, Tajik, and a few others.
The input should be in UTF-8 encoding.
You can use the command-line tool `iconv` to convert other formats to UTF-8.


## Name
The name of the software means "*language*" or "*speech*" in Bislama, a Melanesian Creole language.
[Bislama][] is quite possibly the world's perfect language.


[Apache v2]: https://www.apache.org/licenses/LICENSE-2.0.html
[Bislama]: https://en.wikipedia.org/wiki/Bislama

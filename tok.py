#!/usr/bin/env python3
# By Jon Dehdari, 2017
# TODO: +digit-conflate, --no-empty, --skip-comments
""" Command-line interface to all of NLTK's tokenizers. """

from __future__ import print_function
import sys
import argparse
import nltk.tokenize as tok


def load_tokenizer(cmd_args):
    """ Selects the appropriate tokenizer, from command-line arguments. """
    tokr = tok
    if cmd_args.tok == 'casual':
        tokr = tok.casual.TweetTokenizer()
    #elif cmd_args.tok == 'mwe':
    #    tokr = tok.mwe.MWETokenizer()
    #elif cmd_args.tok == 'punkt':
    #    tokr = tok.punkt.PunktSentenceTokenizer()
    #elif cmd_args.tok == 'regexp':
    #    tokr = tok.regexp.RegexpTokenizer()
    #elif cmd_args.tok == 'repp':
    #    tokr = tok.repp.ReppTokenizer()
    #elif cmd_args.tok == 'sexpr':
    #    tokr = tok.sexpr.SExprTokenizer()
    elif cmd_args.tok == 'stanford':
        tokr = tok.stanford.StanfordTokenizer()
    elif cmd_args.tok == 'texttiling':
        tokr = tok.texttiling.TextTilingTokenizer()
    elif cmd_args.tok == 'treebank':
        tokr = tok.treebank.TreebankWordTokenizer()
    elif cmd_args.tok == 'moses':
        tokr = tok.moses.MosesTokenizer(lang=cmd_args.lang)
    else:
        tokr = tok.toktok.ToktokTokenizer()

    return tokr

def tok_stdin(cmd_args, tokr):
    """ Tokenizes each line, and prints it out. """
    for line in sys.stdin:
        # Skip empty lines
        if cmd_args.no_empty and line == '\n':
            continue

        # Don't tokenize comments
        if cmd_args.skip_comments and line[0] == '#':
            print(line, end='')
            continue

        line = ' '.join(tokr.tokenize(line))

        if cmd_args.lc:
            print(line.lower())
        else:
            print(line)

def main():
    """ Parse command-line arguments and tokenize STDIN. """

    parser = argparse.ArgumentParser(
        description="Command-line interface to all of NLTK's tokenizers.")
    parser.add_argument('-l', '--lang', type=str, default='en',
                        help='Specify language code for moses tokenizer (default: %(default)s)')
    parser.add_argument('--lc', '--lower', action='store_true',
                        help='Lowercase text')
    parser.add_argument('--no_empty', action='store_true',
                        help='Remove empty lines')
    parser.add_argument('--skip_comments', action='store_true',
                        help="Don't tokenize lines starting with '#'")
    parser.add_argument('-t', '--tok', type=str, default='toktok',
                        help='Specify tokenizer submodule {casual, moses,\
                                stanford, toktok, treebank} (default: %(default)s)')
    cmd_args = parser.parse_args()

    # Load tokenizer
    tokr = load_tokenizer(cmd_args)

    # Tokenize stdin
    tok_stdin(cmd_args, tokr)

if __name__ == '__main__':
    main()

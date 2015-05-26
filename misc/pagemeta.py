#!/usr/bin/env python
# encoding: UTF-8

import re
import os
import sys
import glob


def process(source):
    match = re.search('<!--\s*###PARAMS###(.*?)\s*-->', source,
                      flags=re.MULTILINE | re.DOTALL)
    if match:
        data = match.group(1).strip()
        fields = {}
        for line in data.split('\n'):
            line = line.strip()
            if line:
                pos = line.index(':')
                name = line[:pos].strip()
                value = line[pos+1:].strip()
                fields[name] = value
        source = source.replace(match.group(0), '')
        for name in fields:
            source = source.replace("###%s###" % name, fields[name])
    return source


def main(directories):
    for directory in directories:
        files = glob.glob(os.path.join(directory, '**/*.html')) + \
                glob.glob(os.path.join(directory, '*.html'))
        for f in files:
            print "Processing %s..." % f
            with open(f) as stream:
                text = stream.read()
            text = process(text)
            with open(f, 'w') as stream:
                stream.write(text)


if __name__ == '__main__':
    if len(sys.argv) < 2:
        print "You must pass list of directories to scan"
    main(sys.argv[1:])

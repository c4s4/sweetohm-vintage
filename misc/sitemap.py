#!/usr/bin/env python
# encoding: UTF-8

import glob
import datetime


SITE_DOMAIN = 'http://sweetohm.net'
SITE_ROOT = 'build/site'
GLOBS = {
    '%s/*.html':      0.0,
    '%s/html/*.html': 1.0,
    '%s/blog/*.html': 1.0,
}

HTML_ROOT = '''<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
%s
</urlset>'''
HTML_ENTRY = '''  <url>
    <loc>%s</loc>
    <lastmod>%s</lastmod>
    <priority>%s</priority>
  </url>'''


def main():
    files = {}
    for gloob, weight in GLOBS.iteritems():
        pages = sorted(glob.glob(gloob % SITE_ROOT))
        for page in pages:
            files[page.replace(SITE_ROOT, SITE_DOMAIN)] = weight
    date = datetime.datetime.now().strftime("%Y-%m-%d")
    entries = []
    for url, weight in sorted(files.iteritems()):
        entries.append(HTML_ENTRY % (url, date, weight))
    sitemap = HTML_ROOT % '\n'.join(entries)
    with open("%s/sitemap.xml" % SITE_ROOT, 'wb') as stream:
        stream.write(sitemap)


if __name__ == '__main__':
    main()

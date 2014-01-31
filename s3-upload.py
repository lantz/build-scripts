#!/usr/bin/python

"""
Upload a file to S3
"""

from sys import argv, stdout
from time import time

from boto.s3.key import Key
from boto.s3.connection import S3Connection

def callback( transmitted, size ):
    "Progress callback for set_contents_from_filename"
    print '\r%d bytes transmitted of %d (%.2f%%)' % (
        transmitted, size, 100.0 * transmitted / size ),
    stdout.flush()

def uploadFile( bucket, filename ):
    "Upload a file to a bucket"
    print '* Uploading', filename, 'to bucket', bucket
    start = time()
    conn = S3Connection()
    bucket = conn.get_bucket( bucket )
    k = Key( bucket )
    k.key = filename
    k.set_contents_from_filename( filename, cb=callback, num_cb=100 )
    print
    elapsed = time() - start
    print "* elapsed time: %.2f seconds" % elapsed

if __name__ == '__main__':
    if len( argv ) != 3:
        print 'Usage: %s <bucket> <filename>'
        exit( 1 )
    bucket, filename = argv[ 1 : 3 ]
    uploadFile( bucket, filename )

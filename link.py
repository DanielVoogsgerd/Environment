#!/usr/bin/python

import glob, os

def main():
    symlinkFiles = glob.glob('./*/.symlinks')

    for symlinkFile in symlinkFiles:
        path = os.path.abspath ( symlinkFile )
        baseDir = os.path.split ( path )[0] + '/'

        print ( path )

        content = str( open(path, 'r').read() )

        symlinks = content.split( '\n' )[0:-1]

        print ( symlinks )

        for symlink in symlinks:
            s = symlink.split( ' => ' )


            file = os.path.abspath( os.path.expanduser( os.path.join(baseDir, s[0]) ) )
            dest = os.path.abspath( os.path.expanduser( s[1] ) )
            if not os.path.lexists( dest ):
                print ('Linking ' + file + ' to ' + dest)
                os.symlink(file, dest) 
            else:
                print ('File already exists')




        print ('--------------------')


main()
#!/usr/bin/python

# Importing globOS because linux sucks, wow that was a bad one.
import glob, os


def main():
    # Look for symlinkfiles inside the directories
    symlinkFiles = glob.glob('./*/.symlinks')

    # Loop through the symlinkfiles and parse them
    for symlinkFile in symlinkFiles:
        # Get the absolute path for the symlink (Bash convention)
	path = os.path.abspath ( symlinkFile )
        
	# Get the absolute base path for the directory
	baseDir = os.path.split ( path )[0] + '/'

	# Print the path (Can't be bothered to remove some debugging stuff right now, since I'm still 
	print ( path )

	# Open the symlink file
        content = str( open(path, 'r').read() )

	# Split the big blob of text into seperate rule we can parse
        symlinks = content.split( '\n' )[0:-1]

	# Loop through the rules and parse them
        for symlink in symlinks:
	    # Split the symlink into a file and destination
            s = symlink.split( ' => ' )

	    Get the absolute path without the home directory refered to as ~. (Bash convention)
            file = os.path.abspath( os.path.expanduser( os.path.join(baseDir, s[0]) ) )
            dest = os.path.abspath( os.path.expanduser( s[1] ) )

	    # If the destination doesn't exist yet, create the symlink
	    if not os.path.lexists( dest ):
	    	# Debug code
                print ('Linking ' + file + ' to ' + dest)

		# Finally create the symlink
		os.symlink(file, dest) 
            else:
	        # Throw a nice error
                print ('File already exists')
                print ('--------------------')


if __name__ == "__main__":
	    main()

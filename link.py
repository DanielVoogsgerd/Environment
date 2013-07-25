#!/usr/bin/python

# Importing globOS because linux sucks, wow that was a bad one.
import glob, os, sys

def main():
    args = sys.argv

    if len(args) > 1:
        test = symlink()
        test.scan()
        test.parse()
        test.filter(args[1])



    else:
        symlink.help()
        

class symlink:

    def scan(self):

        # Look for symlinkfiles inside the directories
        symlinkFiles = glob.glob('./*/.symlinks')

        paths = []

        # Loop through the symlinkfiles and parse them
        for symlinkFile in symlinkFiles:
            
            # Get the absolute path for the symlink (Bash convention)
            path = os.path.abspath(symlinkFile)

            # Print the path (Can't be bothered to remove some debugging stuff right now, since I'm still 
            #print(path)
            paths.append(path)

        # Save pathsIf y
        self.paths = paths

        return (paths)

    def parse(self, paths=False):
        
        # Check if there are paths provided
        if not paths:
            paths = self.paths

        self.links = []


        # Loop over the paths
        for path in paths:

            # Get the absolute base path for the directory
            baseDir = os.path.split (path)[0] + '/'

            # Open the symlink file
            content = open(path, 'r').read()

            # Split the big blob of text into seperate rule we can parse
            symlinks = content.split('\n')[0:-1]


            # Loop through the rules and parse them
            for symlink in symlinks:

                users = []

                # Check if there is an "|" indicating that there are users
                if symlink.find('|') != -1:

                    # Split the user part of
                    s = symlink.split('|')

                    # Debug code
                    link = s[0]
                    
                    # Loop over all users and add them to the array
                    for user in s[1].split(','):
                        users.append( user.lower() )

                else:
                    link = symlink


                if link.find('=>'):
                    
                    # Split the symlink into a file and destination
                    s = link.split('=>')

                    # Get the absolute path, without the home directory refered to as ~. (Bash convention)
                    file = os.path.abspath(os.path.expanduser(os.path.join(baseDir, s[0])))
                    dest = os.path.abspath(os.path.expanduser(s[1]))

                    self.links.append((file, dest, users))

        return self.links

    def filter(self, user):
        links = []
        for link in self.links:
            if user.lower() in link[2] or not len(link[2]) > 0:
                links.append(link)

        self.links = links

        print(self.links)
        
        return links


    def link(self):

        # If the destination doesn't exist yet, create the symlink
        if not os.path.lexists(dest):

            # Debug code
            print ('Linking ' + file + ' to ' + dest)

            # Finally create the symlink
            os.symlink(file, dest) 
        else:

            # Throw a nice error
            print ('File already exists')
            print ('--------------------')


    def help():
        print ('Lorem')


# Call the middle function
if __name__ == "__main__":
        main()


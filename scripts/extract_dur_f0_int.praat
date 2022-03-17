# Set path to folder where files are
path$ = "../stim/segmented/"

# Create output file and set header
sep$ = ","

writeFileLine: "../data/data.csv",
  ..."info"       + sep$ +
  ..."durationV"  + sep$ + 
  ..."f0"         + sep$ +
  ..."int"

#
# Prepare loop
#

# Go to folder where files are located, create list
Create Strings as file list: "fileList", path$ + "*.wav"

# Select the object fileList
selectObject: "Strings fileList"

# Count # of files and assign total to 'numFiles'
numFiles = Get number of strings

#
# Start loop
#

for i from 1 to numFiles

    # Select string, read in files
    select Strings fileList
    fileName$ = Get string... i
    prefix$ = fileName$ - ".wav"
    Read from file... 'path$'/'prefix$'.wav
    Read from file... 'path$'/'prefix$'.TextGrid

    # Calculate mid-point of vowel
    vowelStart = Get starting point: 1, 2
    vowelEnd = Get starting point: 1, 3
    durationV = vowelEnd - vowelStart
    mp = Get time of point: 2, 1

    # Get f0 at midpoint
    select Sound 'prefix$'
    To Pitch: 0, 75, 600
    f0 = Get value at time: mp, "Hertz", "Linear"

    # Get intensity at midpoint
    select Sound 'prefix$'
    To Intensity: 100, 0, "yes"
    int = Get value at time: mp, "Cubic"

    # Append data to .csv file
    fileappend "../data/data.csv" 'prefix$','durationV:2','f0:2','int:2''newline$'

    # Printline for bug fixes (comment out for speed)
    printline 'prefix$','durationV:2','f0:2','int:2'

    # Clean up
    select all
    minus Strings fileList
    Remove
endfor

# Clean objects
select all
Remove

form Save intervals to small sound files
    comment Give the folder where to save the sound files:
    sentence Folder ../stim/segmented/
endform

soundname$ = selected$ ("TextGrid", 1)
select TextGrid 'soundname$'
numberOfIntervals = Get number of intervals... 1
end_at = numberOfIntervals

files = 0
intervalstart = 0
intervalend = 0
interval = 1
intnumber = 1 - 1
intname$ = ""
intervalfile$ = ""
endoffile = Get finishing time

for interval from 1 to end_at
    xxx$ = Get label of interval... 1 interval
    check = 0
    if xxx$ = ""
        check = 1
    endif
    if check = 0
       files = files + 1
    endif
endfor

interval = 1
textfilename$ = "'folder$'" + "0_" + "'soundname$'" + "_" + "to" + "'files'" + ".txt"

for interval from 1 to end_at
    select TextGrid 'soundname$'
    intname$ = ""
    intname$ = Get label of interval... 1 interval
    check = 0
    if intname$ = ""
        check = 1
    endif
    if check = 0
        intnumber = intnumber + 1
        intervalstart = Get starting point... 1 interval
            if intervalstart > 0.01
                intervalstart = intervalstart - 0.01
            else
                intervalstart = 0
            endif
    
        intervalend = Get end point... 1 interval
            if intervalend < endoffile - 0.01
                intervalend = intervalend + 0.01
            else
                intervalend = endoffile
            endif
    
        select Sound 'soundname$'
        Extract part... intervalstart intervalend rectangular 1 no
        intervalfile$ = "'folder$'" + "'intname$'" + ".wav"
        Write to WAV file... 'intervalfile$'
        Remove
        select TextGrid 'soundname$'
        intname$ = "'intname$'" + "'newline$'"
        fileappend "'textfilename$'" 'intname$'
    endif
endfor

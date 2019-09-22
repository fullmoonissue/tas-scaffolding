# Archive bk2

## Create the original bk2

Launch BizHawk, then your ROM and go to `File -> Movie -> Record Movie...`

Select the location of the archive, type Enter and go to `File -> Movie -> Stop Movie` 

## Update the bk2 (specially the Input Log.txt)

In this example, you'll need [7z](https://www.7-zip.org/download.html).

    # Extract the bk2
    cd /path/to/the/bk2-folder
    7z x game.bk2

    # Replace the Input Log.txt file
    cp /path/to/your/new/Input\ Log.txt .

    # Reconstruct the archive
    7za a -tzip game.bk2 Comments.txt Header.txt Input\ Log.txt Subtitles.txt SyncSettings.json
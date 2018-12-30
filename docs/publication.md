# Publication

## AVI to MP4 with ffmpeg

If you saved a video output from Bizhawk in multiple .avi files, here are some commands to make a .mp4 file for Youtube.

### Merge all the .avi (fragments) video together (ffmpeg needed)

    # Create a file which will contain the listing of all your .avi files to concat
    # For the example, the file is named game-join-videos.txt
    
    # Content of /path/to/game-join-videos.txt 
    file '/path/game.avi'
    file '/path/game_1.avi'
    file '/path/game_2.avi'
    ...

    # Do the merge (for the example, the output file is named tas-game.avi)
    ./ffmpeg -f concat -safe 0 -i /path/to/game-join-videos.txt -c copy tas-game.avi

### Transform .avi video into .mp4 video

    # For the example, .avi file is named tas-game.avi and the .mp4 will be tas-game-compressed.mp4
    ./ffmpeg -i tas-game.avi -c:v libx264 -crf 19 -preset slow -c:a aac -b:a 192k -ac 2 tas-game-compressed.mp4
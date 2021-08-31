# Current version of the tas-scaffolding project
SCAFFOLDING_VERSION=3.6.1

#
# -- Task: install --
#
# >> Install dependencies used to setup the tas <<
#

install:
	luarocks install mediator_lua --tree lua_modules

# ### ### ### #
#  Variables  #
# ### ### ### #

# Path to the file containing all the paths to important files or folders
PATHS_FILE=configuration/paths

# Path to the bk2 folder (see "Archive bk2" section into the README.md of tas-scaffolding project)
BK2_FOLDER=`lua -e "c=require('$(PATHS_FILE)'); print(c['folder']['bk2']);"`

# Path to the publication folder
PUBLICATION_FOLDER=`lua -e "c=require('$(PATHS_FILE)'); print(c['folder']['publication']);"`

# Path to the tas file template (see "Introduction" section into the README.md of tas-scaffolding project)
TAS_FILE_TEMPLATE=`lua -e "c=require('$(PATHS_FILE)'); print(c['template']['newFile']);"`

# Path to the tas folder (see "Introduction" section into the README.md of tas-scaffolding project)
TAS_FOLDER=`lua -e "c=require('$(PATHS_FILE)'); print(c['folder']['tas']);"`

# Path to the file which list the files for each tas
# (see "Technical difficulties" section into the README.md of tas-scaffolding project)
TAS_LFS=`lua -e "c=require('$(PATHS_FILE)'); print(c['tas']['files']);"`.lua

# ### ### #
# BizHawk #
# ### ### #

#
# -- Task: bizhawk-bk2-archive --
#
# >> Create the bk2 archive <<
#
# !! Required software !!
# 7zip : https://www.7-zip.org/download.html
#
# !! Required variable(s) !!
# BK2_NAME
# PATH_COMMENTS
# PATH_HEADER
# PATH_INPUT_LOG
# PATH_SUBTITLES
# PATH_SYNC_SETTINGS
#

bizhawk-bk2-archive:
	@7za a -tzip $(PWD)/$(BK2_FOLDER)/$(BK2_NAME).bk2 $(PATH_COMMENTS) $(PATH_HEADER) "$(PATH_INPUT_LOG)" $(PATH_SUBTITLES) $(PATH_SYNC_SETTINGS)

#
# -- Task: bizhawk-bk2-update-input-log --
#
# >> Update the "Input Log.txt" file into an existing bk2 archive <<
#
# !! Required software !!
# 7zip : https://www.7-zip.org/download.html
#
# !! Required variable(s) !!
# BK2_NAME
# PATH_INPUT_LOG
#

bizhawk-bk2-update-input-log:
	@7z x $(PWD)/$(BK2_FOLDER)/$(BK2_NAME).bk2 -o$(PWD)/$(BK2_FOLDER)
	@make BK2_NAME=$(BK2_NAME) PATH_COMMENTS=$(PWD)/$(BK2_FOLDER)/Comments.txt PATH_HEADER=$(PWD)/$(BK2_FOLDER)/Header.txt PATH_INPUT_LOG=$(PATH_INPUT_LOG) PATH_SUBTITLES=$(PWD)/$(BK2_FOLDER)/Subtitles.txt PATH_SYNC_SETTINGS=$(PWD)/$(BK2_FOLDER)/SyncSettings.json bizhawk-bk2-archive
	@rm -f $(PWD)/$(BK2_FOLDER)/Comments.txt $(PWD)/$(BK2_FOLDER)/Header.txt "$(PWD)/$(BK2_FOLDER)/Input Log.txt" $(PWD)/$(BK2_FOLDER)/Subtitles.txt $(PWD)/$(BK2_FOLDER)/SyncSettings.json

#
# -- Task: bizhawk-dump --
#
# >> Export your lua inputs into the BizHawk's `Input Log.txt` file <<
#
# !! Required variable(s) !!
# TAS : Name of the tas category (ex: any%)
#
# ?? Optional variable(s) (see "Variables" section above for explanations) ??
# TAS_LFS
# TAS_FOLDER
# BK2_FOLDER
#

bizhawk-dump:
	@if [ '$(TAS)' == '' ]; then \
        echo "Call : make TAS=any% bizhawk-dump"; \
        exit 1; \
    fi
	@[ -d $(BK2_FOLDER)/$(TAS) ] || mkdir $(BK2_FOLDER)/$(TAS)
	@lua scripts/bizhawk-dump.lua $(TAS) $(TAS_LFS) $(TAS_FOLDER) $(BK2_FOLDER)
	@if [ '$(COMMENTS_FILE)' != '' && '$(HEADER_FILE)' != '' && '$(SUBTITLES_FILE)' != '' && '$(SYNC_SETTINGS_FILE)' != '' ]; then \
        @make BK2_NAME=$(TAS) PATH_COMMENTS=$(COMMENTS_FILE) PATH_HEADER=$(HEADER_FILE) PATH_INPUT_LOG=$(PWD)/$(BK2_FOLDER)/Input\ Log.txt PATH_SUBTITLES=$(SUBTITLES_FILE) PATH_SYNC_SETTINGS=$(SYNC_SETTINGS_FILE) bizhawk-bk2-archive; \
        echo "Archive created !"; \
    fi

#
# -- Task: bizhawk-lfs --
#
# >> (Re)Write the file listing the files for each tas <<
#
# ?? Optional variable(s) (see "Variables" section above for explanations) ??
# TAS_LFS
# TAS_FOLDER
#

bizhawk-lfs:
	@lua scripts/bizhawk-lfs.lua $(TAS_LFS) $(TAS_FOLDER)

#
# -- Task: describe-tas --
#
# >> Assign TAS infos <<
#
# !! Required variable(s) !!
# GAME (ex: "Devil Dice")
# CONSOLE (ex: "PSX")
# BIZHAWK (ex: "2.5.2")
# CATEGORY (ex: "Any%")
#
# Example : make GAME="Devil Dice" CONSOLE="PSX" BIZHAWK="2.5.2" CATEGORY="Any%" describe-tas
#

describe-tas:
	@echo "return {\n\
    ['bizhawk_version'] = '$(BIZHAWK)',\n\
    ['game_console'] = '$(CONSOLE)',\n\
    ['game_name'] = '$(GAME)',\n\
    ['scaffolding_version'] = '$(SCAFFOLDING_VERSION)',\n\
}" > configuration/tas.lua
	@sed 's/...game.../$(GAME)/' README.md > README_.md ; mv README_.md README.md
	@sed 's/...console.../$(CONSOLE)/' README.md > README_.md ; mv README_.md README.md
	@sed 's/...category.../$(CATEGORY)/' README.md > README_.md ; mv README_.md README.md
	@sed 's/X.Y.Z/$(BIZHAWK)/' README.md > README_.md ; mv README_.md README.md
	@sed 's/A.B.C/$(SCAFFOLDING_VERSION)/g' README.md > README_.md ; mv README_.md README.md

#
# -- Task: register --
#
# >> Register a new file for a specific tas <<
#
# !! Required variable(s) !!
# TAS : Name of the tas (ex: any%)
# FILE : Name of the file (ex: 0-init.lua)
#
# ?? Optional variable(s) (see "Variables" section above for explanations) ??
# TAS_FOLDER
# TAS_FILE_TEMPLATE
#

register:
	@if [ '$(TAS)' == '' ] || [ '$(FILE)' == '' ]; then \
        echo "Call (example) : make TAS=any% FILE=0-init.lua register"; \
        exit 1; \
    fi
	@[ -d $(TAS_FOLDER)/$(TAS) ] || mkdir $(TAS_FOLDER)/$(TAS)
	@lua scripts/register.lua $(TAS) $(FILE) $(TAS_FOLDER) $(TAS_FILE_TEMPLATE)
	@make bizhawk-lfs

# ### ### #
#  Video  #
# ### ### #

# An easy setup to produce youtube ready videos in mp4 is to configure the output video that way :
# > Recording parameters : Writer => FFMPEG Writer ; Video Format => MP4

# The next tasks will help to generate a youtube ready video after recording (which will output an avi file)
# > Recording parameters : A/V Writer => AVI Writer ; Compressor => Codec Intel IYUV

# GAME is the name of the first recording file without extension
# > To prevent from errors (in make commands), you should avoid space into the name and prefer a slugified name

#
# -- Task: video-convert-avi-to-mp4 --
#
# >> Convert from avi video (from Bizhawk) to mp4 video (for youtube) using ffmpeg <<
#
# !! Required variable(s) !!
# FFMPEG : Path to the ffmpeg binary (ex: ./ffmpeg)
# GAME : @see above
# CATEGORY : Category of the tas (ex: "any%")
#

video-convert-avi-to-mp4:
	@$(FFMPEG) -i $(PWD)/$(PUBLICATION_FOLDER)/tas-$(GAME)-$(CATEGORY).avi -c:v libx264 -crf 19 -preset slow -c:a aac -b:a 192k -ac 2 $(PWD)/$(PUBLICATION_FOLDER)/tas-$(GAME)-$(CATEGORY).mp4

#
# -- Task: video-glue-parts --
#
# >> Create one video by joining fragments using ffmpeg <<
#
# !! Required variable(s) !!
# FFMPEG : Path to the ffmpeg binary (ex: ./ffmpeg)
# GAME : @see above
# CATEGORY : Category of the tas (ex: "any%")
#

video-glue-parts:
	@$(FFMPEG) -f concat -safe 0 -i $(PWD)/$(PUBLICATION_FOLDER)/$(GAME)-video-parts.txt -c copy $(PWD)/$(PUBLICATION_FOLDER)/tas-$(GAME)-$(CATEGORY).avi

#
# -- Task: video-prepare-parts --
#
# >> Create the file needed by ffmpeg to glue video parts together <<
#
# !! Required variable(s) !!
# GAME : @see above
#

video-prepare-parts:
	@ls $(PWD)/$(PUBLICATION_FOLDER)/$(GAME)* | sed "s/^/file '/" | sed "s/$$/'/" > $(PWD)/$(PUBLICATION_FOLDER)/$(GAME)-video-parts.txt
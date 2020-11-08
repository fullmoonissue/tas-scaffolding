.DEFAULT_GOAL := install

SCAFFOLDING_VERSION=3.5.0

install: ## [Install] Project dependencies
	luarocks install mediator_lua --tree lua_modules
	luarocks install luafilesystem --tree lua_modules

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
# -- Task: bizhawk-dump --
#
# >> Export your lua inputs into the BizHawk's `Input Log.txt` file <<
#
# Required variable
# TAS : Name of the tas category (ex: any%)
#
# Optional variable (see "Variables" section above for explanations)
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

#
# -- Task: bizhawk-lfs --
#
# >> (Re)Write the file listing the files for each tas <<
#
# Optional variable (see "Variables" section above for explanations)
# TAS_LFS
# TAS_FOLDER
#

bizhawk-lfs:
	@lua scripts/bizhawk-lfs.lua $(TAS_LFS) $(TAS_FOLDER)

#
# -- Task: bk2-update-input-log --
#
# >> Update the "Input Log.txt" file into an existing bk2 archive <<
#
# ## Create the original bk2
# Launch BizHawk, then your ROM and go to `File -> Movie -> Record Movie...`
# Select the location of the archive, type Enter and go to `File -> Movie -> Stop Movie`
#
# Required software
# 7zip : https://www.7-zip.org/download.html
#
# Required variable
# BK2_NAME
# PATH_INPUT_LOG
#

bk2-update-input-log:
	@7z x $(PWD)/$(BK2_FOLDER)/$(BK2_NAME).bk2 -o$(PWD)/$(BK2_FOLDER)
	@7za a -tzip $(PWD)/$(BK2_FOLDER)/$(BK2_NAME).bk2 $(PWD)/$(BK2_FOLDER)/Comments.txt $(PWD)/$(BK2_FOLDER)/Header.txt "$(PATH_INPUT_LOG)" $(PWD)/$(BK2_FOLDER)/Subtitles.txt $(PWD)/$(BK2_FOLDER)/SyncSettings.json
	@rm -f $(PWD)/$(BK2_FOLDER)/Comments.txt $(PWD)/$(BK2_FOLDER)/Header.txt "$(PWD)/$(BK2_FOLDER)/Input Log.txt" $(PWD)/$(BK2_FOLDER)/Subtitles.txt $(PWD)/$(BK2_FOLDER)/SyncSettings.json

#
# -- Task: describe-tas --
#
# >> Assign TAS infos <<
#
# Required variable
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
# Required variable
# TAS : Name of the tas (ex: any%)
# FILE : Name of the file (ex: 0-init.lua)
#
# Optional variable (see "Variables" section above for explanations)
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

# The next tasks will help to generate a youtube ready video after recording
# >> Recording parameters often used : A/V Writer => AVI Writer ; Compressor => Codec Intel IYUV <<

# GAME is the name of the first recording file without extension
# >> To prevent from errors (in make commands), you should avoid space into the name and prefer a slugified name

#
# -- Task: video-convert-avi-to-mp4 --
#
# >> Convert from avi video (from Bizhawk) to mp4 video (for youtube) using ffmpeg <<
#
# Required variable
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
# Required variable
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
# Required variable
# GAME : @see above
#

video-prepare-parts:
	@ls $(PWD)/$(PUBLICATION_FOLDER)/$(GAME)* | sed "s/^/file '/" | sed "s/$$/'/" > $(PWD)/$(PUBLICATION_FOLDER)/$(GAME)-video-parts.txt
#!/bin/bash

# 1. Build 'pacman.js' by concatenating files specified in js_order
# 2. Update time stamp in index.html
# 3. Build debug.html with individual script includes
# 4. Prepare the 'public' directory

OUTPUT="pacman.js"
PUBLIC_DIR="./public"
debug_includes="\n"

# Write header
echo "(function() {" > $OUTPUT

for file in \
    inherit.js \
    sound.js \
    random.js \
    game.js \
    direction.js \
    Map.js \
    colors.js \
    mapgen.js \
    atlas.js \
    renderers.js  \
    hud.js \
    galagaStars.js \
    Button.js \
    Menu.js \
    inGameMenu.js \
    sprites.js \
    Actor.js \
    Ghost.js \
    Player.js \
    actors.js \
    targets.js \
    ghostCommander.js \
    ghostReleaser.js \
    elroyTimer.js \
    energizer.js \
    fruit.js \
    executive.js \
    states.js \
    input.js \
    cutscenes.js \
    maps.js \
    vcr.js \
    main.js
do
    echo "// File: src/$file" >> $OUTPUT 
    cat src/$file >> $OUTPUT
    debug_includes="$debug_includes<script src=\"src/$file\"></script>\n"
done

# End anonymous function wrapper
echo "})();" >> $OUTPUT

# Update time stamp in index.html
sed -i "s/last updated:[^<]*/last updated: $(date) -->/" index.html

# Build debug.html from index.html adding debug includes
sed "s:.*$output.*:$debug_includes:" index.html > debug.html

# Prepare the public directory
rm -rf $PUBLIC_DIR
mkdir $PUBLIC_DIR

# Copy necessary files to public
cp index.html $PUBLIC_DIR/index.html
cp $OUTPUT $PUBLIC_DIR/pacman.js
cp -r font $PUBLIC_DIR/
cp -r sounds $PUBLIC_DIR/
cp -r icon $PUBLIC_DIR/
cp -r sprites $PUBLIC_DIR/

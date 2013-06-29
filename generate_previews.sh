#!/bin/sh
# This script is used to generate the previews needed by the mod
# It requires blender (2.6x is tested, but others versions might work)
# ...as well as pngcrush to reduce the size. If you don't want to use pngcrush, set PNGCRUSH=false below
PNGCRUSH=true
cd .previews
rm ../skins/textures/*_preview*.png # Remove all previous previews
mkdir -p output
for i in ../skins/textures/character_*.png;
do
	cp $i ./character.png
	blender --background character.blend \
		--render-output '//character_##.png' -a
	out_name=$(basename $i)
	out_name="${out_name%.*}"
	out_file=output/"$out_name"_preview.png
	back_out_file=output/"$out_name"_preview_back.png
	mv character_00.png $out_file
	mv character_01.png $back_out_file
	echo "Generated preview for $i"
done
if $PNGCRUSH
	then pngcrush -d ../skins/textures/ output/*_preview*.png
	else mv output/*_preview*.png ../skins/textures/
fi
echo "Generated previews !"

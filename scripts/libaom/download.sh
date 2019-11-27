# Script to download AV1 Codec Library's source code

# Exports SOURCES_DIR_libaom - path where actual sources are stored

echo "Using aom master branch"
AOM_SOURCES=aom
if [[ ! -d "$LAME_SOURCES" ]]; then
  git clone https://aomedia.googlesource.com/aom
fi

cd aom
git pull origin master
cd ..

export SOURCES_DIR_libaom=$(pwd)/${AOM_SOURCES}

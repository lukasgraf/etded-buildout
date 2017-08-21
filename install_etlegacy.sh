#!/bin/bash
set -euo pipefail

ETL_VERSION="etlegacy-v2.75-i386"
ETL_URL="https://www.etlegacy.com/download/file/85"
NQ_MOD_URL="http://wolffiles.de/filebase/ET/Mods/nq_v1-2-9_b6.zip"

TMPDIR="/tmp"
ETL_HOME="$HOME/etlegacy-server"
NQ_DIR=$ETL_HOME/nq

LAUNCH_SCRIPT="run_etlded.sh"


# Prevent script from accidentally being run in unexpected environment
if [ $(hostname) != "etlegacy" ]; then
    echo "Hostname is not 'etlegacy', aborting"
    exit 1
fi

# Abort if installation directory already exists
if [ -d "$ETL_HOME" ]; then
    echo "$ETL_HOME already exists, aborting"
    exit 1
fi

# Download ETLegacy Linux 32bit binaries
echo
echo "Downloading $ETL_URL to $TMPDIR/$ETL_VERSION.tar.gz"
echo
wget -O $TMPDIR/$ETL_VERSION.tar.gz $ETL_URL

# Extract .tar.gz to /tmp
tar xvpf $TMPDIR/$ETL_VERSION.tar.gz -C $TMPDIR

# Move extracted etlegacy directory to $ETL_HOME
rm $TMPDIR/$ETL_VERSION.tar.gz
mv $TMPDIR/$ETL_VERSION $ETL_HOME

# Store ET:Legacy server version for reference
echo "$ETL_VERSION" > $ETL_HOME/version.txt

# Download original game assets
TMP_ASSETS=$TMPDIR/etwolf-assets
TMP_ASSETS_ARCHIVE=$TMPDIR/et-linux-2.60.x86.run

echo
echo "Fetching Wolf:ET assets data files..."
echo
wget -O $TMP_ASSETS_ARCHIVE http://ftp.gwdg.de/pub/misc/ftp.idsoftware.com/idstuff/et/linux/et-linux-2.60.x86.run

#echo "Verifying assets data files integrity"
#sha256sum -c $checksum || exit 1

echo "Installing assets..."
echo
chmod +x $TMP_ASSETS_ARCHIVE
$TMP_ASSETS_ARCHIVE --noexec --target $TMP_ASSETS
rm -rf $TMP_ASSETS/{bin,Docs,README,pb,openurl.sh,CHANGES,ET.xpm} $TMP_ASSETS/setup.{data,sh} $TMP_ASSETS/etmain/{*.cfg,*.so,*.txt,*.dat,mp_bin.pk3}
cp -r $TMP_ASSETS/* $ETL_HOME/
rm -rf $TMP_ASSETS
rm -f $TMP_ASSETS_ARCHIVE

echo
echo "Installing NoQuarter Mod..."
TMP_NQ_DIST=$TMPDIR/nq-dist
wget -O $TMPDIR/nq.zip $NQ_MOD_URL
unzip $TMPDIR/nq.zip -d $TMP_NQ_DIST

mkdir $NQ_DIR
cp -r $TMP_NQ_DIST/* $NQ_DIR/
rm $NQ_DIR/*.dll
rm $TMPDIR/nq.zip
rm -rf $TMP_NQ_DIST

echo "Installing server configs..."
cp noquarter.cfg $NQ_DIR/
cp server.cfg $ETL_HOME/etmain/
cp mapvotecycle.cfg $NQ_DIR/

echo
echo "Installing launch script..."
cp $LAUNCH_SCRIPT $ETL_HOME/
echo

echo "All done!"
echo "======================================================================="
echo
echo "Launch ET:Legacy like this:"
echo "cd $ETL_HOME && ./$LAUNCH_SCRIPT"
echo
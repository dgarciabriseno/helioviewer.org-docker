API_DIR=/var/www-api/api.helioviewer.org
SITE_DIR=/var/www-api/docroot

unzip -qo 2021.zip -d /var/www-api/jp2
rm 2021.zip
# Set up site config and create local directories
cd $SITE_DIR
cp ~/app_config/Config.js resources/js/Utility/Config.js
su www-data -s /bin/bash -c 'mkdir -p log cache'

# Minify JS
cd $SITE_DIR/resources/build
chmod +x jsmin/jsmin.py
ant

# Set up jp2 file index
cd $API_DIR
ln -s /var/www-api/jp2 $API_DIR/docroot/jp2
mkdir docroot/cache
mkdir log

# Set up Kakadu inside the api folder.
cd $API_DIR/install/kakadu
su www-data -s /bin/bash -c 'tar zxvpf Kakadu_v6_4_1-00781N_Linux-64-bit-Compiled.tar.gz'
mv lib/* /usr/local/lib/
mv bin/* /usr/local/bin/
/sbin/ldconfig

# Set up API configuration files.
cd $API_DIR/settings
if ! [ -f "Config.ini" ]
then
    cp ~/app_config/Config.ini Config.ini
fi

if ! [ -f "Private.php" ]
then
    cp ~/app_config/Private.php Private.php
fi

cd $API_DIR/install
python3 install.py

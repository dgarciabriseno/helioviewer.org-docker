mamba activate hvstats
cd /var/www/api.helioviewer.org/scripts/hv_stats
mamba install -y mysqlclient
pip install -r requirements.txt
while [ 1 ]; do
    sh generate_bokeh_plots.sh
    sleep 600
done

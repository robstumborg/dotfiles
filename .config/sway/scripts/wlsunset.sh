#!/bin/bash
lat=$(pass meta -a wlsunset 'latitude')
lon=$(pass meta -a wlsunset 'longitude')

/usr/bin/wlsunset -l ${lat} -L ${lon}

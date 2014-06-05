#!/bin/bash
DST="barzahlen_virtuemart2_plugin_v1.1.6"
if [ -d $DST ]; then
rm -R $DST
fi
mkdir -p $DST
cp src/administrator/language/de-DE/de-DE.plg_vmpayment_barzahlen.ini $DST/de-DE.plg_vmpayment_barzahlen.ini
cp src/administrator/language/en-GB/en-GB.plg_vmpayment_barzahlen.ini $DST/en-GB.plg_vmpayment_barzahlen.ini
cp src/images/stories/virtuemart/payment/barzahlen.png $DST/barzahlen.png
cp readme.md $DST/readme.md
cp -r src/plugins/vmpayment/barzahlen/ $DST/
zip -r $DST.zip $DST/*
rm -R $DST
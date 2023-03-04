#!/bin/bash

date_file=/opt/monitoring/ups/ups_data.txt

/sbin/apcaccess > $date_file


#метрики
grep "BCHARGE" $date_file | awk '{print "battery_charge_ups "$3""}'
grep "TIMELEFT" $date_file | awk '{print "timeleft_battery_ups "$3""}'
grep "NOMBATTV" $date_file | awk '{print "nominal_battery_voltage_ups "$3""}'
grep "^BATTV" $date_file | awk '{print "battery_voltage_ups "$3""}'
#Количество переходов на питание от батареи с момента запуска APCUPSd
grep "NUMXFERS" $date_file | awk '{print "number_of_transfers_to_battery_ups "$3""}'


#если статус Online возвращает 1, если оффлайн или от баттаре, то 0
STATUS="$(grep "STATUS" $date_file | awk '{print ""$3""}')"
if [[ $STATUS == *"ONLINE"* ]]; then
  echo "status_ups 1"
else
  echo "status_ups 0"
fi

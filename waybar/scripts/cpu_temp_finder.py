#!/usr/bin/env python3

import os

def get_cpu_temp():
    hwmons = [d for d in os.listdir('/sys/class/hwmon') if d.startswith('hwmon')]
    for hwmon in hwmons:
        hwmon_path = os.path.join('/sys/class/hwmon', hwmon)
        name_file = os.path.join(hwmon_path, 'name')
        if os.path.isfile(name_file):
            with open(name_file, 'r') as f:
                name = f.read().strip()
            if name in ['coretemp']:
                temp_file = os.path.join(hwmon_path, 'temp1_input')
                if os.path.isfile(temp_file):
                    with open(temp_file, 'r') as f:
                        temp_millideg = int(f.read().strip())
                    return temp_millideg // 1000
    return 30

if __name__ == "__main__":
    temp = get_cpu_temp()
    print(temp)
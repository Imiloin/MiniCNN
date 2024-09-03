import numpy as np
import math
import struct



Linear_Out_Scale = 0.09915946424007416

# 创建一个 Linear_Out_int8 到 Sigmoid_Out_fp32 的 Sigmoid 查找表
lookup_table = {i: 1 / (1 + math.exp(-i * Linear_Out_Scale)) for i in np.arange(-128, 128)}

# 将查找表写入一个 txt 文件
with open('sigmoid_lookup_table.txt', 'w') as file:
    for key in sorted(lookup_table.keys(), key=lambda x: x & 0xFF):
        value = lookup_table[key]
        # file.write(f'{key}: {value}\n')
        
        key_hex = f'0x{key & 0xFF:02x}'
        value_hex = f'0x{struct.unpack("<I", struct.pack("<f", value))[0]:08x}'
        # file.write(f'{key_hex}: {value_hex}\n')
        
        res = value_hex[2:]  # 去掉 0x
        file.write(res + '\n')

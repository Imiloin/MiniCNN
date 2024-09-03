import os



def read_bias(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()
    # 只有1行
    for line in lines:
        bias = [int(x) for x in line.split()]

    return bias


# 供参考
def write_bias_hex(bias, file_path):
    hex_bias = []
    for dec in bias:  # 对于每个卷积核
        hex_bias.append(hex(dec & 0xFFFFFFFF)[2:].zfill(8))  # 转换为十六进制并拼接

    with open(file_path, 'w') as file:
        for line in hex_bias:
            file.write(line + '\n')

# 实际使用的（和参考相同）
def arrange_bias_hex(bias, file_path):
    hex_bias = []
    for dec in bias:  # 对于每个卷积核
        hex_bias.append(hex(dec & 0xFFFFFFFF)[2:].zfill(8))  # 转换为十六进制并拼接

    with open(file_path, 'w') as file:
        for line in hex_bias:
            file.write(line + '\n')


current_path = os.path.dirname(__file__)
bias = read_bias(os.path.join(current_path, 'Param', 'Param_PWConv_Bias.txt'))

print(len(bias))
print(bias[0])

# write_bias_hex(bias, os.path.join(current_path, '_Param_PWConv_Bias_hex.txt'))
arrange_bias_hex(bias, os.path.join(current_path, 'PWConv_Bias_arranged.txt'))

import os



def read_weights(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    weights = []
    for line in lines:
        weights.append([int(x) for x in line.split()])

    return weights


# 供参考
def write_weights_hex(weights, file_path):
    hex_weights = []
    for i in range(288):
        hex_weights_line = []
        for kernel in weights:  # 对于每个卷积核
            hex_weights_line.append(hex(kernel[i] & 0xFF)[2:].zfill(2))  # 转换为十六进制并拼接
        hex_weights.append(''.join(hex_weights_line))  # 将一行的权重拼接为一个字符串

    with open(file_path, 'w') as file:
        for line in hex_weights:
            file.write(line + '\n')

# 实际使用的
def arrange_weights_hex(weights, file_path):
    hex_weights = []
    for pos in range(9):
        for cnt in range(32):
            hex_weights_line = []
            for kernel in weights:  # 对于每个卷积核
                hex_weights_line.append(hex(kernel[9*cnt + pos] & 0xFF)[2:].zfill(2))  # 转换为十六进制并拼接
            hex_weights.append(''.join(hex_weights_line))  # 将一行的权重拼接为一个字符串

    with open(file_path, 'w') as file:
        for line in hex_weights:
            file.write(line + '\n')



current_path = os.path.dirname(__file__)
weights = read_weights(os.path.join(current_path, 'Param', 'Param_Linear_Weight.txt'))

print(len(weights))
print(weights[0])

# write_weights_hex(weights, os.path.join(current_path, '_Param_Linear_Weight_hex.txt'))
arrange_weights_hex(weights, os.path.join(current_path, 'Linear_Weight_arranged.txt'))

print("-------------")
print(weights[0][18*9+7])

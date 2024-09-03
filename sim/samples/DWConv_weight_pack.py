import os



def read_weights(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    weights = []
    kernel = []
    for line in lines:
        if line.strip() == "":
            weights.append(kernel)
            kernel = []
        else:
            kernel.append([int(x) for x in line.split()])

    # last kernel
    if kernel:
        weights.append(kernel)

    return weights


# 供参考
def write_weights_hex(weights, file_path):
    hex_weights = []
    for kernel in weights:  # 对于每个卷积核
        hex_weights_line = []
        for i in range(9):  # 对于每个3x3卷积核的9个位置
            hex_weights_line.append(hex(kernel[i//3][i%3] & 0xFF)[2:].zfill(2))  # 转换为十六进制并拼接
        hex_weights.append(''.join(hex_weights_line))  # 将一行的权重拼接为一个字符串

    with open(file_path, 'w') as file:
        for line in hex_weights:
            file.write(line + '\n')

# 实际使用的（和参考相同）
def arrange_weights_hex(weights, file_path):
    hex_weights = []
    for kernel in weights:  # 对于每个卷积核
        hex_weights_line = []
        for i in range(9):  # 对于每个3x3卷积核的9个位置
            hex_weights_line.append(hex(kernel[i//3][i%3] & 0xFF)[2:].zfill(2))  # 转换为十六进制并拼接
        hex_weights.append(''.join(hex_weights_line))  # 将一行的权重拼接为一个字符串

    with open(file_path, 'w') as file:
        for line in hex_weights:
            file.write(line + '\n')



current_path = os.path.dirname(__file__)
weights = read_weights(os.path.join(current_path, 'Param', 'Param_DWConv_Weight.txt'))

print(len(weights))
print(weights[0])

# write_weights_hex(weights, os.path.join(current_path, '_Param_DWConv_Weight_hex.txt'))
arrange_weights_hex(weights, os.path.join(current_path, 'DWConv_Weight_arranged.txt'))

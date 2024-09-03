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
        for i in range(11*7):  # 对于每个11x7卷积核的位置
            hex_weights_line.append(hex(kernel[i//7][i%7] & 0xFF)[2:].zfill(2))  # 转换为十六进制并拼接
        hex_weights.append(''.join(hex_weights_line))  # 将一行的权重拼接为一个字符串

    with open(file_path, 'w') as file:
        for line in hex_weights:
            file.write(line + '\n')
    

# 实际使用的
def arrange_weights_hex(weights, file_path):
    bin_weights = []
    for kernel in weights:  # 对于每个卷积核
        print(kernel[7//7][7%7])
        bin_weights_line = []
        for i in range(11*7):  # 对于每个11x7卷积核的位置
            bin_weights_line.append(bin(kernel[i//7][i%7] & 0b11111111)[2:].zfill(8))  # 转换为十六进制并拼接
        bin_weights.append(''.join(bin_weights_line))  # 将一行的权重拼接为一个字符串

    # 获取文件所在的目录
    directory = os.path.dirname(file_path)
    # 获取文件名（含后缀）
    base_name = os.path.basename(file_path)
    # 分割文件名和后缀名
    file_name, _ = os.path.splitext(base_name)
    
    for i in range(8):  # 写出8个文件
        with open(os.path.join(directory, file_name + '_{}.txt'.format(i)), 'w') as file:
            for line in bin_weights:
                data = line[i*11*7:(i+1)*11*7]
                file.write(data + '\n')



current_path = os.path.dirname(__file__)
weights = read_weights(os.path.join(current_path, 'Param', 'Param_Conv_Weight.txt'))

print(len(weights))
print(weights[0])

# write_weights_hex(weights, os.path.join(current_path, '_Param_Conv_Weight_hex.txt'))
arrange_weights_hex(weights, os.path.join(current_path, 'Conv_Weight_arranged.txt'))

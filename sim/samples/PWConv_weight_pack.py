import os



def read_weights(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    weights = []
    # kernel = []
    for line in lines:
        weights.append([int(x) for x in line.split()])

    return weights


# 供参考
def write_weights_hex(weights, file_path):
    hex_weights = []
    for kernel in weights:  # 对于每个卷积核
        hex_weights_line = [hex(x & 0xFF)[2:].zfill(2) for x in kernel]  # 转换为十六进制并拼接
        hex_weights.append(''.join(hex_weights_line))  # 将一行的权重拼接为一个字符串

    with open(file_path, 'w') as file:
        for line in hex_weights:
            file.write(line + '\n')

# 实际使用的
def arrange_weights_hex(weights, file_path):
    hex_weights = []
    for kernel in weights:  # 对于每个卷积核
        hex_weights_line = [hex(x & 0xFF)[2:].zfill(2) for x in kernel]  # 转换为十六进制并拼接
        hex_weights.append(''.join(hex_weights_line))  # 将一行的权重拼接为一个字符串

    # 获取文件所在的目录
    directory = os.path.dirname(file_path)
    # 获取文件名（含后缀）
    base_name = os.path.basename(file_path)
    # 分割文件名和后缀名
    file_name, _ = os.path.splitext(base_name)
    
    for i in range(2):  # 写出2个文件
        with open(os.path.join(directory, file_name + '_{}.txt'.format(i)), 'w') as file:
            for line in hex_weights:
                data = line[i*128//4:(i+1)*128//4]
                file.write(data + '\n')



current_path = os.path.dirname(__file__)
weights = read_weights(os.path.join(current_path, 'Param', 'Param_PWConv_Weight.txt'))

print(len(weights))
print(weights[0])

# write_weights_hex(weights, os.path.join(current_path, '_Param_PWConv_Weight_hex.txt'))
arrange_weights_hex(weights, os.path.join(current_path, 'PWConv_Weight_arranged.txt'))

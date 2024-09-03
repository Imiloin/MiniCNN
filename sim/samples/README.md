+ ./In : 此文件夹中为496个量化后尺寸为 (1,30,10) 输入Input MFCC，数据类型为int8。
+ ./Out : 此文件夹中为./in文件夹中的Input MFCC所对应的496个输出，数据类型为fp32，由于此输出使用了浮点Sigmoid进行计算，同学们在测试时输出可能与此文件夹中输出有一定误差，但误差应在可控范围内。
+ ./Param : 此文件夹中为网络参数。
    - Param_Conv_Bias.txt : 第一层卷积层Conv的Bias原尺寸为(32)，txt中储存为一维向量；
    - Param_Conv_Weight.txt : 第一层卷积层Conv的Weight原尺寸为(32,1,11,7)，txt中储存为32个(11,7)矩阵，元素间以空格分隔，每个矩阵间以空行分隔；
    - Param_DWConv_Bias.txt : 第二层卷积层DWConv的Bias原尺寸为(32)，txt中储存为一维向量；
    - Param_DWConv_Weight.txt : 第二层卷积层DWConv的Weight原尺寸为(32,1,3,3)，txt中储存为32个(3,3)矩阵，元素间以空格分隔，每个矩阵间以空行分隔；
    - Param_PWConv_Bias.txt : 第三层卷积层Conv的Bias原尺寸为(32)，txt中储存为一维向量；
    - Param_PWConv_Weight.txt : 第二层卷积层DWConv的Weight原尺寸为(32,32,1,1)，txt中储存为1个(32,32)矩阵，元素间以空格分隔；
    - Param_Linear_Bias.txt : 全连接层FC的Bias原尺寸为(2)，txt中储存为一维向量；
    - Param_Linear_Weight.txt : 第二层卷积层DWConv的Weight原尺寸为(2,288)，txt中储存为1个(2,288)矩阵，元素间以空格分隔。
+ ./Scale : 此文件夹中为量化与重量化相关参数。
    - Rescale.txt : 此文件中给定了未定点化的Rescale值M与定点化的n和M0值，2^{-n}*M0与M误差小于1%，若同学们感觉模拟精度不足，可自行给定n与M0值
    - Scale.txt : 此文件中给定了量化参数Scale，本次课程设计中仅需使用Linear_Out_Scale，全连接层输出的int8数据对应的fp32数据转换关系如下，Linear_Out_fp32 = Linear_Out_int8 * Linear_Out_Scale，此时即可将得到的Linear_Out_fp32作为Sigmoid层的输入，即Sigmoid_Out_fp32=1/(1+e^{-Linear_Out_fp32})，根据此关系可以直接设计Linear_Out_int8到Sigmoid_Out_fp32的查找表，也可以使用泰勒展开等方法设计Sigmoid，请同学们自行设计
+ ./test : 此文件夹中给定了一个Input MFCC经过每一层后的输出情况，方便同学们进行硬件调试
    - Input.txt : 输入尺寸为(1,30,10)
    - Out_Conv.txt ： 第一层卷积层Conv输出尺寸为(32,20,4)，txt中储存为32个(20,4)矩阵，元素间以空格分隔，每个矩阵间以空行分隔；
    - Out_DWConv.txt : 第二层卷积层DWConv输出尺寸为(32,18,2)，txt中储存为32个(18,2)矩阵，元素间以空格分隔，每个矩阵间以空行分隔；
    - Out_PWConv.txt : 第三层卷积层PWConv输出尺寸为(32,18,2)，txt中储存为32个(18,2)矩阵，元素间以空格分隔，每个矩阵间以空行分隔；
    - Out_Flatten.txt : 展平层输出尺寸为(288)，txt中存储为1个(288)向量；
    - Out_Linear.txt : 全连接层输出尺寸为(2)，txt中储存为1个(2)向量；
    - Out.txt : Sigmoid层输出尺寸为(2)，txt中储存为1个(2)向量。
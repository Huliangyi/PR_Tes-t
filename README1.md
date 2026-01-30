# 项目文档
2342424234
## 基本概念
-   [两段式接口](./context/两段式接口.md)
-   [数据结构](./context/数据结构.md)
-   [数据类型](./context/数据类型.md)
-   [数据格式](./context/数据格式.md)
-   [非连续的Tensor](./context/非连续的Tensor.md)
-   [broadcast关系](./context/broadcast关系.md)
-   [互推导关系](./context/互推导关系.md)
-   [互转换关系](./context/互转换关系.md)
-   [量化介绍](./context/量化介绍.md)
-   [sparse模式介绍](./context/sparse_mode参数说明.md)

## 算子清单

本项目提供的所有算子清单如下：

- 算子目录：每个目录承载了该算子所有的交付件，包括代码实现、算子example、算子文档等。

- 算子IR（Intermediate Representation）：表示算子原型，描述了算子输入、输出、属性等信息，包括数据类型、shape、数据格式等。算子清单中有部分算子定义了IR，表明可通过IR构图方式调用算子。

| 算子分类    | 算子目录                                     | 算子IR                                                                                           | 说明                             |
|---------|------------------------------------------|------------------------------------------------------------------------------------------------|---------------------------------|
| math    | abs                                      | [Abs](../math/abs/op_graph/abs_proto.h)                                                        | 实现张量的绝对值运算。        |
|math| add_lora                                 | [AddLora](../math/add_lora/op_graph/add_lora_proto.h)                                      |为神经网络添加LoRA（Low-Rank Adaptation）层功能，通过低秩分解减少参数数量。|
|math| angle_v2                                 | [AngleV2](../math/angle_v2/op_graph/angle_v2_proto.h)                                      |计算给定输入张量的element_wise angle（以弧度为单位）。|
|math| cast                                     | [Cast](../math/cast/op_graph/cast_proto.h)                                                 |实现张量数据类型转换。|
|math| diag_v2                                  | [DiagV2](../math/diag_v2/op_graph/diag_v2_proto.h)                                         |用于提取对角线元素或构造一个对角矩阵。|
|math| grouped_bias_add_grad                    | [GroupedBiasAddGrad](../math/grouped_bias_add_grad/op_graph/grouped_bias_add_grad_proto.h) |分组偏置加法（GroupedBiasAdd）的反向传播。|
|math| hans_decode                              | [HansDecode](../math/hans_decode/op_graph/hans_decode_proto.h)                             |对压缩后的张量基于PDF进行解码，同时基于mantissa重组回复张量。|
|math| hans_encode                              | [HansEncode](../math/hans_encode/op_graph/hans_encode_proto.h)                             |对输张量指数位所在字节实现PDF统计，按PDF分布统计进行无损压缩。|
|math| histogram_v2                             | [HistogramV2](../math/histogram_v2/op_graph/histogram_v2_proto.h)                          |计算张量值分布的函数。|
|math| [is_finite](../math/is_finite/README.md) | [IsFinite](../math/is_finite/op_graph/is_finite_proto.h)                                       | 判断张量中哪些元素是有限数值，即不是inf、-inf或nan。 |
|math| is_inf                                   | [IsInf](../math/is_inf/op_graph/is_inf_proto.h)                                            |判断张量中哪些元素是无限大值，即是inf、-inf。|
|math| lin_space                                | [LinSpace](../math/lin_space/op_graph/lin_space_proto.h)                                   |生成一个等间隔数值序列。|
|math| right_shift                              | [RightShift](../math/right_shift/op_graph/right_shift_proto.h)                             |对张量执行按位右移操作。|

## 算子接口（aclnn）

为方便调用算子，提供一套基于C的API（以aclnn为前缀API），无需提供IR（Intermediate Representation）定义，方便高效构建模型与应用开发，该方式也被称为“单算子API调用”，其详细介绍请参见[《AOL算子加速库接口》](https://hiascend.com/document/redirect/CannCommunityOplist)。

本项目提供的所有算子接口清单如下：

|    接口名   |      说明     |
|-----------|------------|
|[aclnnAbs](../math/abs/docs/aclnnAbs.md)|实现张量的绝对值运算。|
|[aclnnAddLora](../math/add_lora/docs/aclnnAddLora.md)|为神经网络添加LoRA（Low-Rank Adaptation）层功能，通过低秩分解减少参数数量。|
|[aclnnCast](../math/cast/docs/aclnnCast.md)|实现张量数据类型转换。|
|[aclnnGroupedBiasAddGrad](../math/grouped_bias_add_grad/docs/aclnnGroupedBiasAddGrad.md)|分组偏置加法（GroupedBiasAdd）的反向传播。|
|[aclnnHansDecode](../math/hans_decode/docs/aclnnHansDecode.md)|对压缩后的张量基于PDF进行解码，同时基于mantissa（尾数）重组回复张量。|
|[aclnnHansEncode](../math/hans_encode/docs/aclnnHansEncode.md)|对张量的指数位所在字节实现PDF统计，按PDF分布统计进行无损压缩。|
| [aclnnIsFinite](../math/is_finite/docs/aclnnIsFinite.md) | 判断张量中哪些元素是有限数值，即不是inf、-inf或nan。 |
| [aclnnIsInf](../math/is_inf/docs/aclnnIsInf.md) | 判断张量中哪些元素是无限大值，即是inf、-inf。 |
| [aclnnLinspace](../math/lin_space/docs/aclnnLinspace.md) | 生成一个等间隔数值序列。 |

## 图融合规则

使用图方式描述网络时，可采用图融合提升算子性能。图融合是指[GE（Graph Engine）](https://www.hiascend.com/cann/graph-engine)按融合规则进行改图的过程，使用融合后的算子替换融合前的算子。图融合详细介绍请参见[《图融合和UB融合规则参考》](https://hiascend.com/document/redirect/CannCommunitygraphubfusionref)。

本项目提供的所有融合规则清单如下：

|  规则名  |    说明    |
|---------|------------|
|[MatmulxxxPass](../math/xxx/xx.md)|待补充。|

## 算子开发指南

本章以`AddExample`算子为例，介绍算子具体的开发过程和交付件，开发者请根据实际算子功能自行修改代码实现。
- [AI Core算子开发指南](../docs/context/AI%20Core算子开发指南.md)
- [AI CPU算子开发指南](../docs/context/AI%20CPU算子开发指南.md)

## 算子调用

本章提供了常见的算子调用方式：

- aclnn调用算子 **（推荐）**：以aclnnXxx接口方式调用算子。
- 图模式调用算子：以IR构图方式调用算子。

开发者按需选择，不同方式下算子的调用流程和关键代码实现请参见[算子调用样例](./context/算子调用样例.md)。

## 算子调试调优

本章提供了三种算子调试方式和一种算子调优方式
开发者按需选择，具体细节可以参见[算子调试调优样例](./context/算子调试调优样例.md)。


## 参考文档

开发者学习过程中，可以访问如下产品文档，了解更多与算子开发、调用相关的知识。

- [《CANN 软件安装指南》](https://hiascend.com/document/redirect/CannCommunityInstSoftware)
- [《应用开发（C&C++）》](https://hiascend.com/document/redirect/CannCommunityInferWizard)
- [《Ascend C算子开发》](https://hiascend.com/document/redirect/CannCommunityAscendCQuick)
- [《AOL算子加速库接口》](https://hiascend.com/document/redirect/CannCommunityOplist)
- [《Ascend Graph开发指南》](https://hiascend.com/document/redirect/CannCommunityAscendGraph)
- [《图融合和UB融合规则参考》](https://hiascend.com/document/redirect/CannCommunitygraphubfusionref)

## 附录

[build参数说明](context/build参数说明.md)

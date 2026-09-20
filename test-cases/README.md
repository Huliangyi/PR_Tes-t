# 文件嵌入语法测试说明

## 测试目的

测试 GitHub 和 GitCode 是否支持文件嵌入（transclude/include）语法。

## 测试文件

- `main.md` - 主文件，包含各种嵌入语法
- `partial.md` - 被嵌入的片段文件

## 测试语法

| 语法 | 来源 |
|------|------|
| `<!-- @include: ./partial.md -->` | MPE 插件 |
| `:include(file=./partial.md)` | GitLab 系 |
| `[!INCLUDE [partial](./partial.md)]` | Azure DevOps |

## 预期结果

如果支持嵌入语法，`main.md` 中应该显示 `partial.md` 的内容。

如果不支持，只会显示原始的语法文本。

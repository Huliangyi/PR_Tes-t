# 文件嵌入语法测试

---

## 第一部分：用户反馈的语法

以下是用户反馈在 GitCode 上不支持的语法：

### 1. MPE 插件语法

<!-- @include: ./partial.md -->

**说明：** 在 VS Code 的 MPE 插件里能正常展开，在 GitCode 网页预览只会原样显示这行注释，不会加载文件内容。

### 2. 第三方插件语法（!import）

!import[./partial.md]

**说明：** 第三方插件语法，GitCode 不识别，直接当普通文本显示。

### 3. 第三方插件语法（include）

[include ./partial.md]

**说明：** 第三方插件语法，GitCode 不识别，直接当普通文本显示。

### 4. GitLab 系语法

:include(file=./partial.md)

**说明：** 极狐 GitLab 有这个扩展，GitCode（截至2026-05-27）未开放此功能，会原样渲染。

### 5. Azure DevOps 语法

[!INCLUDE [partial](./partial.md)]

**说明：** Azure DevOps / 微软文档系统语法，GitCode 不支持。

---

## 第二部分：补充测试语法

以下是我补充测试的其他语法格式：

### 6. MPE @import 语法

@import "./partial.md"

### 7. MPE @import（无路径前缀）

@import "partial.md"

### 8. MPE @include（无路径前缀）

<!-- @include: partial.md -->

### 9. GitLab 语法（带引号）

:include(file="partial.md")

---

## 测试说明

- 如果某种语法生效，会显示 `partial.md` 的内容（"这是被嵌入的内容"）
- 如果不生效，只会显示原始的语法文本

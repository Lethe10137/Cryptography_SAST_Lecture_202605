= Encode and Hash

概念辨析：

- 编码：  $text("Encode")(x) = y$,  $text("Decode")(y) = x$
- 哈希:   $text("Hash")(x) = y$,  Hopefully 不能从 $y$ 还原 $x$
- 对称加密： $text("Encrypt")(x, text("KEY")) = y$,  $text("Decrypt")(y, text("KEY")) = x$
- 非对称加密： $text("Encrypt")(x, text("KEY")_1) = y$,  $text("Decrypt")(y, text("KEY")_2) = x$
 

== Base64

解决的问题： 用一个「安全」的 ASCII 子集，表示任意二进制数据。

$2^6 = 64$, 用64字符之一`A..Za...z0...9+/`表示 6 个bit
- `url-safe` 版本： `A..Za...z0...9-_`

e.g. `0x59294e0b`

拆成bit, 即 `01011001 00101001 01001110 00001011`

按 6bit 拆分, #text(red)[补0] 

`010110 010010 100101 001110 000010 11`#text(red)[`0000`]

即 `22 18 37 14 02 48`   -> `WSlOCw`#text(red)[`==`]


---

在树洞上，你经常可以看到：

```
Re Louis: jc4MyQl0K/m9zF8j6WrYbbNVpvQmWtltWx6wcRbu
qYcpC0nPOUiwKo9IeOtFBV80E4qk3ugpPOFHg9eVn/5uFQs2wY
pa7MfVg78+Nll5zocJ16IdEzohT1ZcHxTjbRMykhtPhotpHv5e
YXQt2xM6Lxs6PAxBF0poEP8R7IxBVL4=

```

上述经 RSA 加密的密文本是二进制数据，不方便以文本方式传播。实践中常以 Base64 形式表示。

---

用 base64 来编码公钥（to be explained later)
#text(19pt)[
```
curl https://github.com/lethe10137.keys

ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDNs/uoDY57KZm81D/Tc2HDvbXSDdvj8q5CdCCEankdd
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOUSxVqUcdRS7vhFRHSRIjdbSMdmWAGofHhBzTa26Udy
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGXKNKzn4gJlQNV0XVYgztVUCnWTv2Q9W9vDOYMfmhgz
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHmoYIEgGa1jNuzQxM0pkt/y7XjsuPI/BZpdKMAqFofm
```]

*Base64 只是编码，不是加密！*

== MD5, SHA, Argon2

$text("Hash")(x) = y$,  Hopefully 不能从 $y$ 还原 $x$

哈希，也称 *消息摘要*， 希望对于任意长度的输入，给出一个固定长度的输出。
且
- *「密码学安全」*
  - Preimage resistance, 
  - Second preimage resistance,
  - Collision resistance
---

从工程上，我们希望哈希函数

- 确定性
- 输出均匀
- 雪崩效应：
  - `SHA256("天机常隐谁能算")=` #text(18pt)[`e37683e38429d4179fc36e71016a55ad50b2e136d442d1fb62b481318b1ef973`]
  - `SHA256("天机 常隐谁能算")=` #text(18pt)[`f15f337850a88aacf3e399bb64f51a69c22c20e1154cb04e6581701f878a73d3`]

---

- MD5、SHA-1 是经典算法，但已被证明不再安全 (Google: #link("https://www.google.com/search?&q=王小云+MD5")[王小云+MD5])

工程上，我们并不关心这些算法怎么实现：
- 通常用 *`SHA-256`* (属于 SHA-2 家族)
- Future proof: `SHA-3`
- 计算大文件： `BLAKE3`  (Google: #link("https://www.google.com/search?&q=Merkle Tree BLAKE3")[Merkle Tree BLAKE3])
- 「慢哈希」： *`Argon2`* 
  - 专为密码存储设计： 计算必须消耗大量内存和时间，抗 GPU/ASIC

密码学理想模型： *单向函数* (not to be covered)
---

应用：
- 检查完整性 
  - e.g. 将大文件在机器间复制后，是否出错而内容不一致？ 比较其 SHA256/BLAKE3 而不用逐字节比较
- commit
  - 如果对方能在 $t_0$ 给出一个文件的 hash, 而在 $t_1$ 时公布这个文件且 hash 校验通过
  - 我们可以相信对方在 $t_0$ 之前就生成了这个文件！
  - 上机考试传录屏

---
应用(续):
- 派生密钥
  - 用密码学安全的 Hash 函数，把来自真实世界的长度不定的熵转成特定长度
- 存储密码 （见后）
- HMAC 

== Case Study: RFC 2104 HMAC

#image("assets/2104_HMAC.png")

- 作用： 确保消息 $m$ 的完整性，且只有只有密钥$K$的人才能计算/校验这个 Hash


== Case Study: RFC6238 TOTP

常见的 2FA 方式。 (info.tsinghua.edu.cn 也支持！)

客户端和服务器共享一个 secret(常见 160-bit)。
- #strike[天知地知]你知我知的 $K$
- 两边共享 30s 粒度的时钟 $T$

$text("TOTP") = text("Truncate")(text("HMAC")(K,T)) $

与手机验证码对比（都是短时间有效的6位数）：
- 不依赖第三方（电信网络）的安全性！

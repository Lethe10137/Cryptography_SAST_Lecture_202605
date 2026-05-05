= Encryption

== DES, AES, Chacha20

$text("Encrypt")(x, text("KEY")) = y$,  $text("Decrypt")(y, text("KEY")) = x$

持有特定长度 `KEY` 的情况下，
- 输入： 任意长度的明文 $x$
- 输出： 加密后的 $y$, 且长度相当而一定不短于 $x$!

---

- DES: 被 AES 替代 (56-bit 密钥)
- *AES*: 密钥长度 128, 192, 256 bit
  - AES-128 + SHA-256 (128 bit 安全性)
  - AES-256 + SHA-512 (256 bit 安全性)
  - 首选： *AES-GCM / AES-CTR* 避免 ECB, CBC, CFB, OFB
- *Chacha20*: 
  - 抗侧信道， 容易实现

---
=== 例子： AES-CTR + MAC

怎样「安全」地在不安全（譬如微信）或公开（譬如树洞）信道上通信
-  #text(red)[C]onfidentiality
-  #text(red)[I]ntegrity
-  #text(red)[A]uthenticity

前提： Magically, 你和对方有 share-secret
- 对两个256bit长的随机bit串 $K_1, K_2$ #strike[天知地知]你知我知

---

1. 随机生成不重复的 nonce (避免重复结构泄漏, 固定长度)
2. 计算 $text("cipher") = text("AES-CTR")(K_1, text("nonce"), m)$
3. 计算 $text("tag") =  text("HMAC_SHA256")(K_2, text("nonce") || text("ciphertext"))$
4. 发送 $text("nonce") || text("ciphertext") || text("tag") $

对于不掌握 $K_1, K_2$ 的攻击者：

- Confidentiality: 只要 AES-CTR 安全，攻击者不能推出 m
- Integrity: 攻击者不能修改消息中的某部分而不被发现： 修改发送的消息中的任何部分，会导致接收方重新计算 tag 时不匹配
- Authenticity: 只有持有 $K_2$ 的人，才能计算这里的 tag


#import "@preview/touying:0.7.3": *

= Entrophy & Safety

古代的许多密码方案依赖「加密方案不为人知」

e.g.
- Pigpen Cipher    #box(image("assets/pigpen.png", height: 1em, width: 50%, fit: "cover"))   
- Polybius  #box(rect(fill: white, height: 1em, width: 18em)[#text(black)[
  GDDFAAFDGXDFAAGVAVDFDAFFFDDA]])

在现代计算机的算力面前，这些已经只作为解迷游戏的常客


---

== Kerckhoffs' principle 

The security of a cryptographic system shouldn't rely on the secrecy of the algorithm. 

现代的密码方案往往采用这样的结构：

- *锁* 公开的结构 （加解密算法） *可审计*
- *钥* 非公开的密钥, *可随时轮换*


- 公开通用，广受验证的锁 + 短生命周期的钥匙

== Security level in bits

*Defination*: 
一个密码方案是 `n-bit` 安全的，当目前已知的
最优攻击需要 $2^n$ 量级的基本操作。

e.g. Bitcoin 基于的 Secp256k1 椭圆曲线公钥加密使用一个 256 bit 的私钥

- 最朴素的攻击： 把 $2^256$ 个私钥全试一遍 
- 已知的最优攻击 Pollard's rho algorithm : 需要 $2^128$ 次操作，从公钥算出私钥


通常认为 Secp256k1 是 `128-bit` 安全的。

#pause

*在没有钥匙的情况下，最好的锁匠要尝试 $2^128$ 次才能打开*


== Entrophy in Information Theory

「*信息熵*」是 Shannon 给出的概念。

*Defination*: 
对以$P(X)$为概率质量函数的离散随机变量 $X$,  

$HH[X] = - EE[log P(X)] $  
是它的熵。
单位： bit

- e.g. 长度n的随机 bit 流（例如扔正反各 $1/2$的硬币的结果) 

$2^n$ 种可能各有 $2^(-n)$ 的概率，有 $- log(2^(-n)) =n $ bits 的熵  

*不可能用少于 n 个 bit 来描述这个随机 bit 流*

---

回顾之前「锁与钥匙」的比喻：

- 方案的 `128-bit` 安全： 没有钥匙的情况下，锁有多难开
- 密钥本身的 *熵*: 攻击者需要尝试的密钥空间有多大？

显然实际的安全性取决于以上二者的更小者。



== BIP39 Menmonic & Trust Wallet 




```python
import random
import time
random.seed(time.time())
print(random.randbytes(64).hex())
```
#text(size: 20pt)[
18cbf21a462b9319da29d5132cf5d1f7fbdc0f5a7d8178a24a72821e5c4f1030
02a9df9be4ed8a171753a1762280bd4f395c290962ffeea65f8caaa9888db07d
] 

有多少 bit 的熵？

#pause

*Observation*: 如果 $Y = f(X)$, 那么 $HH[Y] <= HH[X]$

由于 `time.time()` 大约是微秒级的精度，如果我们对`time.time()`有年粒度的先验

$log (10^6 times 3 times 10^7) approx log(2 ^45) =45 $ bit

---

*Case Study*:  CVE-2024-23660

Background: 存在以下的确定性的函数关系
$
 text("Random bits")  arrow text("BIP39 Menmonic") arrow text("Bitcoin private key")
$

每一步的映射至多保持熵，而不可能使熵增加！

- Binance Turst Wallet 曾用 #link("https://secbit.io/blog/en/2024/01/19/trust-wallets-fomo3d-summer-vuln/")[用时间戳当熵源]， 造成了 大约\$ 8.5M 的损失。 


---

多少 bit 的 entrophy 是足够的？

- 不再安全： `64-bit`
  - DES
  - `k2-*37#0=32`
- 主流标准： `128-bit` 
  - 12长度的 BIP39 助记词
  - `-Yy2C]]Bc^%`3Td`V&|4o`
- Future-proof: `256-bit`
  - 24长度的 BIP39 助记词
  - `@@}e/h)Y&$~t*7oMk>-7CI4/0jA>UG1,AV|iT'M~Xpq^U`

你的 info 密码足够强吗？
#import "@preview/touying:0.7.3": *
#import themes.university: *
#import "@preview/cetz:0.5.0"
#import "@preview/fletcher:0.5.8" as fletcher: node, edge
#import "@preview/numbly:0.1.0": numbly
#import "@preview/theorion:0.6.0": *
#import cosmos.clouds: *
#show: show-theorion

// cetz and fletcher bindings for touying
#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#show: university-theme.with(
  aspect-ratio: "16-9",
  // align: horizon,
  // config-common(handout: true),
  config-common(frozen-counters: (theorem-counter,)),  // freeze theorem counter for animation
  config-info(
    title: "Cryptography for Developers",
    subtitle: "2026 基础技能培训第二讲",
    author: "Lethe Lee",
    date: datetime.today(),
    institution: "SAST",
    contact: [lichenghao737\@gmail.com],
    logo: image("assets/favicon.png", width: 2cm, height: 2cm),
  ),
  config-colors(
    primary: rgb("#00ffc8"),
    secondary: rgb("#660874"),
    tertiary: rgb("#ff5078"),
  ),
)
#set page(fill: black)
#set text(fill: rgb("#dcdcdc"))

#set text(font: ("Linux Libertine O", "Noto Serif CJK SC"), lang: "zh")


#set heading(numbering: numbly("{1}.", default: "1.1"))

#title-slide()



== Outline <touying:hidden>

What's going to be covered:

- 对现代密码学常用技术的*使用*介绍
- 作为开发者应有的常识

What's not going to be covered:

- 密码学入门

---

#components.adaptive-columns(outline(title: none, indent: 1em))


#include "1_entrophy.typ"
#include "2_hash.typ"
#include "3_encrypt.typ"
#include "4_public.typ"
#include "5_examples.typ"


== 总结：开发者应有的密码学常识 <touying:hidden>


- 核心原则：不要自己发明算法 (Don't roll your own crypto)   
  - 安全性不应依赖于算法的秘密性 。  
  - 永远优先使用经过工业界验证的标准库和算法（如 AES-GCM, Argon2id, Ed25519) 。  
- 木桶效应：系统安全取决于最弱的一环   
  - 锁与钥匙：即便算法（锁）是 128-bit 安全的，如果密钥（钥匙）的熵不足（如使用时间戳），系统依然会崩溃 。  
- 承认人性的弱点：
  - 强制加盐(Salt)、使用慢哈希(Argon2id)以及推广 2FA 是开发者的基本修养 。  

---

- 技术赋权：
  - 现代密码学给了普通人在克苏鲁面前保持隐私的可能
  - 级联 SM4 与 AES ?
- 「共识」可能不需要建立在「信任」或「权威」之上
  - 公平洗牌
  - Crypocurrency
- Code is law, Math is Truth
- Don't trust, verify
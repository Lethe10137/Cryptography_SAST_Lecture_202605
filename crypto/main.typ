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

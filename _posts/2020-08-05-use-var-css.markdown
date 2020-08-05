---
layout: post
title: "Using variable in CSS"
date: 2020-08-05 18:07:30 +0545
tags: [css, TIL]
categories: [css]
---

In CSS, we apply background color or font color as following: 

```css
.class-name {
  color: #ffffff;
  background-color: #000000;
}
```

Soon, the hex code would be scattered in different places. And if the hex code needs to change, then we have to adjust to so many different places. But, there is a simpler method that I learned today using `var` to declare the variable in the CSS.

```css
:root {
  --myThemeColor: #ffffff;
}

.class-name {
  color: var(--myThemeColor, blue)
}
```

To use `var`, we have to define a variable with a prefix(`--`) in the root selector. And use the var method as mentioned above. The second option is the fallback option if we have not defined the variable in the root selector.


Reference:
[W3Schools](https://www.w3schools.com/css/css3_variables.asp)
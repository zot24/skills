---
version: alpha
name: Placeholder
description: Neutral starting tokens. The site-design-options skill replaces this file at the lock (stage 6).
colors:
  primary: "#111111"
  on-primary: "#FFFFFF"
  neutral: "#FAFAFA"
  muted: "#6B6B6B"
  accent: "#2F5BEA"
typography:
  h1:
    fontFamily: system-ui
    fontSize: 3rem
    fontWeight: 700
    lineHeight: 1.1
  body-md:
    fontFamily: system-ui
    fontSize: 1rem
    lineHeight: 1.6
rounded:
  sm: 4px
  md: 8px
spacing:
  sm: 8px
  md: 16px
  lg: 32px
components:
  button-primary:
    backgroundColor: "{colors.primary}"
    textColor: "{colors.on-primary}"
    rounded: "{rounded.md}"
    padding: 12px
  page:
    backgroundColor: "{colors.neutral}"
    textColor: "{colors.primary}"
  caption:
    textColor: "{colors.muted}"
  link:
    textColor: "{colors.accent}"
---

## Overview

Placeholder. Lock date, the owner's words and the one rule go here when the look is locked:
any change to the look edits this file first, then `pnpm design:tokens`.

## Colors

- **Primary (#111111):** text and the primary button.
- **Accent (#2F5BEA):** links only.

## Typography

System font stack until the lock picks real faces.

## Do's and Don'ts

- Do keep the conversion action above the fold at 375 px.
- Don't hand-edit `src/styles/theme.css`; it is exported from this file.

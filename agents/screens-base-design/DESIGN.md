---
name: Lumen Link
colors:
  surface: '#051424'
  surface-dim: '#051424'
  surface-bright: '#2c3a4c'
  surface-container-lowest: '#010f1f'
  surface-container-low: '#0d1c2d'
  surface-container: '#122131'
  surface-container-high: '#1c2b3c'
  surface-container-highest: '#273647'
  on-surface: '#d4e4fa'
  on-surface-variant: '#c7c4d7'
  inverse-surface: '#d4e4fa'
  inverse-on-surface: '#233143'
  outline: '#908fa0'
  outline-variant: '#464554'
  surface-tint: '#c0c1ff'
  primary: '#c0c1ff'
  on-primary: '#1000a9'
  primary-container: '#8083ff'
  on-primary-container: '#0d0096'
  inverse-primary: '#494bd6'
  secondary: '#ffb2b7'
  on-secondary: '#67001b'
  secondary-container: '#b50036'
  on-secondary-container: '#ffc2c4'
  tertiary: '#ffb783'
  on-tertiary: '#4f2500'
  tertiary-container: '#d97721'
  on-tertiary-container: '#452000'
  error: '#ffb4ab'
  on-error: '#690005'
  error-container: '#93000a'
  on-error-container: '#ffdad6'
  primary-fixed: '#e1e0ff'
  primary-fixed-dim: '#c0c1ff'
  on-primary-fixed: '#07006c'
  on-primary-fixed-variant: '#2f2ebe'
  secondary-fixed: '#ffdadb'
  secondary-fixed-dim: '#ffb2b7'
  on-secondary-fixed: '#40000d'
  on-secondary-fixed-variant: '#92002a'
  tertiary-fixed: '#ffdcc5'
  tertiary-fixed-dim: '#ffb783'
  on-tertiary-fixed: '#301400'
  on-tertiary-fixed-variant: '#703700'
  background: '#051424'
  on-background: '#d4e4fa'
  surface-variant: '#273647'
typography:
  display:
    fontFamily: Inter
    fontSize: 34px
    fontWeight: '700'
    lineHeight: 41px
    letterSpacing: -0.02em
  headline:
    fontFamily: Inter
    fontSize: 22px
    fontWeight: '600'
    lineHeight: 28px
    letterSpacing: -0.01em
  subheadline:
    fontFamily: Inter
    fontSize: 17px
    fontWeight: '600'
    lineHeight: 22px
  body:
    fontFamily: Inter
    fontSize: 17px
    fontWeight: '400'
    lineHeight: 24px
  callout:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 21px
  caption:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
    letterSpacing: 0.01em
  mono:
    fontFamily: jetbrainsMono
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  margin-page: 1.25rem
  gutter-card: 1rem
  stack-gap-lg: 1.5rem
  stack-gap-md: 0.75rem
  stack-gap-sm: 0.5rem
---

## Brand & Style
The brand personality is efficient, precise, and native-first. It targets power users and developers who value a tool that feels like a built-in part of the iOS ecosystem. The UI evokes a sense of "premium utility"—fast, reliable, and visually quiet. 

The design style is **Modern Apple-esque Minimalism**. It leverages deep blacks, generous negative space, and a high-contrast palette to ensure legibility. The aesthetic prioritizes Swift UI patterns, using subtle tonal shifts instead of heavy shadows to define structure, creating a sophisticated, high-performance tool for link management.

## Colors
The palette is optimized for OLED displays, utilizing a true black (#000000) base to maximize contrast and reduce power consumption. 

- **Primary (Indigo):** Used for primary action buttons, active states, and branded highlights.
- **Secondary (Rose):** Reserved strictly for destructive actions like "Delete Link" or "Clear History."
- **Neutral (Slate):** Used for secondary text, metadata (like timestamps), and inactive icons.
- **Text:** Primary text is pure white (#FFFFFF) for maximum readability against the dark background.

## Typography
The system uses **Inter** (as the closest web-equivalent to SF Pro) to maintain a clean, humanist feel with high legibility. 

- **Display & Headlines:** Use tighter letter spacing and semi-bold/bold weights to command attention.
- **Body Text:** Standardized at 17px to match iOS HIG expectations for comfortable reading.
- **Monospaced:** JetBrains Mono is used specifically for the shortened URLs and API keys, providing a clear visual distinction for technical strings.

## Layout & Spacing
The layout follows a **Fixed Grid** model optimized for mobile viewports. It relies on a standard 16px–20px lateral margin. 

- **Card-Based List:** Link entries are encapsulated in cards that span the full width minus side margins.
- **Vertical Rhythm:** A consistent 8px-based scale (4, 8, 12, 16, 24, 32) is used for all padding and gaps.
- **SafeArea:** All layouts must respect the top notch and bottom home indicator areas, using large navigation titles that collapse on scroll.

## Elevation & Depth
Depth is created through **Tonal Layering** rather than traditional shadows. This ensures a clean, modern "glass" feel common in high-end SwiftUI apps.

- **Level 0 (Base):** True black (#000000) for the main application background.
- **Level 1 (Cards/Inputs):** A deep charcoal (#1c1c1e) for interactive surfaces and containers.
- **Level 2 (Modals/Popovers):** A slightly lighter gray (#2c2c2e) to indicate proximity to the user.
- **Outlines:** A thin, 0.5pt stroke (#38383a) is applied to cards to define edges on dark backgrounds without adding visual weight.

## Shapes
The shape language is friendly yet structured. Primary containers use a **12px–16px radius** (the "Rounded" setting) to echo the curvature of the hardware corners of the iPhone.

- **Large Cards:** 16px corner radius.
- **Buttons & Inputs:** 12px corner radius.
- **Small Chips:** Fully rounded (pill) for status indicators like "Active" or "Expired."

## Components
Consistent styling across the application:

- **Buttons:** Primary buttons are Indigo (#6366f1) with white text. They should have a minimum height of 50px for touch ergonomics. Use a subtle scale-down effect (0.97) on tap.
- **Input Fields:** Background should be #1c1c1e with a 12px corner radius. The placeholder text uses Slate-400. Focus state is indicated by a 2px Indigo border.
- **Link Cards:** Contain a JetBrains Mono shortened URL (Indigo), the original URL (Slate-400), and a trailing chevron or copy icon.
- **Chips:** Small, low-contrast pills (Background: #2c2c2e) for tags or categories.
- **Context Menus:** Use standard iOS system blurs and menus for link actions (Edit, Share, QR Code, Delete).
- **Empty States:** Use centered, ghost-style icons in Slate-400 with a clear "Create Link" call to action.
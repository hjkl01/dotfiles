# Zellij Low-Overhead Configuration Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Configure Zellij to match tmux's low-overhead path by optimizing mouse handling, clipboard/OSC52, and background tasks.

**Architecture:** Direct modification of `zellij.kdl` to toggle performance-critical settings and bypass WASM-based overhead where possible.

**Tech Stack:** Zellij (KDL configuration).

---

### Task 1: Mouse Handling Optimization

**Files:**
- Modify: `/home/ljl/.dotfiles/config/zellij.kdl`

- [ ] **Step 1: Disable mouse hover effects and copy-on-select**

Edit `/home/ljl/.dotfiles/config/zellij.kdl`:
```kdl
// Find and update these lines:
mouse_mode true
mouse_hover_effects false
copy_on_select false
```

- [ ] **Step 2: Verify configuration syntax**

Run: `zellij setup --check` (if available) or simply prepare for launch.

- [ ] **Step 3: Commit changes**

```bash
git add config/zellij.kdl
git commit -m "perf: disable zellij mouse hover effects and auto-copy"
```

### Task 2: Clipboard & OSC52 Optimization

**Files:**
- Modify: `/home/ljl/.dotfiles/config/zellij.kdl`

- [ ] **Step 1: Set explicit copy command and clipboard destination**

Edit `/home/ljl/.dotfiles/config/zellij.kdl`:
```kdl
// Update copy_command based on OS (e.g., pbcopy for macOS, wl-copy for Wayland)
copy_command "pbcopy" 
copy_clipboard "system"
```

- [ ] **Step 2: Commit changes**

```bash
git add config/zellij.kdl
git commit -m "perf: use native copy_command for lower clipboard latency"
```

### Task 3: UI & Rendering Simplification

**Files:**
- Modify: `/home/ljl/.dotfiles/config/zellij.kdl`

- [ ] **Step 1: Disable pane frames and enable simplified UI**

Edit `/home/ljl/.dotfiles/config/zellij.kdl`:
```kdl
pane_frames false
simplified_ui true
```

- [ ] **Step 2: Commit changes**

```bash
git add config/zellij.kdl
git commit -m "perf: simplify zellij UI and disable pane frames"
```

### Task 4: System Performance Optimization

**Files:**
- Modify: `/home/ljl/.dotfiles/config/zellij.kdl`

- [ ] **Step 1: Disable session serialization**

Edit `/home/ljl/.dotfiles/config/zellij.kdl`:
```kdl
session_serialization false
```

- [ ] **Step 2: Commit changes**

```bash
git add config/zellij.kdl
git commit -m "perf: disable zellij session serialization to reduce background I/O"
```

### Task 5: Verification

- [ ] **Step 1: Launch Zellij and monitor CPU**

Run: `zellij`
Action: Move mouse rapidly across panes.
Expected: No significant CPU spikes in `top`/`htop`.

- [ ] **Step 2: Verify Clipboard**

Action: Select text and paste into another application.
Expected: Immediate availability in system clipboard.

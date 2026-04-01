# 2026-04-01 Zellij to Tmux-like Low-Overhead Path Design

## Context
用户反馈 tmux 无卡顿，需要提炼 tmux 默认行为与 zellij 的关键差异，并给出迁移建议，使 zellij 配置尽量贴近 tmux 的低开销路径。

## Analysis: Tmux vs Zellij Key Differences

### 1. Mouse Handling
- **Tmux**: 鼠标事件在 C 编写的服务器端直接处理，主循环高效转译。默认不开启 `mouse_hover_effects`。
- **Zellij**: 鼠标事件通过 WASM 插件系统分发。默认开启 `mouse_hover_effects`，导致鼠标移动时 WASM 插件频繁触发 UI 更新计算，产生 CPU 抖动。

### 2. Clipboard & OSC52
- **Tmux**: 倾向于 `passthrough` 模式，直接将 OSC52 序列转发给终端模拟器。
- **Zellij**: 内部管理剪贴板缓冲，且在某些环境下通过 WASM 插件转发可能存在微小延迟。

### 3. Background Tasks
- **Tmux**: 极少后台写操作。
- **Zellij**: 默认开启 `session_serialization`，定期进行磁盘 I/O，可能与主线程产生资源竞争。

## Proposed Design: "Low-Overhead" Zellij Configuration

### Section 1: Mouse Optimization
- **Action**: Disable hover effects and auto-copy.
- **Config**:
  ```kdl
  mouse_mode true
  mouse_hover_effects false
  copy_on_select false
  ```
- **Impact**: Eliminates CPU spikes during mouse movement.

### Section 2: Clipboard & OSC52 Optimization
- **Action**: Use native system clipboard commands to bypass internal buffering.
- **Config**:
  ```kdl
  copy_command "pbcopy" // or wl-copy / xclip
  copy_clipboard "system"
  ```
- **Impact**: Faster, more reliable clipboard operations.

### Section 3: Rendering & UI Simplification
- **Action**: Remove complex UI elements.
- **Config**:
  ```kdl
  pane_frames false
  simplified_ui true
  ```
- **Impact**: Reduces rendering overhead and Unicode parsing complexity.

### Section 4: System Performance
- **Action**: Disable session serialization.
- **Config**:
  ```kdl
  session_serialization false
  ```
- **Impact**: Eliminates periodic disk I/O lag.

## Migration Suggestions (3-5 Actionable Items)

1. **Disable Mouse Hover Effects**: `mouse_hover_effects false`. 
   - *Effect*: Eliminates the primary source of lag during mouse movement.
   - *Side Effect*: No visual highlight when hovering over panes.
2. **Explicit Copy Command**: Set `copy_command` to your OS native tool.
   - *Effect*: Bypasses WASM-based clipboard handling for lower latency.
   - *Side Effect*: Requires system-level tool installation.
3. **Disable Session Serialization**: `session_serialization false`.
   - *Effect*: Prevents background I/O from interrupting the main loop.
   - *Side Effect*: Sessions cannot be resurrected after a crash/restart.
4. **Simplified UI & No Frames**: `simplified_ui true` and `pane_frames false`.
   - *Effect*: Reduces rendering complexity to match tmux's minimalist style.
   - *Side Effect*: Less "modern" look, no visual separation between panes.

## Verification Plan
1. Apply the configuration changes to `zellij.kdl`.
2. Monitor CPU usage during rapid mouse movement.
3. Verify OSC52 clipboard functionality in SSH sessions.

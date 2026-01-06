# Spec-Kit In Action

> **Học Spec-Driven Development qua thực hành**

Chào mừng bạn đến với tài liệu hướng dẫn **Spec-Kit** - toolkit giúp bạn phát triển phần mềm một cách có hệ thống, predictable và dễ maintain.

---

## Spec-Kit là gì?

**Spec-Kit** là open-source toolkit cho phương pháp **Spec-Driven Development** - nơi specification (đặc tả) là trung tâm, không phải code.

```
Vibe Coding (truyền thống):
  Idea → Code → Fix → Rewrite → Fix again...

Spec-Driven Development:
  Idea → Spec → Plan → Tasks → Code (một lần, đúng)
```

---

## Tại sao cần Spec-Kit?

<div class="chapter-cards">
  <div class="chapter-card getting-started">
    <h3>🎯 Rõ ràng từ đầu</h3>
    <p>Định nghĩa WHAT trước, HOW sau. AI hiểu chính xác bạn muốn gì.</p>
  </div>
  <div class="chapter-card concepts">
    <h3>🤖 Tích hợp AI</h3>
    <p>Hỗ trợ 17+ AI coding agents: Claude, Cursor, Copilot, Windsurf...</p>
  </div>
  <div class="chapter-card examples">
    <h3>📝 Tự động tài liệu</h3>
    <p>Specs trở thành living documentation, luôn up-to-date.</p>
  </div>
  <div class="chapter-card best-practices">
    <h3>✅ Code chất lượng</h3>
    <p>Ít bugs, ít refactor, dễ maintain và scale.</p>
  </div>
</div>

---

## Workflow Cơ Bản

```
┌─────────────────────────────────────────────────────────┐
│  /speckit.constitution   →   Định nghĩa project rules   │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│  /speckit.specify        →   Viết requirements          │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│  /speckit.plan           →   Technical approach         │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│  /speckit.tasks          →   Actionable task list       │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│  /speckit.implement      →   Execute & code             │
└─────────────────────────────────────────────────────────┘
```

---

## Các Chương

### 📖 [Chương 1: Bắt Đầu](getting-started.md)
Cài đặt Spec-Kit, tạo project đầu tiên, workflow cơ bản.

### 📖 [Chương 2: Khái Niệm Cốt Lõi](core-concepts.md)
Hiểu sâu về Specification, Constitution, Plan, Tasks.

### 📖 [Chương 3: Ví Dụ Thực Tế](practical-examples.md)
Xây dựng Task Manager App từ đầu đến cuối.

### 📖 [Chương 4: Best Practices](best-practices.md)
Tips, patterns, và các bài học từ thực tế.

---

## Quick Start

```bash
# Cài đặt
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git

# Tạo project mới
specify init my-project --ai claude

# Mở và bắt đầu
cd my-project
claude
```

Sau đó sử dụng các slash commands:
- `/speckit.constitution` - Thiết lập project rules
- `/speckit.specify` - Viết specifications
- `/speckit.plan` - Tạo technical plan
- `/speckit.tasks` - Chia thành tasks
- `/speckit.implement` - Bắt đầu code

---

## Yêu Cầu

- Python 3.11+
- Git
- UV package manager
- AI coding agent (Claude Code, Cursor, Copilot, etc.)

---

## Tài Liệu Này Dành Cho Ai?

- **Developers** muốn học cách làm việc hiệu quả với AI coding assistants
- **Teams** muốn standardize workflow và giảm tech debt
- **Beginners** muốn học best practices từ đầu

---

<div class="quick-links">
  <a href="getting-started.md">🚀 Bắt đầu ngay</a>
  <a href="https://github.com/github/spec-kit">📦 GitHub Repo</a>
  <a href="core-concepts.md">📚 Đọc tài liệu</a>
</div>

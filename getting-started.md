# Spec-Kit: Bắt Đầu Nhanh

> **Spec-Kit** là toolkit giúp bạn phát triển phần mềm theo phương pháp **spec-driven development** - nơi specification (đặc tả) là trung tâm, không phải code.

---

## Mục Tiêu Học Tập

Sau khi hoàn thành chương này, bạn sẽ:

- ✅ Hiểu được **vấn đề** mà Spec-Kit giải quyết
- ✅ Cài đặt thành công **UV** và **Spec-Kit**
- ✅ Tạo được **project đầu tiên** với spec-kit
- ✅ Sử dụng được **5 slash commands** cơ bản
- ✅ Biết cách **xử lý các lỗi** thường gặp

**Thời gian đọc:** ~20 phút | **Thời gian thực hành:** ~30 phút

---

## Version Compatibility

| Component | Minimum Version | Recommended |
|-----------|-----------------|-------------|
| Python | 3.11+ | 3.12 |
| UV | 0.4+ | Latest |
| Git | 2.30+ | Latest |
| Node.js | 18+ (nếu dùng JS/TS) | 20 LTS |

**Spec-Kit Version:** Tài liệu này viết cho spec-kit từ GitHub repo (January 2025).

> ⚠️ **Lưu ý:** Các ví dụ output trong tài liệu là **minh họa**. Output thực tế có thể khác tùy theo version và cấu hình của bạn.

---

## Vấn Đề

Bạn đã bao giờ gặp tình huống này chưa?

```
Bạn: "AI ơi, tạo cho tôi một app todo"
AI: *tạo ra 500 dòng code*
Bạn: "Không, tôi muốn có filter theo ngày"
AI: *viết lại 300 dòng*
Bạn: "Quên mất, cần thêm authentication"
AI: *refactor toàn bộ*
```

Đây là **vibe coding** - code theo cảm hứng, không có kế hoạch rõ ràng. Kết quả? Lãng phí thời gian, code khó maintain.

---

## Giải Pháp: Spec-Driven Development

Spec-Kit đảo ngược quy trình:

```
1. Định nghĩa WHAT (cái gì) → Specification
2. Lên kế hoạch HOW (như thế nào) → Plan
3. Chia nhỏ tasks → Task List
4. Implement từng phần → Code
```

**Kết quả**: Code predictable, dễ maintain, ít phải refactor.

---

## Cài Đặt

### Yêu Cầu Hệ Thống
- Python 3.11+
- Git
- UV package manager
- Một AI coding agent (Claude Code, Cursor, Copilot, etc.)

### Cài Đặt UV (nếu chưa có)

```bash
# Windows (PowerShell)
powershell -c "irm https://astral.sh/uv/install.ps1 | iex"

# macOS/Linux
curl -LsSf https://astral.sh/uv/install.sh | sh
```

### Cài Đặt Spec-Kit

**Cách 1: Cài đặt vĩnh viễn (khuyến nghị)**
```bash
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
```

**Cách 2: Chạy một lần (test thử)**
```bash
uvx --from git+https://github.com/github/spec-kit.git specify init my-project
```

---

## Xác Nhận Cài Đặt

Sau khi cài đặt, chạy các lệnh sau để đảm bảo mọi thứ hoạt động:

### Bước 1: Kiểm tra UV

```bash
uv --version
```

**Kết quả mong đợi:**
```
uv 0.5.x (hoặc cao hơn)
```

### Bước 2: Kiểm tra Spec-Kit

```bash
specify --version
```

**Kết quả mong đợi:**
```
specify-cli x.x.x
```

### Bước 3: Kiểm tra tools đã cài

```bash
specify check
```

**Kết quả mong đợi:**
```
✓ git: installed
✓ python: 3.11+
✓ uv: installed
✓ claude: installed (hoặc AI agent bạn dùng)
```

### Bước 4: Test tạo project

```bash
specify init test-project --ai claude
```

Nếu folder `test-project/` được tạo với cấu trúc `.speckit/`, bạn đã sẵn sàng!

```bash
# Xóa project test sau khi kiểm tra
rm -rf test-project  # Linux/macOS
rmdir /s test-project  # Windows
```

---

## Troubleshooting - Xử Lý Lỗi Thường Gặp

### Lỗi: `uv: command not found`

**Nguyên nhân:** UV chưa được cài đặt hoặc chưa được thêm vào PATH.

**Giải pháp:**

```bash
# Cài đặt lại UV
# Windows (PowerShell - chạy với quyền Admin)
powershell -c "irm https://astral.sh/uv/install.ps1 | iex"

# macOS/Linux
curl -LsSf https://astral.sh/uv/install.sh | sh

# Sau đó restart terminal hoặc chạy:
source ~/.bashrc  # Linux
source ~/.zshrc   # macOS với zsh
```

**Windows - Thêm vào PATH thủ công:**
1. Tìm folder UV (thường là `%USERPROFILE%\.local\bin`)
2. Thêm vào System Environment Variables → Path

---

### Lỗi: `specify: command not found`

**Nguyên nhân:** Spec-Kit chưa cài đặt thành công.

**Giải pháp:**

```bash
# Kiểm tra UV tools đã cài
uv tool list

# Nếu không thấy specify-cli, cài lại:
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git --force

# Đảm bảo UV bin directory trong PATH
# Thêm vào ~/.bashrc hoặc ~/.zshrc:
export PATH="$HOME/.local/bin:$PATH"
```

---

### Lỗi: `Permission denied` (Linux/macOS)

**Nguyên nhân:** Không có quyền ghi vào thư mục cài đặt.

**Giải pháp:**

```bash
# KHÔNG dùng sudo với uv tool install
# Thay vào đó, đảm bảo thư mục home có quyền đúng:
chmod -R u+rw ~/.local

# Thử cài lại
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
```

---

### Lỗi: `Python 3.11+ required`

**Nguyên nhân:** Python version quá cũ.

**Giải pháp:**

```bash
# Kiểm tra version hiện tại
python --version
python3 --version

# Cài Python mới
# Windows: Download từ python.org
# macOS: brew install python@3.12
# Ubuntu: sudo apt install python3.12
```

---

### Lỗi: `git: command not found`

**Nguyên nhân:** Git chưa được cài đặt.

**Giải pháp:**

```bash
# Windows
winget install Git.Git

# macOS
brew install git

# Ubuntu/Debian
sudo apt install git
```

---

### Lỗi: `Network error` hoặc `Connection refused`

**Nguyên nhân:** Không thể kết nối tới GitHub.

**Giải pháp:**

```bash
# Kiểm tra kết nối
ping github.com

# Nếu dùng proxy, cấu hình cho git:
git config --global http.proxy http://proxy.company.com:8080

# Nếu dùng VPN, thử tắt VPN và cài lại
```

---

### Lỗi: Slash commands không hoạt động

**Nguyên nhân:** Project chưa được init đúng cách hoặc AI agent không hỗ trợ.

**Giải pháp:**

```bash
# Kiểm tra đang ở trong project folder
ls -la .speckit/  # Phải thấy folder này

# Nếu không có, init lại:
specify init . --ai claude --force

# Đảm bảo AI agent được hỗ trợ:
# claude, cursor-agent, copilot, gemini, windsurf, qwen, etc.
```

---

### Vẫn gặp lỗi?

1. **Kiểm tra GitHub Issues:** [github.com/github/spec-kit/issues](https://github.com/github/spec-kit/issues)
2. **Xem logs chi tiết:**
   ```bash
   uv tool install specify-cli --from git+https://github.com/github/spec-kit.git --verbose
   ```
3. **Cài đặt từ source:**
   ```bash
   git clone https://github.com/github/spec-kit.git
   cd spec-kit
   uv pip install -e .
   ```

---

## Hello World: Tạo Project Đầu Tiên

### Bước 1: Khởi tạo project

```bash
specify init todo-app --ai claude
```

Lệnh này sẽ:
- Tạo folder `todo-app/`
- Cấu hình cho Claude Code
- Tạo cấu trúc spec-kit cơ bản

### Bước 2: Xem cấu trúc được tạo

```
todo-app/
├── .speckit/
│   ├── constitution.md    # Nguyên tắc phát triển
│   ├── specs/             # Các specification
│   ├── plans/             # Các technical plan
│   └── tasks/             # Task lists
├── src/                   # Source code (sẽ được generate)
└── README.md
```

### Bước 3: Mở project với AI agent

```bash
cd todo-app
claude  # hoặc cursor, copilot, etc.
```

---

## Workflow Cơ Bản

Sau khi mở project với AI agent, sử dụng các slash commands:

### 1. Thiết lập Constitution (một lần duy nhất)

```
/speckit.constitution
```

AI sẽ hỏi bạn về:
- Tech stack muốn dùng
- Coding conventions
- Các nguyên tắc phát triển

**Ví dụ output:**
```markdown
# Project Constitution

## Tech Stack
- Frontend: React + TypeScript
- Backend: Node.js + Express
- Database: PostgreSQL

## Conventions
- Use functional components
- Follow REST API standards
- Write tests for all features
```

### 2. Viết Specification

```
/speckit.specify
```

AI sẽ giúp bạn định nghĩa requirements:

```markdown
# Todo App Specification

## User Stories
- As a user, I can create a new todo item
- As a user, I can mark a todo as completed
- As a user, I can filter todos by status
- As a user, I can delete a todo

## Acceptance Criteria
- Todo items persist across page refreshes
- Filter options: All, Active, Completed
- Confirmation before delete
```

### 3. Lên Plan

```
/speckit.plan
```

AI tạo technical plan từ specification:

```markdown
# Technical Plan

## Architecture
- React SPA with local storage
- Component-based structure

## Components
1. TodoList - hiển thị danh sách
2. TodoItem - hiển thị từng item
3. TodoForm - form tạo mới
4. FilterBar - bộ lọc

## Data Model
interface Todo {
  id: string;
  title: string;
  completed: boolean;
  createdAt: Date;
}
```

### 4. Tạo Tasks

```
/speckit.tasks
```

AI chia plan thành tasks nhỏ:

```markdown
# Tasks

- [ ] Setup React project with TypeScript
- [ ] Create Todo interface/type
- [ ] Implement TodoForm component
- [ ] Implement TodoItem component
- [ ] Implement TodoList component
- [ ] Add local storage persistence
- [ ] Implement FilterBar component
- [ ] Add delete confirmation modal
```

### 5. Implement

```
/speckit.implement
```

AI bắt đầu implement từng task, theo đúng specification và plan đã định.

---

## Thử Nghiệm

<div class="try-it">

### Bài tập 1: Tạo project đầu tiên

1. Cài đặt spec-kit theo hướng dẫn trên
2. Chạy `specify init my-first-app --ai claude`
3. Mở folder và xem cấu trúc được tạo

### Bài tập 2: Thiết lập Constitution

1. Mở project với Claude Code
2. Chạy `/speckit.constitution`
3. Trả lời các câu hỏi về tech stack bạn muốn dùng
4. Xem file constitution được tạo ra

</div>

### Câu hỏi kiểm tra

1. Spec-driven development khác gì với vibe coding?
2. Tại sao cần viết specification trước khi code?
3. Constitution dùng để làm gì?

---

## Khi Nào KHÔNG Nên Dùng Spec-Kit

Spec-Kit rất hữu ích, nhưng **không phải lúc nào cũng cần thiết**. Đây là hướng dẫn giúp bạn quyết định:

### ❌ KHÔNG cần Spec-Kit khi:

| Tình huống | Lý do |
|------------|-------|
| **Script nhỏ < 100 dòng** | Overhead của spec > value. Chỉ cần viết code trực tiếp. |
| **Prototype/POC nhanh** | Khi mục tiêu là validate idea trong 1-2 giờ, spec sẽ slow down. |
| **Bug fix đơn giản** | Sửa typo, fix 1-2 dòng code không cần full workflow. |
| **Học công nghệ mới** | Khi đang explore/learn, cứ code thoải mái rồi refactor sau. |
| **Solo hackathon** | Time-boxed events cần speed, không cần formal specs. |

### ✅ NÊN dùng Spec-Kit khi:

| Tình huống | Lý do |
|------------|-------|
| **Feature mới cho production** | Spec giúp align expectations, giảm rework. |
| **Project > 1 tuần effort** | Investment vào spec sẽ payoff về sau. |
| **Làm việc với team** | Specs là communication tool giữa members. |
| **Dự án có stakeholders** | Specs giúp document decisions và get buy-in. |
| **Code sẽ maintain lâu dài** | Specs trở thành living documentation. |

### 🤔 Tùy trường hợp:

```
Quy tắc ngón tay cái:

Nếu bạn sẽ VỨNG task đi sau khi xong → Không cần spec
Nếu bạn hoặc người khác sẽ QUAY LẠI code này → Nên có spec

Nếu bạn có thể giải thích task trong 1 câu → Không cần spec
Nếu bạn cần 5+ phút để giải thích → Nên có spec
```

### Quick Decision Flowchart

```
Task của bạn là gì?
    │
    ├── Script/utility nhỏ? → ❌ Skip spec-kit
    │
    ├── Bug fix?
    │   ├── Simple (< 30 min)? → ❌ Skip
    │   └── Complex (investigation needed)? → ✅ Dùng /speckit.clarify
    │
    ├── New feature?
    │   ├── Solo, < 1 day? → 🤔 Optional
    │   └── Team, > 1 day? → ✅ Full workflow
    │
    └── Refactoring?
        ├── Rename/move files? → ❌ Skip
        └── Architecture change? → ✅ Dùng /speckit.plan
```

---

## Tiếp Theo

Đọc [Khái Niệm Cốt Lõi](core-concepts.md) để hiểu sâu hơn về các khái niệm cốt lõi của Spec-Kit.

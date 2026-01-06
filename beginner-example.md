# Ví Dụ Cho Người Mới Bắt Đầu

> Một ví dụ đơn giản với **Vanilla JavaScript** - không cần React, không cần backend!

---

## Mục Tiêu Học Tập

Sau khi hoàn thành ví dụ này, bạn sẽ:

- ✅ Trải nghiệm **full Spec-Kit workflow** với project đơn giản
- ✅ Hiểu cách viết **specification** cho feature nhỏ
- ✅ Thấy được **giá trị của spec-driven development**
- ✅ Tự tin để thử với project phức tạp hơn

**Thời gian:** ~30-45 phút | **Yêu cầu:** Chỉ cần biết HTML, CSS, JavaScript cơ bản

---

## Project: Simple Counter App

Thay vì Task Manager phức tạp, chúng ta sẽ làm một **Counter App** đơn giản nhưng đầy đủ workflow.

### Tại sao Counter App?

- ❌ Không cần backend
- ❌ Không cần React/Vue/Angular
- ❌ Không cần database
- ✅ Chỉ cần 1 file HTML
- ✅ Focus vào **workflow**, không phải tech stack

---

## Bước 1: Khởi Tạo Project

```bash
# Tạo project
specify init counter-app --ai claude
cd counter-app
```

Hoặc nếu chưa cài spec-kit, tạo folder thủ công:

```bash
mkdir counter-app
cd counter-app
mkdir .speckit
```

---

## Bước 2: Constitution (Đơn Giản)

Tạo file `.speckit/constitution.md`:

```markdown
# Counter App - Constitution

## Project Overview
Ứng dụng đếm số đơn giản, chạy trên browser.

## Tech Stack
- **Frontend**: Vanilla HTML + CSS + JavaScript
- **Storage**: localStorage (persist across refreshes)
- **Build**: Không cần build, chạy trực tiếp

## Coding Standards
- Sử dụng ES6+ syntax
- Tên biến: camelCase
- Tên hàm: động từ + danh từ (incrementCount, saveToStorage)
- Comments cho logic phức tạp

## File Structure
counter-app/
├── index.html      # Tất cả trong 1 file
└── .speckit/
    ├── constitution.md
    └── specs/
```

**Lưu ý:** Constitution này **rất đơn giản** vì project nhỏ. Đừng over-engineer!

---

## Bước 3: Specification

Tạo file `.speckit/specs/counter-spec.md`:

```markdown
# Counter App Specification

## Mô tả
Một ứng dụng đếm số với các nút tăng/giảm.

## User Stories

**Xem Counter**
- As a user, I see the current count displayed prominently
- As a user, I see the count persists when I refresh the page

**Tăng/Giảm**
- As a user, I can click "+" to increase count by 1
- As a user, I can click "-" to decrease count by 1
- As a user, the count cannot go below 0

**Reset**
- As a user, I can click "Reset" to set count back to 0
- As a user, I see a confirmation before reset (optional)

## Data Model

```javascript
// Đơn giản - chỉ 1 số
let count = 0;

// Lưu trong localStorage
localStorage.setItem('count', count);
```

## UI Layout

```
┌─────────────────────────┐
│                         │
│          42             │  ← Số lớn, centered
│                         │
│   [ - ]  [ + ]          │  ← Buttons
│                         │
│       [Reset]           │  ← Reset button
│                         │
└─────────────────────────┘
```

## Acceptance Criteria

- [ ] Count hiển thị ở giữa màn hình, font size lớn
- [ ] Nút "+" tăng count lên 1
- [ ] Nút "-" giảm count, minimum 0
- [ ] Nút "Reset" đặt count = 0
- [ ] Count được save vào localStorage
- [ ] Khi refresh page, count được restore từ localStorage
```

---

## Bước 4: Implementation

Với spec rõ ràng, giờ bạn (hoặc AI) có thể implement:

### File `index.html`:

```html
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Counter App</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', sans-serif;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .counter-container {
            background: white;
            padding: 40px 60px;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            text-align: center;
        }

        .count-display {
            font-size: 72px;
            font-weight: bold;
            color: #333;
            margin-bottom: 30px;
        }

        .buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-bottom: 20px;
        }

        button {
            font-size: 24px;
            padding: 15px 30px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: transform 0.1s, box-shadow 0.1s;
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }

        button:active {
            transform: translateY(0);
        }

        .btn-increment {
            background: #10b981;
            color: white;
        }

        .btn-decrement {
            background: #ef4444;
            color: white;
        }

        .btn-reset {
            background: #6b7280;
            color: white;
            font-size: 16px;
            padding: 10px 25px;
        }
    </style>
</head>
<body>
    <div class="counter-container">
        <div class="count-display" id="countDisplay">0</div>
        <div class="buttons">
            <button class="btn-decrement" onclick="decrementCount()">−</button>
            <button class="btn-increment" onclick="incrementCount()">+</button>
        </div>
        <button class="btn-reset" onclick="resetCount()">Reset</button>
    </div>

    <script>
        // Load count from localStorage or start at 0
        let count = parseInt(localStorage.getItem('count')) || 0;

        // Update display on page load
        updateDisplay();

        function updateDisplay() {
            document.getElementById('countDisplay').textContent = count;
        }

        function saveToStorage() {
            localStorage.setItem('count', count);
        }

        function incrementCount() {
            count++;
            updateDisplay();
            saveToStorage();
        }

        function decrementCount() {
            // Count cannot go below 0 (from spec)
            if (count > 0) {
                count--;
                updateDisplay();
                saveToStorage();
            }
        }

        function resetCount() {
            count = 0;
            updateDisplay();
            saveToStorage();
        }
    </script>
</body>
</html>
```

---

## Bước 5: Verify Against Spec

Mở `index.html` trong browser và check từng acceptance criteria:

| Criteria | Status | Notes |
|----------|--------|-------|
| Count hiển thị ở giữa, font lớn | ✅ | 72px, centered |
| Nút "+" tăng count | ✅ | incrementCount() |
| Nút "-" giảm, min 0 | ✅ | Check `count > 0` |
| Nút "Reset" = 0 | ✅ | resetCount() |
| Save to localStorage | ✅ | saveToStorage() |
| Restore on refresh | ✅ | Load trong script |

**Tất cả criteria đều pass!** 🎉

---

## So Sánh: Có Spec vs Không Có Spec

### Không có Spec (Vibe Coding)

```
You: "AI, làm cho tôi counter app"
AI: *tạo counter với Redux, TypeScript, styled-components*
You: "Đơn giản thôi, vanilla JS"
AI: *viết lại*
You: "Cần save vào localStorage"
AI: *thêm localStorage*
You: "À, count không được âm"
AI: *thêm validation*
...
```

**Kết quả:** 4-5 lần iteration, mỗi lần AI viết lại.

### Có Spec (Spec-Driven)

```
You: *viết spec 5 phút*
You: "AI, implement theo spec này"
AI: *tạo đúng từ đầu*
```

**Kết quả:** 1 lần, đúng ngay.

---

## Thử Nghiệm Thêm

<div class="try-it">

### Bài tập: Mở rộng Counter App

Thêm features sau vào spec và implement:

1. **Step size**: Cho phép user chọn tăng/giảm bao nhiêu (1, 5, 10)
2. **History**: Hiển thị 5 giá trị gần nhất
3. **Dark mode**: Toggle giữa light/dark theme

**Gợi ý:** Viết spec trước, rồi mới code!

</div>

---

## Key Takeaways

1. **Spec không cần phức tạp** - Counter app chỉ cần 1 trang spec ngắn
2. **Constitution scale theo project** - Project nhỏ = constitution nhỏ
3. **Workflow vẫn giống nhau** - Constitution → Spec → Implement
4. **Spec giúp verify** - Checklist để ensure không miss feature

---

## Tiếp Theo

Khi đã comfortable với workflow, thử:

- [Ví dụ Task Manager](practical-examples.md) - Project phức tạp hơn với React + Backend
- [Best Practices](best-practices.md) - Tips để viết spec tốt hơn

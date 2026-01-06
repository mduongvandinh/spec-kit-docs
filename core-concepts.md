# Spec-Kit: Khái Niệm Cốt Lõi

> Hiểu rõ các khái niệm này sẽ giúp bạn sử dụng Spec-Kit hiệu quả hơn.

---

## Mục Tiêu Học Tập

Sau khi hoàn thành chương này, bạn sẽ:

- ✅ Hiểu rõ **4 artifacts chính**: Specification, Constitution, Plan, Tasks
- ✅ Biết **khi nào dùng** artifact nào
- ✅ Phân biệt được **WHAT vs HOW** trong development
- ✅ Viết được **specification đầu tiên** của riêng bạn
- ✅ Nắm vững **workflow tổng hợp** từ idea đến code

**Thời gian đọc:** ~25 phút | **Thời gian thực hành:** ~45 phút

---

## 1. Specification (Đặc Tả)

### Vấn Đề

```
Developer: "Tôi cần làm feature login"
AI: *tạo form login với email/password*
Developer: "Không, tôi muốn login bằng Google"
AI: *xóa code cũ, viết lại với OAuth*
Developer: "À, cần thêm remember me nữa"
```

Mỗi lần thay đổi = viết lại code. Tại sao? Vì không có **specification** rõ ràng từ đầu.

### Giải Pháp: Viết Spec Trước

```markdown
# Login Feature Specification

## Mục tiêu
Cho phép user đăng nhập vào hệ thống

## Authentication Methods
1. Google OAuth (primary)
2. Email/Password (fallback)

## Features
- [ ] Remember me checkbox (30 days)
- [ ] Forgot password link
- [ ] Error messages cho từng case

## Edge Cases
- User chưa có account → redirect to signup
- Wrong password 5 lần → lock 15 phút
- OAuth denied → show friendly message
```

### Lợi Ích

| Không có Spec | Có Spec |
|---------------|---------|
| Code → Fix → Rewrite | Spec → Plan → Code một lần |
| AI đoán ý bạn | AI hiểu chính xác yêu cầu |
| Scope creep liên tục | Scope rõ ràng từ đầu |

<div class="try-it">

### Thử Nghiệm

Viết specification cho một feature bạn đang làm:
1. Mục tiêu chính là gì?
2. Các sub-features cần có?
3. Edge cases có thể xảy ra?

</div>

---

## 2. Constitution (Hiến Pháp Dự Án)

### Vấn Đề

```
File A: class UserService { ... }           // OOP style
File B: const getUser = () => { ... }       // Functional style
File C: function fetchUser() { ... }        // Mixed style

API endpoint 1: /api/users/get-all          // verb in URL
API endpoint 2: /api/v1/users               // RESTful
API endpoint 3: /users/list                 // inconsistent
```

**Inconsistency** - mỗi file một phong cách, khó maintain.

### Giải Pháp: Constitution

Constitution là "hiến pháp" của dự án - định nghĩa các quy tắc **bất biến**:

```markdown
# Project Constitution

## Tech Stack (không thay đổi)
- Language: TypeScript (strict mode)
- Frontend: React 18 + Vite
- Backend: Node.js + Fastify
- Database: PostgreSQL + Prisma

## Code Style
- Functions: Arrow functions preferred
- Components: Functional only, no classes
- Naming: camelCase for functions, PascalCase for components

## API Design
- RESTful conventions
- Format: /api/v{version}/{resource}
- Response: { data, error, meta }

## Testing
- Unit tests required cho business logic
- Integration tests cho API endpoints
- Coverage minimum: 80%
```

### Commands Liên Quan

```
/speckit.constitution     # Tạo hoặc xem constitution
```

### So Sánh

| Specification | Constitution |
|---------------|--------------|
| Cho một feature cụ thể | Cho toàn bộ project |
| Thay đổi theo requirement | Ít thay đổi |
| WHAT to build | HOW to build |

<div class="try-it">

### Thử Nghiệm

Tạo constitution cho project của bạn:
1. Tech stack bạn sẽ dùng?
2. Coding conventions?
3. API design principles?

</div>

---

## 3. Plan (Kế Hoạch Kỹ Thuật)

### Vấn Đề

```
Spec: "User có thể upload avatar"

Developer nghĩ: "Đơn giản, thêm input file"

Thực tế cần:
- Validate file type (jpg, png, gif)
- Resize image
- Compress image
- Upload to storage (S3? Cloudinary?)
- Handle upload progress
- Handle errors
- Update database
- Invalidate cache
- Update UI optimistically
```

Từ 1 dòng spec → 10+ technical decisions.

### Giải Pháp: Technical Plan

```markdown
# Avatar Upload - Technical Plan

## Architecture Decision

### Storage: Cloudinary
**Why?**
- Auto resize/optimize
- CDN included
- Free tier đủ dùng

**Alternatives considered:**
- S3 + Lambda: phức tạp hơn
- Local storage: không scale

## Implementation Steps

### Backend
1. POST /api/users/avatar
2. Validate: file type, size < 5MB
3. Upload to Cloudinary
4. Save URL to database
5. Return new avatar URL

### Frontend
1. File input với drag & drop
2. Preview trước khi upload
3. Progress bar
4. Optimistic UI update

## Data Flow
User selects file
    ↓
Frontend validates (type, size)
    ↓
Show preview
    ↓
User confirms
    ↓
Upload with progress
    ↓
Backend validates again
    ↓
Upload to Cloudinary
    ↓
Save URL to DB
    ↓
Return success
    ↓
Update UI

## Error Handling
| Error | User Message |
|-------|--------------|
| File too large | "Ảnh phải nhỏ hơn 5MB" |
| Wrong type | "Chỉ hỗ trợ JPG, PNG, GIF" |
| Upload failed | "Lỗi upload, vui lòng thử lại" |
```

### Commands Liên Quan

```
/speckit.plan      # Tạo technical plan từ specification
/speckit.clarify   # Làm rõ các điểm chưa rõ trong plan
```

<div class="try-it">

### Thử Nghiệm

Lấy một specification và viết technical plan:
1. Những technical decisions nào cần đưa ra?
2. Có alternatives nào? Tại sao chọn cái này?
3. Data flow như thế nào?

</div>

---

## 4. Tasks (Danh Sách Công Việc)

### Vấn Đề

```
Plan: "Implement avatar upload feature"

Developer: *ngồi nhìn màn hình* "Bắt đầu từ đâu?"
```

Plan tốt nhưng **không actionable** - không biết bước tiếp theo là gì.

### Giải Pháp: Break Down Tasks

```markdown
# Avatar Upload - Tasks

## Phase 1: Setup (30 mins)
- [x] Install Cloudinary SDK
- [x] Add environment variables
- [x] Create Cloudinary config file

## Phase 2: Backend (2 hours)
- [ ] Create POST /api/users/avatar endpoint
- [ ] Add file validation middleware
- [ ] Implement Cloudinary upload service
- [ ] Add error handling
- [ ] Write unit tests

## Phase 3: Frontend (2 hours)
- [ ] Create AvatarUpload component
- [ ] Add drag & drop functionality
- [ ] Implement preview feature
- [ ] Add progress indicator
- [ ] Connect to API
- [ ] Handle errors

## Phase 4: Integration (1 hour)
- [ ] Test end-to-end flow
- [ ] Add to user profile page
- [ ] Update existing avatar display
```

### Đặc Điểm Của Task Tốt

| Bad Task | Good Task |
|----------|-----------|
| "Làm backend" | "Create POST /api/users/avatar endpoint" |
| "Fix bugs" | "Handle case when file size > 5MB" |
| "Improve UI" | "Add loading spinner during upload" |

**Nguyên tắc**: Mỗi task có thể hoàn thành trong 15-60 phút.

### Commands Liên Quan

```
/speckit.tasks       # Tạo task list từ plan
/speckit.implement   # Implement từng task
```

<div class="try-it">

### Thử Nghiệm

Lấy plan từ phần trước và chia thành tasks:
1. Mỗi task có clear deliverable không?
2. Có estimate được thời gian không?
3. Có dependency giữa các tasks không?

</div>

---

## 5. Workflow Tổng Hợp

### The Spec-Kit Flow

```
┌─────────────────────────────────────────────────────────────┐
│                      CONSTITUTION                            │
│  (Định nghĩa một lần, áp dụng cho toàn bộ project)          │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                      SPECIFICATION                           │
│  "User cần làm được gì?" (WHAT)                             │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                         PLAN                                 │
│  "Làm như thế nào về mặt kỹ thuật?" (HOW)                   │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                         TASKS                                │
│  "Các bước cụ thể là gì?" (STEPS)                           │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                      IMPLEMENTATION                          │
│  "Execute từng task" (DO)                                   │
└─────────────────────────────────────────────────────────────┘
```

### Commands Summary

| Command | Input | Output | Khi nào dùng |
|---------|-------|--------|--------------|
| `/speckit.constitution` | Câu hỏi | Project rules | Đầu project |
| `/speckit.specify` | Idea | Specification | Mỗi feature mới |
| `/speckit.plan` | Specification | Technical plan | Sau khi có spec |
| `/speckit.tasks` | Plan | Task list | Sau khi có plan |
| `/speckit.implement` | Tasks | Code | Khi sẵn sàng code |
| `/speckit.clarify` | Anything | Clarifications | Khi có điểm mơ hồ |
| `/speckit.analyze` | All artifacts | Validation | Trước khi implement |
| `/speckit.checklist` | Context | QA checklist | Trước khi ship |

---

## Tiếp Theo

Đọc [Ví Dụ Thực Tế](practical-examples.md) để xem các ví dụ thực tế end-to-end.

# Spec-Kit: Best Practices & Tips

> Những bài học từ thực tế để sử dụng Spec-Kit hiệu quả hơn.

---

## Mục Tiêu Học Tập

Sau khi hoàn thành chương này, bạn sẽ:

- ✅ Viết được **specification chất lượng cao** (không quá vague, không quá detailed)
- ✅ Chọn đúng **Constitution pattern** cho project của bạn
- ✅ Biết **khi nào dùng command nào** với decision tree
- ✅ Xử lý được **các hạn chế của AI** (quên context, over-engineer)
- ✅ Áp dụng **team workflows** phù hợp với team size
- ✅ Tránh được **6 common mistakes** phổ biến

**Thời gian đọc:** ~20 phút | **Áp dụng:** Ongoing (reference khi cần)

---

## 1. Viết Specification Tốt

### Vấn Đề: Spec Quá Mơ Hồ

```markdown
# Bad Spec

## Feature: User Management
- Users can register
- Users can login
- Users can update profile
```

Spec này **không sai** nhưng **thiếu chi tiết**. AI sẽ phải đoán rất nhiều.

### Giải Pháp: Spec Cụ Thể

```markdown
# Good Spec

## Feature: User Registration

### Flow
1. User clicks "Sign Up"
2. Form appears với fields: email, password, confirm password
3. User fills form và submits
4. System validates:
   - Email format valid
   - Email chưa tồn tại
   - Password >= 8 chars, có number và special char
   - Confirm password matches
5. If valid → create account → send verification email → show success
6. If invalid → show inline errors → keep form data

### Email Verification
- Verification link expires sau 24h
- Click link → mark email verified → redirect to login
- User có thể request resend (max 3 times/hour)

### Error Messages
| Error | Message |
|-------|---------|
| Invalid email | "Please enter a valid email address" |
| Email exists | "This email is already registered" |
| Weak password | "Password must be at least 8 characters with a number and special character" |
| Mismatch | "Passwords do not match" |

### Success State
- Show: "Check your email to verify your account"
- Auto-redirect to login after 5 seconds
```

### Checklist Cho Spec Tốt

- [ ] User flow rõ ràng từng bước
- [ ] Validation rules cụ thể
- [ ] Error cases và messages
- [ ] Success state
- [ ] Edge cases (timeout, retry, etc.)

---

## 2. Constitution Patterns

### Pattern 1: The Minimalist

Cho projects nhỏ, 1-2 người:

```markdown
# Constitution

## Stack
- Next.js 14 (App Router)
- TypeScript
- Tailwind CSS
- Prisma + PostgreSQL

## Rules
- Server Components by default
- Client Components only when needed (interactivity)
- API routes trong /app/api
- Zod cho validation
```

### Pattern 2: The Enterprise

Cho team lớn, cần consistency:

```markdown
# Constitution

## Architecture
- Clean Architecture layers
- Domain-Driven Design concepts
- CQRS cho complex operations

## Code Organization
src/
├── domain/           # Business logic, no dependencies
│   ├── entities/
│   ├── value-objects/
│   └── services/
├── application/      # Use cases, orchestration
│   ├── commands/
│   ├── queries/
│   └── dto/
├── infrastructure/   # External services
│   ├── database/
│   ├── cache/
│   └── external-api/
└── presentation/     # UI, API controllers
    ├── api/
    └── web/

## Naming Conventions
- Entities: PascalCase, singular (User, Order)
- Use cases: verb + noun (CreateUser, GetOrderById)
- Repositories: I + Entity + Repository (IUserRepository)
- Events: Entity + past tense (UserCreated, OrderShipped)

## Testing Requirements
- Unit tests cho domain logic (100% coverage)
- Integration tests cho repositories
- E2E tests cho critical paths
- No mocking domain entities
```

### Pattern 3: The Startup

Optimize cho speed, chấp nhận tech debt:

```markdown
# Constitution

## Philosophy
- Ship fast, iterate later
- Monolith first, microservices when needed
- Use managed services (Supabase, Vercel, etc.)

## Stack (batteries included)
- Next.js (full-stack)
- Supabase (auth, database, storage)
- Tailwind + shadcn/ui
- Vercel (hosting)

## Shortcuts Allowed
- any type khi prototyping (must fix before PR)
- console.log for debugging (remove before PR)
- Copy-paste OK for < 3 occurrences

## Non-Negotiables
- TypeScript (no .js files)
- ESLint errors = CI fail
- No secrets in code
```

---

## Security Considerations trong Constitution

> ⚠️ **Quan trọng:** Mọi Constitution nên có section về Security. Đây là template bạn có thể copy.

### Security Section Template

```markdown
## Security Policies

### Authentication & Authorization
- Auth method: [JWT / Session / OAuth2]
- Token storage: [httpOnly cookies / secure localStorage]
- Session timeout: [thời gian]
- Role-based access control: [Yes/No]

### Data Protection
- Sensitive data encryption: [at rest / in transit / both]
- PII handling: [những field nào là PII]
- Data retention: [bao lâu giữ data]
- GDPR/CCPA compliance: [Yes/No/N/A]

### Input Validation
- All user input MUST be validated on server-side
- Use parameterized queries (no string concatenation for SQL)
- Sanitize HTML output to prevent XSS
- File upload restrictions: [allowed types, max size]

### Secrets Management
- NO secrets in code (use environment variables)
- NO secrets in git history
- Secrets rotation policy: [frequency]
- Use: [Vault / AWS Secrets Manager / .env.local]

### API Security
- Rate limiting: [requests/minute]
- CORS policy: [allowed origins]
- API versioning: [strategy]
- Authentication required for: [which endpoints]

### Logging & Monitoring
- Log authentication events: [Yes/No]
- Log failed requests: [Yes/No]
- PII in logs: [NEVER / masked only]
- Alert on: [suspicious patterns]
```

### Ví Dụ Áp Dụng

**Cho Startup (MVP):**
```markdown
## Security (MVP)

### Non-Negotiables
- HTTPS only (no HTTP)
- Passwords hashed with bcrypt (min 10 rounds)
- No secrets in code
- Input validation on all forms

### Will Add Later (Tech Debt)
- Rate limiting
- Advanced logging
- Penetration testing
```

**Cho Enterprise:**
```markdown
## Security (Enterprise)

### Authentication
- SSO via SAML 2.0 with company IdP
- MFA required for admin roles
- Session timeout: 30 minutes idle
- JWT tokens: 15 min access, 7 day refresh

### Compliance
- SOC 2 Type II compliant
- GDPR compliant (EU users)
- Annual security audit required
- Penetration testing: quarterly

### Data Classification
- Public: marketing content
- Internal: user emails, names
- Confidential: passwords, payment info
- Restricted: health data, SSN
```

### Checklist Khi Review Constitution

- [ ] Có section Security không?
- [ ] Authentication method được định nghĩa?
- [ ] Secrets management được cover?
- [ ] Input validation rules rõ ràng?
- [ ] Compliance requirements (nếu có)?

---

## 3. Khi Nào Dùng Commands

### Decision Tree

```
Bắt đầu project mới?
    └── YES → /speckit.constitution
    └── NO ↓

Có feature/epic mới?
    └── YES → /speckit.specify
    └── NO ↓

Có spec nhưng chưa có technical approach?
    └── YES → /speckit.plan
    └── NO ↓

Có plan nhưng chưa biết bắt đầu từ đâu?
    └── YES → /speckit.tasks
    └── NO ↓

Có tasks và sẵn sàng code?
    └── YES → /speckit.implement
    └── NO ↓

Có điểm mơ hồ trong spec/plan?
    └── YES → /speckit.clarify
    └── NO ↓

Muốn validate trước khi implement?
    └── YES → /speckit.analyze
    └── NO ↓

Sắp ship và cần QA?
    └── YES → /speckit.checklist
```

### Command Combinations

**New Feature Flow**
```
/speckit.specify
    ↓
/speckit.clarify (if needed)
    ↓
/speckit.plan
    ↓
/speckit.tasks
    ↓
/speckit.implement
```

**Bug Fix Flow**
```
/speckit.clarify (understand the bug)
    ↓
/speckit.tasks (if complex)
    ↓
/speckit.implement
```

**Refactoring Flow**
```
/speckit.plan (define target architecture)
    ↓
/speckit.tasks (break into safe steps)
    ↓
/speckit.analyze (check for risks)
    ↓
/speckit.implement
```

---

## 4. Handling AI Limitations

### Vấn Đề: AI Quên Context

Long conversation = AI quên spec đã viết.

**Giải pháp: Reference files explicitly**

```
/speckit.implement

Implement task #3 từ tasks/sprint-1.md
Tham khảo:
- Spec: specs/user-management.md
- Plan: plans/user-management.md
- Constitution: constitution.md
```

### Vấn Đề: AI Bịa Thêm Features

AI có xu hướng "over-engineer".

**Giải pháp: Explicit constraints**

```markdown
## Specification

### In Scope
- Basic CRUD operations
- Simple validation

### Out of Scope
- Advanced filtering
- Export to CSV
- Audit logging
- Multi-tenancy

### Constraints
- Max 3 API endpoints
- No external dependencies ngoài đã list
- Không thêm fields vào data model
```

### Vấn Đề: AI Không Follow Constitution

**Giải pháp: Remind in each command**

```
/speckit.implement

IMPORTANT: Follow constitution.md strictly:
- Functional components only
- No any types
- API format: { success, data, error }
```

---

## 5. Team Workflows

### Solo Developer

```
Morning:
1. Review yesterday's tasks
2. /speckit.clarify nếu có blockers
3. /speckit.implement cho 2-3 tasks

Afternoon:
4. Continue implementing
5. /speckit.analyze trước khi commit
6. Plan tomorrow

Weekly:
- Review constitution, update if needed
- Retrospective: spec nào thiếu detail?
```

### Small Team (2-5 people)

```
Sprint Planning:
1. PM viết high-level specs
2. Team review với /speckit.clarify
3. Tech lead tạo plans
4. Team chia tasks

Daily:
- Sync on task progress
- Flag blockers sớm
- Review PRs against spec

Sprint End:
- /speckit.checklist cho QA
- Demo theo spec
- Update specs với learnings
```

### Large Team

```
Spec Review Process:
1. Feature owner viết initial spec
2. PR cho spec file
3. Team review, suggest changes
4. Merge = spec approved

Implementation:
- Each dev works on assigned tasks
- PRs reference task ID
- Code review checks against spec

Documentation:
- Specs become living documentation
- Plans explain architecture decisions
- Constitution enforces consistency
```

---

## 6. Common Mistakes

### Mistake 1: Skipping Steps

```
❌ Idea → Code ngay

✅ Idea → Spec → Plan → Tasks → Code
```

**Tại sao?** Skip steps = hidden assumptions = bugs later.

### Mistake 2: Over-Specification

```
❌ Spec 20 pages cho một button

✅ Spec vừa đủ để AI không phải đoán
```

**Rule of thumb**: Nếu bạn mất > 30 phút viết spec cho 1 feature nhỏ, spec quá detailed.

### Mistake 3: Never Updating Specs

```
❌ Viết spec → Implement → Forget spec

✅ Viết spec → Implement → Update spec với changes
```

**Specs = documentation**. Outdated spec còn tệ hơn không có spec.

### Mistake 4: Generic Constitution

```
❌ "Use best practices" (quá vague)

✅ "Use functional components, arrow functions, Tailwind for styling" (cụ thể)
```

---

## 7. Quick Reference Card

<div class="cheatsheet">

```
┌────────────────────────────────────────────────────────────┐
│                    SPEC-KIT CHEATSHEET                     │
├────────────────────────────────────────────────────────────┤
│                                                            │
│  COMMANDS                                                  │
│  ─────────────────────────────────────────────────────    │
│  /speckit.constitution   Setup project rules (once)        │
│  /speckit.specify        Define feature requirements       │
│  /speckit.plan           Create technical approach         │
│  /speckit.tasks          Break into actionable items       │
│  /speckit.implement      Code the tasks                    │
│  /speckit.clarify        Clear up confusion                │
│  /speckit.analyze        Validate consistency              │
│  /speckit.checklist      Generate QA checklist             │
│                                                            │
│  SPEC TEMPLATE                                             │
│  ─────────────────────────────────────────────────────    │
│  ## User Stories                                           │
│  - As a [user], I can [action] so that [benefit]          │
│                                                            │
│  ## Acceptance Criteria                                    │
│  - [ ] Specific, testable requirement                      │
│                                                            │
│  ## Data Model                                             │
│  interface Entity { ... }                                  │
│                                                            │
│  ## Edge Cases                                             │
│  - What if X happens?                                      │
│                                                            │
│  GOLDEN RULES                                              │
│  ─────────────────────────────────────────────────────    │
│  1. Spec trước, code sau                                   │
│  2. Cụ thể hơn là mơ hồ                                    │
│  3. Update spec khi requirement thay đổi                   │
│  4. Constitution = law, không vi phạm                      │
│  5. Tasks nhỏ = progress visible                           │
│                                                            │
└────────────────────────────────────────────────────────────┘
```

</div>

---

## Tổng Kết

Spec-Kit không phải magic - nó là **discipline**.

Giống như viết tests trước (TDD), viết spec trước có vẻ chậm ban đầu nhưng:
- Ít bugs hơn
- Ít refactor hơn
- Code dễ maintain hơn
- AI hiểu đúng ý bạn hơn

**Start small**: Thử với một feature nhỏ. Viết spec, plan, tasks. Rồi implement.

So sánh với cách bạn code trước đây. Thấy khác biệt chưa?

---

## Resources

<div class="quick-links">
  <a href="https://github.com/github/spec-kit">GitHub Repository</a>
  <a href="https://github.com/github/spec-kit#supported-agents">Supported AI Agents</a>
  <a href="getting-started.md">Bắt đầu từ đầu</a>
</div>

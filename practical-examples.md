# Spec-Kit: Ví Dụ Thực Tế

> Học qua thực hành - xây dựng một ứng dụng hoàn chỉnh từ đầu với Spec-Kit.

---

## Mục Tiêu Học Tập

Sau khi hoàn thành chương này, bạn sẽ:

- ✅ Áp dụng **full Spec-Kit workflow** cho một project thực tế
- ✅ Viết được **Constitution** hoàn chỉnh cho project
- ✅ Tạo được **Specification** với user stories và acceptance criteria
- ✅ Thiết kế **Technical Plan** với architecture decisions
- ✅ Chia nhỏ plan thành **actionable tasks**
- ✅ Hiểu cách AI **implement** theo specs đã định

**Thời gian đọc:** ~30 phút | **Thời gian thực hành:** ~2-3 giờ (nếu code along)

> ⚠️ **Lưu ý:** Các output trong ví dụ là **minh họa**. Output thực tế từ AI có thể khác tùy context và cách bạn prompt.

---

## Project: Task Manager App

Chúng ta sẽ xây dựng một ứng dụng quản lý công việc đơn giản nhưng đầy đủ tính năng.

---

## Bước 1: Khởi Tạo Project

### Tạo project mới

```bash
specify init task-manager --ai claude
cd task-manager
```

### Mở với AI agent

```bash
claude
```

---

## Bước 2: Thiết Lập Constitution

### Chạy command

```
/speckit.constitution
```

### Conversation với AI

```
AI: Hãy cho tôi biết về project này:
    1. Đây là loại application gì?
    2. Tech stack bạn muốn dùng?
    3. Có constraints đặc biệt nào không?

You: 1. Web app quản lý tasks cho cá nhân
     2. React + TypeScript frontend,
        Node.js backend,
        SQLite database (đơn giản, không cần server)
     3. Phải work offline, data lưu local
```

### Output: constitution.md

```markdown
# Task Manager - Constitution

## Project Overview
Personal task management web application với offline-first approach.

## Tech Stack

### Frontend
- **Framework**: React 18
- **Language**: TypeScript (strict mode)
- **Styling**: Tailwind CSS
- **State**: Zustand (simple, no boilerplate)
- **Build**: Vite

### Backend
- **Runtime**: Node.js 20
- **Framework**: Express.js
- **Database**: SQLite với better-sqlite3
- **ORM**: Drizzle ORM

### Infrastructure
- **Storage**: Local SQLite file
- **Offline**: Service Worker + IndexedDB cache

## Coding Standards

### TypeScript
- Strict mode enabled
- No `any` type
- Interfaces cho data models
- Type guards cho runtime checks

### React
- Functional components only
- Custom hooks cho shared logic
- Component naming: PascalCase
- File naming: kebab-case.tsx

### API
- RESTful conventions
- Base path: /api/v1
- Response format:
  ```json
  {
    "success": boolean,
    "data": T | null,
    "error": string | null
  }
  ```

## File Structure
task-manager/
├── frontend/
│   ├── src/
│   │   ├── components/
│   │   ├── hooks/
│   │   ├── stores/
│   │   ├── types/
│   │   └── utils/
│   └── package.json
├── backend/
│   ├── src/
│   │   ├── routes/
│   │   ├── services/
│   │   ├── db/
│   │   └── types/
│   └── package.json
└── .speckit/

## Quality Gates
- No TypeScript errors
- All tests pass
- No console.log in production code
```

---

## Bước 3: Viết Specification

### Chạy command

```
/speckit.specify
```

### Conversation

```
AI: Mô tả feature bạn muốn xây dựng:

You: Core features cho task manager:
     - Tạo, sửa, xóa tasks
     - Mark task complete/incomplete
     - Organize tasks vào projects
     - Filter và search tasks
     - Due dates với reminders
```

### Output: specs/core-features.md

```markdown
# Task Manager - Core Features Specification

## 1. Task Management

### User Stories

**Create Task**
- As a user, I can create a new task với title
- As a user, I can optionally add description, due date, priority
- As a user, I can assign task to a project

**Edit Task**
- As a user, I can edit any field of existing task
- As a user, I can see edit history (optional v2)

**Delete Task**
- As a user, I can delete a task
- As a user, I see confirmation before delete
- As a user, I can undo delete within 5 seconds

**Complete Task**
- As a user, I can mark task as complete
- As a user, I can unmark completed task
- Completed tasks move to bottom of list

### Data Model

```typescript
interface Task {
  id: string;
  title: string;
  description?: string;
  completed: boolean;
  priority: 'low' | 'medium' | 'high';
  dueDate?: Date;
  projectId?: string;
  createdAt: Date;
  updatedAt: Date;
}
```

### Acceptance Criteria

- [ ] Task title required, min 1 char, max 200 chars
- [ ] Priority defaults to 'medium'
- [ ] Tasks sorted by: incomplete first, then by due date, then by priority
- [ ] Delete confirmation shows task title
- [ ] Undo toast appears for 5 seconds after delete

---

## 2. Project Organization

### User Stories

**Create Project**
- As a user, I can create projects to organize tasks
- As a user, I can set project color for visual distinction

**Manage Projects**
- As a user, I can rename projects
- As a user, I can delete empty projects
- As a user, I see warning when deleting project with tasks

**View by Project**
- As a user, I can filter tasks by project
- As a user, I can see task count per project

### Data Model

```typescript
interface Project {
  id: string;
  name: string;
  color: string; // hex color
  createdAt: Date;
}
```

### Acceptance Criteria

- [ ] Project name required, max 50 chars
- [ ] 8 preset colors to choose from
- [ ] Cannot delete project with tasks (must move/delete tasks first)
- [ ] "Inbox" is default project, cannot be deleted

---

## 3. Search & Filter

### User Stories

**Search**
- As a user, I can search tasks by title
- As a user, I see results as I type (debounced)

**Filter**
- As a user, I can filter by: All, Active, Completed
- As a user, I can filter by project
- As a user, I can filter by priority
- As a user, I can combine multiple filters

### Acceptance Criteria

- [ ] Search debounce: 300ms
- [ ] Search is case-insensitive
- [ ] Filters persist across page refresh
- [ ] Clear all filters button when any filter active

---

## 4. Due Dates & Reminders

### User Stories

**Due Dates**
- As a user, I can set due date for task
- As a user, I see visual indicator for overdue tasks
- As a user, I see "Today", "Tomorrow", "This week" quick picks

**Reminders** (v2)
- As a user, I can set reminder notification
- As a user, I receive browser notification at reminder time

### Acceptance Criteria

- [ ] Overdue tasks show in red
- [ ] Due today shows in orange
- [ ] Date picker starts from today
- [ ] Can clear due date

---

## UI Mockup (Text)

```
┌────────────────────────────────────────────────────────────┐
│  Task Manager                    [Search...]    [+ New]    │
├────────────────────────────────────────────────────────────┤
│  PROJECTS          │  TASKS                                │
│  ─────────────     │  ────────────────────────────────────│
│  📥 Inbox (5)      │  Filter: [All ▼] [Any Priority ▼]    │
│  🔵 Work (3)       │                                       │
│  🟢 Personal (2)   │  ☐ Buy groceries          Today  🟡   │
│  🟣 Learning (4)   │  ☐ Finish report          Tomorrow   │
│                    │  ☐ Call mom               Mar 15     │
│  [+ New Project]   │  ────────────────────────────────────│
│                    │  Completed                            │
│                    │  ☑ Setup project          Mar 10  ✓  │
└────────────────────────────────────────────────────────────┘
```
```

---

## Bước 4: Tạo Technical Plan

### Chạy command

```
/speckit.plan
```

### Output: plans/core-features-plan.md

```markdown
# Task Manager - Technical Plan

## Architecture Overview

┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   React     │────▶│   Express   │────▶│   SQLite    │
│   Frontend  │◀────│   Backend   │◀────│   Database  │
└─────────────┘     └─────────────┘     └─────────────┘
       │
       ▼
┌─────────────┐
│  IndexedDB  │  (Offline cache)
└─────────────┘

## Database Schema

```sql
-- Projects table
CREATE TABLE projects (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  color TEXT NOT NULL DEFAULT '#6366f1',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tasks table
CREATE TABLE tasks (
  id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  completed INTEGER DEFAULT 0,
  priority TEXT DEFAULT 'medium',
  due_date DATETIME,
  project_id TEXT REFERENCES projects(id),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Default inbox project
INSERT INTO projects (id, name, color)
VALUES ('inbox', 'Inbox', '#6b7280');
```

## API Endpoints

### Tasks
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | /api/v1/tasks | List all tasks (with filters) |
| POST | /api/v1/tasks | Create task |
| GET | /api/v1/tasks/:id | Get single task |
| PATCH | /api/v1/tasks/:id | Update task |
| DELETE | /api/v1/tasks/:id | Delete task |

### Projects
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | /api/v1/projects | List all projects |
| POST | /api/v1/projects | Create project |
| PATCH | /api/v1/projects/:id | Update project |
| DELETE | /api/v1/projects/:id | Delete project |

## Frontend Components

src/components/
├── layout/
│   ├── sidebar.tsx        # Project list
│   └── header.tsx         # Search, new task button
├── tasks/
│   ├── task-list.tsx      # List container
│   ├── task-item.tsx      # Single task row
│   ├── task-form.tsx      # Create/edit form
│   └── task-filters.tsx   # Filter controls
├── projects/
│   ├── project-list.tsx   # Sidebar project list
│   └── project-form.tsx   # Create/edit project
└── ui/
    ├── button.tsx
    ├── input.tsx
    ├── modal.tsx
    └── toast.tsx

## State Management

```typescript
// stores/task-store.ts
interface TaskStore {
  tasks: Task[];
  filters: {
    status: 'all' | 'active' | 'completed';
    projectId: string | null;
    priority: Priority | null;
    search: string;
  };

  // Actions
  fetchTasks: () => Promise<void>;
  createTask: (task: CreateTaskInput) => Promise<void>;
  updateTask: (id: string, updates: Partial<Task>) => Promise<void>;
  deleteTask: (id: string) => Promise<void>;
  setFilter: (filter: Partial<Filters>) => void;
}
```

## Key Decisions

### Why SQLite?
- No database server needed
- Single file, easy backup
- Fast for local data
- Works offline

### Why Zustand over Redux?
- Simpler API
- No boilerplate
- Built-in persistence
- TypeScript friendly

### Why Drizzle ORM?
- Type-safe queries
- Lightweight
- Good SQLite support
- SQL-like syntax
```

---

## Bước 5: Generate Tasks

### Chạy command

```
/speckit.tasks
```

### Output: tasks/sprint-1.md

```markdown
# Sprint 1: Core Task Management

## Setup (Day 1)

### Backend Setup
- [ ] Initialize Node.js project với TypeScript
- [ ] Setup Express server
- [ ] Configure SQLite với Drizzle
- [ ] Create database schema
- [ ] Seed default "Inbox" project

### Frontend Setup
- [ ] Initialize Vite + React + TypeScript
- [ ] Install và configure Tailwind CSS
- [ ] Setup Zustand store
- [ ] Create base UI components (Button, Input, Modal)
- [ ] Setup API client với fetch wrapper

---

## Task CRUD (Day 2-3)

### Backend - Task API
- [ ] GET /api/v1/tasks - list tasks với filters
- [ ] POST /api/v1/tasks - create task
- [ ] PATCH /api/v1/tasks/:id - update task
- [ ] DELETE /api/v1/tasks/:id - delete task
- [ ] Add input validation
- [ ] Add error handling middleware

### Frontend - Task Components
- [ ] TaskList component - hiển thị danh sách
- [ ] TaskItem component - hiển thị single task
- [ ] TaskForm component - modal tạo/sửa task
- [ ] Connect components to Zustand store
- [ ] Implement optimistic updates

### Frontend - Task Interactions
- [ ] Click checkbox → toggle complete
- [ ] Click task → open edit modal
- [ ] Delete button → show confirmation
- [ ] Implement undo delete toast

---

## Project Management (Day 4)

### Backend - Project API
- [ ] GET /api/v1/projects - list projects với task count
- [ ] POST /api/v1/projects - create project
- [ ] PATCH /api/v1/projects/:id - update project
- [ ] DELETE /api/v1/projects/:id - delete (check empty)

### Frontend - Project Components
- [ ] ProjectList component - sidebar
- [ ] ProjectForm component - create/edit modal
- [ ] Color picker component
- [ ] Click project → filter tasks

---

## Search & Filter (Day 5)

### Frontend - Search
- [ ] SearchInput component với debounce
- [ ] Highlight search matches in results

### Frontend - Filters
- [ ] Status filter dropdown (All/Active/Completed)
- [ ] Priority filter dropdown
- [ ] Persist filters to localStorage
- [ ] Clear filters button

---

## Polish & Testing (Day 6)

### UI Polish
- [ ] Loading states
- [ ] Empty states
- [ ] Error states
- [ ] Keyboard shortcuts (Cmd+N = new task)

### Testing
- [ ] API endpoint tests
- [ ] Component tests cho critical flows
- [ ] E2E test: create → complete → delete task
```

---

## Bước 6: Implement

### Chạy command

```
/speckit.implement
```

AI sẽ bắt đầu implement từng task theo thứ tự, tuân theo constitution và plan.

### Ví dụ output cho task đầu tiên

```typescript
// backend/src/index.ts
import express from 'express';
import cors from 'cors';
import { taskRouter } from './routes/tasks';
import { projectRouter } from './routes/projects';
import { initDatabase } from './db';

const app = express();
const PORT = process.env.PORT || 3001;

app.use(cors());
app.use(express.json());

// Routes
app.use('/api/v1/tasks', taskRouter);
app.use('/api/v1/projects', projectRouter);

// Error handler
app.use((err, req, res, next) => {
  console.error(err);
  res.status(500).json({
    success: false,
    data: null,
    error: 'Internal server error'
  });
});

// Initialize
async function start() {
  await initDatabase();
  app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
  });
}

start();
```

---

## Thử Nghiệm

<div class="try-it">

### Mini Project: Notes App

Áp dụng Spec-Kit workflow để xây dựng app ghi chú đơn giản:

1. **Constitution**: Định nghĩa tech stack (có thể giống Task Manager)

2. **Specification**:
   - Tạo, sửa, xóa notes
   - Markdown support
   - Search notes
   - Tags/categories

3. **Plan**: Vẽ architecture, design API, list components

4. **Tasks**: Chia thành tasks nhỏ, estimate effort

5. **Implement**: Code theo tasks

</div>

### Câu hỏi reflection

1. Bước nào mất nhiều thời gian nhất? Tại sao?
2. Specification có đủ chi tiết chưa? Có phải quay lại bổ sung không?
3. Plan có miss edge case nào không?

---

## Tiếp Theo

Đọc [Best Practices](best-practices.md) để học các tips và patterns nâng cao.

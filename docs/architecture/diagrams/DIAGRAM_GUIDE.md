# Architecture Diagrams

This guide provides Mermaid diagram templates for documenting your architecture.

> **Tip:** GitHub renders Mermaid diagrams automatically. Most AI assistants can also generate and modify these diagrams.

## Quick Reference

| Diagram Type | Best For |
|--------------|----------|
| Flowchart | User flows, process flows, decision trees |
| Sequence | API interactions, service communication |
| Class | Data models, entity relationships |
| State | Status workflows, lifecycle management |
| ER | Database schemas |
| C4 Context | High-level system overview |

---

## System Context (C4 Model)

Shows your system and how it interacts with users and external systems.

```mermaid
C4Context
    title System Context Diagram

    Person(user, "User", "A user of the system")

    System(system, "Your System", "Core application")

    System_Ext(email, "Email Service", "Sends notifications")
    System_Ext(payment, "Payment Gateway", "Processes payments")
    System_Ext(auth, "Auth Provider", "OAuth/SSO")

    Rel(user, system, "Uses")
    Rel(system, email, "Sends emails via")
    Rel(system, payment, "Processes payments via")
    Rel(system, auth, "Authenticates via")
```

---

## Flowchart - User Journey

Shows how users navigate through your application.

```mermaid
flowchart TD
    Start([User Visits Site]) --> Auth{Authenticated?}

    Auth -->|No| Login[Login Page]
    Auth -->|Yes| Dashboard[Dashboard]

    Login --> Creds[Enter Credentials]
    Creds --> Validate{Valid?}
    Validate -->|No| Error[Show Error]
    Error --> Creds
    Validate -->|Yes| Dashboard

    Dashboard --> Action{User Action}
    Action -->|View| ViewData[View Data]
    Action -->|Create| CreateForm[Create Form]
    Action -->|Settings| Settings[User Settings]

    ViewData --> Dashboard
    CreateForm --> Save[Save Data]
    Save --> Dashboard
    Settings --> Dashboard
```

---

## Sequence Diagram - API Flow

Shows how services communicate for a specific operation.

```mermaid
sequenceDiagram
    autonumber

    actor User
    participant Client
    participant API
    participant Auth
    participant DB
    participant Cache

    User->>Client: Click Login
    Client->>API: POST /auth/login
    API->>Auth: Validate credentials
    Auth-->>API: Token + User info
    API->>Cache: Store session
    API-->>Client: 200 OK + Token
    Client-->>User: Redirect to Dashboard

    User->>Client: Request Data
    Client->>API: GET /data (with token)
    API->>Cache: Check cache

    alt Cache Hit
        Cache-->>API: Cached data
    else Cache Miss
        API->>DB: Query data
        DB-->>API: Results
        API->>Cache: Store in cache
    end

    API-->>Client: 200 OK + Data
    Client-->>User: Display Data
```

---

## Class Diagram - Data Models

Shows your domain entities and their relationships.

```mermaid
classDiagram
    class User {
        +String id
        +String email
        +String name
        +DateTime createdAt
        +authenticate()
        +updateProfile()
    }

    class Organization {
        +String id
        +String name
        +String plan
        +addMember()
        +removeMember()
    }

    class Project {
        +String id
        +String name
        +String status
        +DateTime deadline
        +addTask()
        +archive()
    }

    class Task {
        +String id
        +String title
        +String status
        +DateTime dueDate
        +complete()
        +assign()
    }

    User "1" --> "*" Organization : belongs to
    Organization "1" --> "*" Project : has
    Project "1" --> "*" Task : contains
    User "1" --> "*" Task : assigned to
```

---

## State Diagram - Status Workflow

Shows the lifecycle states of an entity.

```mermaid
stateDiagram-v2
    [*] --> Draft: Create

    Draft --> Review: Submit
    Draft --> Draft: Edit

    Review --> Approved: Approve
    Review --> Draft: Request Changes
    Review --> Rejected: Reject

    Approved --> Published: Publish
    Approved --> Draft: Unpublish

    Published --> Archived: Archive
    Published --> Draft: Unpublish

    Rejected --> Draft: Revise
    Rejected --> [*]: Delete

    Archived --> [*]: Delete

    note right of Review
        Requires reviewer
        with permission
    end note

    note right of Published
        Visible to
        all users
    end note
```

---

## Entity Relationship - Database Schema

Shows database tables and their relationships.

```mermaid
erDiagram
    USERS {
        uuid id PK
        string email UK
        string password_hash
        string name
        timestamp created_at
        timestamp updated_at
    }

    ORGANIZATIONS {
        uuid id PK
        string name
        string plan
        timestamp created_at
    }

    MEMBERSHIPS {
        uuid id PK
        uuid user_id FK
        uuid org_id FK
        string role
        timestamp joined_at
    }

    PROJECTS {
        uuid id PK
        uuid org_id FK
        string name
        string status
        timestamp deadline
    }

    TASKS {
        uuid id PK
        uuid project_id FK
        uuid assignee_id FK
        string title
        text description
        string status
        timestamp due_date
    }

    USERS ||--o{ MEMBERSHIPS : "has"
    ORGANIZATIONS ||--o{ MEMBERSHIPS : "has"
    ORGANIZATIONS ||--o{ PROJECTS : "owns"
    PROJECTS ||--o{ TASKS : "contains"
    USERS ||--o{ TASKS : "assigned"
```

---

## Architecture Overview

Shows the high-level system architecture.

```mermaid
flowchart TB
    subgraph Client["Client Layer"]
        Web[Web App]
        Mobile[Mobile App]
        CLI[CLI Tool]
    end

    subgraph Gateway["API Gateway"]
        LB[Load Balancer]
        Auth[Auth Middleware]
        Rate[Rate Limiter]
    end

    subgraph Services["Service Layer"]
        API[API Service]
        Worker[Background Workers]
        Scheduler[Task Scheduler]
    end

    subgraph Data["Data Layer"]
        DB[(PostgreSQL)]
        Cache[(Redis)]
        Search[(Elasticsearch)]
        Queue[(Message Queue)]
    end

    subgraph External["External Services"]
        Email[Email Provider]
        Storage[Cloud Storage]
        Analytics[Analytics]
    end

    Web & Mobile & CLI --> LB
    LB --> Auth --> Rate --> API

    API --> DB
    API --> Cache
    API --> Search
    API --> Queue

    Queue --> Worker
    Scheduler --> Worker

    Worker --> Email
    Worker --> Storage
    API --> Analytics
```

---

## Deployment Architecture

Shows how your system is deployed.

```mermaid
flowchart TB
    subgraph Internet
        Users[Users]
        CDN[CDN / Edge]
    end

    subgraph Cloud["Cloud Provider"]
        subgraph Public["Public Subnet"]
            LB[Load Balancer]
            Bastion[Bastion Host]
        end

        subgraph Private["Private Subnet"]
            subgraph Compute["Compute"]
                App1[App Server 1]
                App2[App Server 2]
                Worker1[Worker 1]
            end

            subgraph Database["Database"]
                Primary[(Primary DB)]
                Replica[(Read Replica)]
            end

            Cache[(Redis Cluster)]
        end
    end

    Users --> CDN --> LB
    LB --> App1 & App2
    App1 & App2 --> Primary
    App1 & App2 --> Replica
    App1 & App2 --> Cache
    Worker1 --> Primary
    Worker1 --> Cache
    Bastion -.-> Compute
    Primary --> Replica
```

---

## Usage Tips

### In Your Documentation

1. **Create focused diagrams** - One concept per diagram
2. **Keep them updated** - Outdated diagrams are worse than none
3. **Add context** - Include a brief description above each diagram
4. **Link to code** - Reference relevant files or modules

### With AI Assistants

```
"Generate a sequence diagram showing the checkout flow"
"Update this ER diagram to add a comments table"
"Create a state diagram for order status"
```

### Best Practices

- Use consistent naming across diagrams
- Color-code by type (services, databases, external)
- Include a legend for complex diagrams
- Version control your diagrams with your code

---

## Resources

- [Mermaid Documentation](https://mermaid.js.org/intro/)
- [Mermaid Live Editor](https://mermaid.live/)
- [C4 Model](https://c4model.com/)
- [GitHub Mermaid Support](https://github.blog/2022-02-14-include-diagrams-markdown-files-mermaid/)

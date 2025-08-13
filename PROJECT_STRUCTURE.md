# Angkat Trading Enterprise - Project Structure

## Overview
This is a production-ready monorepo for Angkat Trading Enterprise, featuring a Next.js web application, shared TypeScript packages, comprehensive database schema, and detailed documentation for mobile development.

## Monorepo Structure

```
angkat-trading-enterprise/
├── 📁 apps/
│   └── 📁 web/                          # Next.js 14 Web Application
│       ├── 📁 app/                      # App Router (Next.js 14)
│       │   ├── 📁 admin/                # Protected admin routes
│       │   ├── 📁 api/                  # API route handlers
│       │   ├── 📁 inquire/              # Public inquiry form
│       │   ├── 📁 track/                # Public inquiry tracking
│       │   ├── 📁 status/               # Public system status
│       │   ├── globals.css              # Global styles + theme variables
│       │   ├── layout.tsx               # Root layout with metadata
│       │   └── page.tsx                 # Home page
│       ├── 📁 src/
│       │   ├── 📁 components/           # React components
│       │   │   ├── 📁 ui/               # shadcn/ui components
│       │   │   ├── theme-provider.tsx   # Dark/light mode
│       │   │   └── toaster.tsx          # Toast notifications
│       │   ├── 📁 hooks/                # Custom React hooks
│       │   ├── 📁 lib/                  # Utilities & config
│       │   │   └── supabase.ts          # Supabase clients
│       │   ├── 📁 types/                # TypeScript types
│       │   └── 📁 utils/                # Helper functions
│       ├── 📁 public/                   # Static assets
│       ├── next.config.js               # Next.js config + security headers
│       ├── tailwind.config.js           # Tailwind CSS config
│       ├── postcss.config.js            # PostCSS config
│       ├── tsconfig.json                # TypeScript config
│       └── package.json                 # Web app dependencies
│
├── 📁 packages/
│   └── 📁 shared/                       # Shared TypeScript Package
│       ├── 📁 src/
│       │   ├── types.ts                 # All DTOs & interfaces
│       │   ├── schemas.ts               # Zod validation schemas
│       │   └── index.ts                 # Package exports
│       ├── openapi.json                 # OpenAPI 3.0.3 specification
│       ├── package.json                 # Package config
│       └── tsconfig.json                # TypeScript config
│
├── 📁 supabase/                         # Database & Backend
│   └── 📁 sql/
│       ├── schema.sql                   # Complete database schema
│       ├── policies.sql                 # Row Level Security policies
│       └── seed.sql                     # Initial data & test data
│
├── 📁 docs/                             # Comprehensive Documentation
│   ├── 01-setup-supabase.md            # Supabase setup guide
│   ├── 02-web-setup-vercel.md          # Web app setup & deployment
│   ├── 03-api-reference.md             # API documentation
│   ├── 04-mobile-admin-guide.md        # Flutter implementation guide
│   ├── 05-security-checklist.md        # Security best practices
│   ├── 06-theming-and-cms.md           # Theming & content management
│   ├── 07-reports-and-exports.md       # Reporting & data export
│   └── 08-roadmap.md                   # Future development plans
│
├── 📁 .github/                          # CI/CD & Automation
│   └── 📁 workflows/
│       └── ci-cd.yml                    # GitHub Actions workflow
│
├── package.json                          # Root monorepo config
├── pnpm-workspace.yaml                  # pnpm workspace config
├── setup.bat                            # Windows setup script
├── README.md                            # Project overview
└── PROJECT_STRUCTURE.md                 # This file
```

## Key Components

### 🚀 Web Application (`apps/web/`)
- **Framework**: Next.js 14 with App Router
- **UI**: Tailwind CSS + shadcn/ui components
- **State**: SWR for data fetching, React Hook Form + Zod
- **Charts**: Recharts for analytics
- **Security**: Strict CSP, HSTS, rate limiting, hCaptcha
- **Features**: Public pages, admin dashboard, real-time chat, file management

### 📦 Shared Package (`packages/shared/`)
- **Types**: Complete TypeScript interfaces for all DTOs
- **Validation**: Zod schemas for runtime type checking
- **API**: OpenAPI 3.0.3 specification
- **Usage**: Imported by web app and referenced by mobile guide

### 🗄️ Database (`supabase/sql/`)
- **Schema**: 12+ tables with proper relationships
- **Security**: Row Level Security (RLS) policies
- **Functions**: `has_permission()`, `log_audit_event()`
- **Views**: Monthly inquiry analytics
- **Seed**: Initial roles, permissions, and test data

### 📱 Mobile Guide (`docs/04-mobile-admin-guide.md`)
- **Goal**: 1:1 functional parity with web admin
- **Architecture**: Riverpod/Bloc recommendations
- **Integration**: Same REST API + Supabase Realtime
- **Security**: Equivalent security measures
- **No Code**: Pure documentation for mobile team

### 🔒 Security Features
- **Database**: RLS policies, permission-based access
- **API**: Rate limiting, hCaptcha, JWT validation
- **Web**: CSP, HSTS, X-Frame-Options, audit logging
- **Mobile**: TLS pinning, secure storage, offline cache

### 🎨 Theming & CMS
- **Default**: Blue palette (#1976D2, #42A5F5, #0277BD)
- **System**: CSS variables + shadcn/ui
- **Admin**: JSON-based content editor
- **Mobile**: Material3 mapping guide

## Technology Stack

### Frontend
- **React 18** with Next.js 14 App Router
- **TypeScript** for type safety
- **Tailwind CSS** for styling
- **shadcn/ui** for component library
- **SWR** for data fetching

### Backend
- **Supabase** (PostgreSQL + Auth + Storage + Realtime)
- **Next.js API Routes** for REST endpoints
- **Row Level Security** for data protection
- **Custom SQL functions** for business logic

### Development
- **pnpm** for monorepo management
- **ESLint + Prettier** for code quality
- **GitHub Actions** for CI/CD
- **Vercel** for deployment

### Mobile (Guide Only)
- **Flutter** framework
- **Riverpod/Bloc** for state management
- **dio** for HTTP client
- **supabase_flutter** for backend integration

## Getting Started

### Prerequisites
- Node.js 20+
- pnpm 8+
- Supabase CLI
- Docker (for local Supabase)

### Quick Start
```bash
# Clone and setup
git clone <repository>
cd angkat-trading-enterprise

# Run Windows setup script
setup.bat

# Or manual setup
pnpm install
pnpm --filter @apps/web setup:shadcn
supabase start
psql -f supabase/sql/schema.sql
psql -f supabase/sql/policies.sql
psql -f supabase/sql/seed.sql

# Start development
pnpm dev
```

### Environment Variables
```bash
# Required
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_anon_key
SUPABASE_SERVICE_ROLE=your_service_role

# Optional
HCAPTCHA_SECRET=your_hcaptcha_secret
RATE_LIMIT_WINDOW=900000
RATE_LIMIT_MAX=100
```

## Development Workflow

### 1. Database Changes
```bash
# Edit schema.sql, policies.sql, or seed.sql
# Apply changes
supabase db reset
# or
psql -f supabase/sql/schema.sql
```

### 2. Shared Package Updates
```bash
# Edit types or schemas
cd packages/shared
pnpm build
# Changes automatically available in web app
```

### 3. Web App Development
```bash
cd apps/web
pnpm dev
# App runs on http://localhost:3000
```

### 4. Mobile Development
- Follow `docs/04-mobile-admin-guide.md`
- Use OpenAPI spec from `packages/shared/openapi.json`
- Implement same REST contracts and Realtime channels

## Deployment

### Web App (Vercel)
```bash
# Automatic via GitHub Actions
# Or manual deployment
vercel --prod
```

### Database (Supabase)
```bash
# Production setup
supabase projects create angkat-trading
supabase link --project-ref <project-ref>
supabase db push
```

## Security Checklist

- [ ] RLS policies enabled on all tables
- [ ] API rate limiting configured
- [ ] hCaptcha on public endpoints
- [ ] Security headers enabled
- [ ] Audit logging active
- [ ] File upload scanning (optional)
- [ ] JWT expiration configured
- [ ] CORS properly configured

## Mobile Team Integration

The mobile team should:

1. **Read** `docs/04-mobile-admin-guide.md` completely
2. **Reference** `packages/shared/openapi.json` for API contracts
3. **Implement** same security measures as web app
4. **Test** against staging environment
5. **Deploy** with same feature parity

## Support & Maintenance

- **Documentation**: All guides include troubleshooting sections
- **Monitoring**: Built-in status endpoints and audit logs
- **Updates**: Regular dependency updates via Dependabot
- **Backup**: Database backup strategies documented

---

**Created by Jack Daniel Pineda**  
*Senior Full-Stack Engineer + UI/UX Developer*

**Angkat Trading Enterprise**  
*Bridging Philippine quality to the world*  
📧 angkattrading@gmail.com | 📱 +63 917 192 0188

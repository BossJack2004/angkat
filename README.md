# Angkat Trading Enterprise

**Bridging Philippine quality to the world.**

A comprehensive import/export and logistics management system for Angkat Trading, established 2019. Features inquiry management, real-time chat, content management, and comprehensive reporting.

## 🏗️ Architecture

- **Frontend**: Next.js 14 (React, App Router), TypeScript, Tailwind CSS, shadcn/ui
- **Backend**: Supabase (PostgreSQL, Auth, Storage, Realtime)
- **API**: REST-first with Next.js Route Handlers, OpenAPI specification
- **Mobile**: Comprehensive Flutter integration guide (see `docs/04-mobile-admin-guide.md`)

## 🚀 Quick Start

### Prerequisites
- Node.js 20+
- pnpm 8+
- Supabase CLI
- Docker (optional, for local Supabase)

### Setup
```bash
# Install dependencies
pnpm install

# Setup shadcn/ui components
pnpm setup

# Start local Supabase (or connect to hosted)
supabase start

# Apply database schema
supabase db reset
# OR manually:
# psql -f supabase/sql/schema.sql
# psql -f supabase/sql/policies.sql  
# psql -f supabase/sql/seed.sql

# Start development server
pnpm dev
```

### Environment Variables
Create `.env.local` in `apps/web/`:
```env
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_anon_key
SUPABASE_SERVICE_ROLE=your_service_role
HCAPTCHA_SECRET=your_hcaptcha_secret
RATE_LIMIT_WINDOW=60
RATE_LIMIT_MAX=20
```

## 📱 Mobile Development

For Flutter mobile admin app development, see:
- `docs/04-mobile-admin-guide.md` - Complete implementation guide
- `packages/shared/` - Shared DTOs and OpenAPI specification

## 🏢 Company Information

- **Name**: Angkat Trading Enterprise
- **Established**: 2019
- **Services**: Import/Export, Customs Management, Logistics & Cold Chain
- **Markets**: China, Malaysia, Korea, Taiwan
- **HQ**: Tuguegarao City, Cagayan Valley, Philippines
- **Specialty**: IQF Vannamei Shrimp Distribution
- **Contact**: +63 917 192 0188, angkattrading@gmail.com

## 📚 Documentation

- `docs/01-setup-supabase.md` - Database setup and configuration
- `docs/02-web-setup-vercel.md` - Web deployment guide
- `docs/03-api-reference.md` - API endpoints and OpenAPI
- `docs/04-mobile-admin-guide.md` - Flutter mobile implementation guide
- `docs/05-security-checklist.md` - Security best practices
- `docs/06-theming-and-cms.md` - Theme and content management
- `docs/07-reports-and-exports.md` - Reporting and data export
- `docs/08-roadmap.md` - Development roadmap

## 🔒 Security Features

- Row Level Security (RLS) on all tables
- Role-based access control (RBAC)
- Rate limiting on public endpoints
- hCaptcha integration
- Audit logging for all admin actions
- Short-lived JWT tokens for public access

## 🎨 Theming

Default blue palette:
- Primary: #1976D2
- Primary Light: #42A5F5  
- Primary Dark: #0277BD

Fully customizable via admin panel with real-time preview.

## 📊 Features

### Public
- Dynamic landing page with CMS sections
- Inquiry submission with file attachments
- Ticket tracking and live chat
- System status monitoring

### Admin (Staff)
- Dashboard with KPIs and charts
- Inquiry management and assignment
- Real-time chat with customers
- Content management system
- User and role management
- Comprehensive reporting
- System monitoring and settings

## 🚀 Deployment

### Web App (Vercel)
```bash
pnpm build
# Deploy to Vercel with environment variables
```

### Database (Supabase)
```bash
# Apply schema to hosted Supabase
supabase db push --db-url "your_connection_string"
```

## 🤝 Contributing

1. Follow the established architecture patterns
2. Ensure all changes include proper RLS policies
3. Add audit logging for admin actions
4. Test with the provided test suite
5. Update relevant documentation

## 📄 License

Private - Angkat Trading Enterprise

---

**Created by Jack Daniel Pineda**

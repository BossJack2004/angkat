@echo off
REM Angkat Trading Enterprise - Complete Setup Script (Windows)
REM Created by Jack Daniel Pineda

echo 🚀 Setting up Angkat Trading Enterprise Monorepo...
echo.

REM Check prerequisites
echo [INFO] Checking prerequisites...

REM Check Node.js
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Node.js is not installed. Please install Node.js 20+ first.
    pause
    exit /b 1
)

echo [SUCCESS] Node.js ✓

REM Check pnpm
pnpm --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [WARNING] pnpm is not installed. Installing pnpm...
    npm install -g pnpm
)

echo [SUCCESS] pnpm ✓

REM Check Supabase CLI
supabase --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [WARNING] Supabase CLI is not installed. Installing...
    npm install -g supabase
)

echo [SUCCESS] Supabase CLI ✓

REM Install dependencies
echo [INFO] Installing dependencies...
pnpm install
if %errorlevel% neq 0 (
    echo [ERROR] Failed to install dependencies
    pause
    exit /b 1
)
echo [SUCCESS] Dependencies installed ✓

REM Setup shadcn/ui
echo [INFO] Setting up shadcn/ui components...
cd apps\web
pnpm setup:shadcn
cd ..\..
echo [SUCCESS] shadcn/ui setup completed ✓

REM Create environment file
echo [INFO] Creating environment file...
(
echo # Supabase Configuration
echo NEXT_PUBLIC_SUPABASE_URL=your_supabase_url_here
echo NEXT_PUBLIC_SUPABASE_ANON_KEY=your_anon_key_here
echo SUPABASE_SERVICE_ROLE=your_service_role_here
echo.
echo # hCaptcha ^(use dev keys for local^)
echo HCAPTCHA_SECRET=0x0000000000000000000000000000000000000000
echo.
echo # Rate Limiting
echo RATE_LIMIT_WINDOW=60
echo RATE_LIMIT_MAX=20
echo.
echo # App URL
echo NEXT_PUBLIC_APP_URL=http://localhost:3000
) > apps\web\.env.local

echo [SUCCESS] Environment file created ✓

REM Build shared package
echo [INFO] Building shared package...
pnpm --filter @angkat-trading/shared build
echo [SUCCESS] Shared package built ✓

REM Test build
echo [INFO] Testing build...
pnpm --filter @angkat-trading/web build
echo [SUCCESS] Web app builds successfully ✓

echo.
echo 🎉 Setup completed successfully!
echo.
echo Next steps:
echo 1. Start the development server:
echo    pnpm dev
echo.
echo 2. Open your browser to:
echo    http://localhost:3000
echo.
echo 3. For admin access, create a user in Supabase and assign admin role
echo.
echo 4. Check the documentation in the docs/ folder
echo.
echo 5. For mobile development, see docs/04-mobile-admin-guide.md
echo.
echo 6. Update apps/web/.env.local with your Supabase credentials
echo.
pause

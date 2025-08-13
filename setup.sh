#!/bin/bash

# Angkat Trading Enterprise - Complete Setup Script
# Created by Jack Daniel Pineda

set -e

echo "🚀 Setting up Angkat Trading Enterprise Monorepo..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check prerequisites
check_prerequisites() {
    print_status "Checking prerequisites..."
    
    # Check Node.js
    if ! command -v node &> /dev/null; then
        print_error "Node.js is not installed. Please install Node.js 20+ first."
        exit 1
    fi
    
    NODE_VERSION=$(node --version | cut -d'v' -f2 | cut -d'.' -f1)
    if [ "$NODE_VERSION" -lt 20 ]; then
        print_error "Node.js version 20+ is required. Current version: $(node --version)"
        exit 1
    fi
    
    print_success "Node.js $(node --version) ✓"
    
    # Check pnpm
    if ! command -v pnpm &> /dev/null; then
        print_warning "pnpm is not installed. Installing pnpm..."
        npm install -g pnpm
    fi
    
    print_success "pnpm $(pnpm --version) ✓"
    
    # Check Supabase CLI
    if ! command -v supabase &> /dev/null; then
        print_warning "Supabase CLI is not installed. Installing..."
        npm install -g supabase
    fi
    
    print_success "Supabase CLI ✓"
    
    # Check Docker (optional)
    if ! command -v docker &> /dev/null; then
        print_warning "Docker is not installed. Local Supabase will not work without Docker."
        print_warning "You can still connect to a hosted Supabase instance."
    else
        print_success "Docker ✓"
    fi
}

# Install dependencies
install_dependencies() {
    print_status "Installing dependencies..."
    pnpm install
    print_success "Dependencies installed ✓"
}

# Setup shadcn/ui
setup_shadcn() {
    print_status "Setting up shadcn/ui components..."
    cd apps/web
    pnpm setup:shadcn
    cd ../..
    print_success "shadcn/ui setup completed ✓"
}

# Setup local Supabase (if Docker is available)
setup_local_supabase() {
    if command -v docker &> /dev/null; then
        print_status "Setting up local Supabase..."
        
        # Check if Supabase is already running
        if supabase status &> /dev/null; then
            print_warning "Supabase is already running. Stopping first..."
            supabase stop
        fi
        
        # Initialize and start Supabase
        if [ ! -f "supabase/config.toml" ]; then
            supabase init
        fi
        
        supabase start
        
        # Extract connection details
        SUPABASE_URL=$(supabase status | grep "API URL" | awk '{print $3}')
        SUPABASE_ANON_KEY=$(supabase status | grep "anon key" | awk '{print $3}')
        SUPABASE_SERVICE_ROLE=$(supabase status | grep "service_role key" | awk '{print $3}')
        
        print_success "Local Supabase started ✓"
        print_status "API URL: $SUPABASE_URL"
        print_status "Anon Key: $SUPABASE_ANON_KEY"
        
        # Create .env.local file
        create_env_file "$SUPABASE_URL" "$SUPABASE_ANON_KEY" "$SUPABASE_SERVICE_ROLE"
        
    else
        print_warning "Docker not available. Skipping local Supabase setup."
        print_status "Please set up your environment variables manually."
        create_env_file "" "" ""
    fi
}

# Create environment file
create_env_file() {
    local supabase_url="$1"
    local anon_key="$2"
    local service_role="$3"
    
    print_status "Creating environment file..."
    
    cat > apps/web/.env.local << EOF
# Supabase Configuration
NEXT_PUBLIC_SUPABASE_URL=${supabase_url:-your_supabase_url_here}
NEXT_PUBLIC_SUPABASE_ANON_KEY=${anon_key:-your_anon_key_here}
SUPABASE_SERVICE_ROLE=${service_role:-your_service_role_here}

# hCaptcha (use dev keys for local)
HCAPTCHA_SECRET=0x0000000000000000000000000000000000000000

# Rate Limiting
RATE_LIMIT_WINDOW=60
RATE_LIMIT_MAX=20

# App URL
NEXT_PUBLIC_APP_URL=http://localhost:3000
EOF
    
    print_success "Environment file created ✓"
}

# Apply database schema
apply_database_schema() {
    if command -v docker &> /dev/null && supabase status &> /dev/null; then
        print_status "Applying database schema..."
        
        # Get database URL from Supabase status
        DB_URL=$(supabase status | grep "DB URL" | awk '{print $3}')
        
        if [ -n "$DB_URL" ]; then
            # Apply schema files
            psql "$DB_URL" -f supabase/sql/schema.sql
            psql "$DB_URL" -f supabase/sql/policies.sql
            psql "$DB_URL" -f supabase/sql/seed.sql
            
            print_success "Database schema applied ✓"
        else
            print_warning "Could not determine database URL. Please apply schema manually."
        fi
    else
        print_warning "Local Supabase not available. Please apply schema manually to your hosted instance."
    fi
}

# Build shared package
build_shared() {
    print_status "Building shared package..."
    pnpm --filter @angkat-trading/shared build
    print_success "Shared package built ✓"
}

# Test build
test_build() {
    print_status "Testing build..."
    pnpm --filter @angkat-trading/web build
    print_success "Web app builds successfully ✓"
}

# Print next steps
print_next_steps() {
    echo
    echo -e "${GREEN}🎉 Setup completed successfully!${NC}"
    echo
    echo "Next steps:"
    echo "1. Start the development server:"
    echo "   ${BLUE}pnpm dev${NC}"
    echo
    echo "2. Open your browser to:"
    echo "   ${BLUE}http://localhost:3000${NC}"
    echo
    echo "3. For admin access, create a user in Supabase and assign admin role"
    echo
    echo "4. Check the documentation in the docs/ folder"
    echo
    echo "5. For mobile development, see docs/04-mobile-admin-guide.md"
    echo
}

# Main setup function
main() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}  Angkat Trading Enterprise${NC}"
    echo -e "${BLUE}  Complete Setup Script${NC}"
    echo -e "${BLUE}================================${NC}"
    echo
    
    check_prerequisites
    install_dependencies
    setup_shadcn
    setup_local_supabase
    apply_database_schema
    build_shared
    test_build
    print_next_steps
}

# Run main function
main "$@"

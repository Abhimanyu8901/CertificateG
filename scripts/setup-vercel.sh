#!/bin/bash

# Certificate Generation System - Vercel Setup Script

echo "🚀 Setting up Certificate Generator for Vercel Deployment"
echo "======================================================="

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "📝 Initializing Git repository..."
    git init
    echo "⚠️  Remember to create a GitHub repository and add it as remote:"
    echo "   git remote add origin https://github.com/yourusername/certificate-generator.git"
else
    echo "✅ Git repository already initialized"
fi

# Create .gitignore if it doesn't exist
if [ ! -f ".gitignore" ]; then
    echo "📝 Creating .gitignore file..."
    cat > .gitignore << EOL
# Environment variables
.env
.env.local
.env.production

# Python
__pycache__/
*.pyc
*.pyo
*.pyd
.Python
*.so

# Local development files
certificates/
qr_codes/
certificates.db*

# Vercel
.vercel

# OS files
.DS_Store
Thumbs.db

# IDE files
.vscode/
.idea/
EOL
    echo "✅ .gitignore created"
else
    echo "✅ .gitignore already exists"
fi

# Check for required files
echo "🔍 Checking Vercel configuration files..."

required_files=("vercel.json" "vercel_app.py" "requirements-vercel.txt" ".vercelignore")
for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file exists"
    else
        echo "❌ $file missing - please ensure all Vercel config files are present"
    fi
done

# Create sample .env file
if [ ! -f ".env.example" ]; then
    echo "📝 Creating .env.example file..."
    cat > .env.example << EOL
# Certificate Generation System - Environment Variables for Vercel

# Application Configuration
SECRET_KEY=change-this-to-a-random-secret-key-in-production

# Email Configuration (Required for email sending)
SMTP_SERVER=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your-email@gmail.com
SMTP_PASSWORD=your-gmail-app-password

# Twilio Configuration (Optional - for WhatsApp)
TWILIO_ACCOUNT_SID=your-twilio-account-sid
TWILIO_AUTH_TOKEN=your-twilio-auth-token
TWILIO_PHONE_NUMBER=+1234567890

# Database Configuration (Optional - for external database)
# DATABASE_URL=postgresql://user:password@host:port/database
EOL
    echo "✅ .env.example created"
fi

echo ""
echo "📋 Next Steps for Vercel Deployment:"
echo "===================================="
echo ""
echo "1. 🔧 Configure Environment Variables:"
echo "   - Copy .env.example to .env"
echo "   - Update with your actual credentials"
echo "   - Set these same variables in Vercel dashboard"
echo ""
echo "2. 📤 Push to GitHub:"
echo "   - Create repository on GitHub"
echo "   - git remote add origin https://github.com/yourusername/repo-name.git"
echo "   - git add ."
echo "   - git commit -m 'Deploy Certificate Generator to Vercel'"
echo "   - git push -u origin main"
echo ""
echo "3. 🚀 Deploy on Vercel:"
echo "   - Go to vercel.com and sign in with GitHub"
echo "   - Import your repository"
echo "   - Configure environment variables"
echo "   - Deploy!"
echo ""
echo "4. 📖 Read the full guide:"
echo "   - Check docs/VERCEL_DEPLOYMENT.md for detailed instructions"
echo ""
echo "🎉 Setup complete! Ready for Vercel deployment."
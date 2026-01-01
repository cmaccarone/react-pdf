#!/bin/bash

# Script to publish packages to GitHub Packages
# Make sure NODE_AUTH_TOKEN is set before running this script

set -e

echo "🔍 Checking for NODE_AUTH_TOKEN..."
if [ -z "$NODE_AUTH_TOKEN" ]; then
    echo "❌ ERROR: NODE_AUTH_TOKEN is not set!"
    echo "Please set your GitHub Personal Access Token:"
    echo "  export NODE_AUTH_TOKEN=your_github_token_here"
    exit 1
fi

echo "✅ NODE_AUTH_TOKEN is set"

echo ""
echo "📦 Building all packages..."
yarn build

echo ""
echo "🚀 Publishing to GitHub Packages..."
yarn release

echo ""
echo "✅ Publishing complete!"
echo ""
echo "📝 Your packages are now available at:"
echo "   https://github.com/cmaccarone?tab=packages"


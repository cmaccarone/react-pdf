# Local Publishing Guide

This is a quick guide for publishing packages to GitHub Packages from your local machine.

## One-Time Setup

### 1. Create a GitHub Personal Access Token

1. Go to https://github.com/settings/tokens
2. Click "Generate new token (classic)"
3. Give it a name like "react-pdf publishing"
4. Select these scopes:
   - ✅ `write:packages` - to publish packages
   - ✅ `read:packages` - to download packages
   - ✅ `repo` - for private repositories
5. Click "Generate token"
6. **Copy the token immediately** (you won't be able to see it again!)

### 2. Set Your Token

Add this to your `~/.zshrc` (or `~/.bashrc` if using bash):

```bash
export NODE_AUTH_TOKEN=ghp_your_token_here
```

Then reload your shell:

```bash
source ~/.zshrc
```

**Verify it's set:**
```bash
echo $NODE_AUTH_TOKEN
```

You should see your token printed.

## Publishing

Every time you want to publish:

### Easy Way (Recommended)

Just run:
```bash
./publish.sh
```

That's it! The script will:
- ✅ Check your token is set
- ✅ Build all packages
- ✅ Publish to GitHub Packages

### Manual Way

If you prefer to do it step by step:

```bash
# 1. Optional: Create a changeset if you made changes
yarn changeset

# 2. Optional: Update versions
yarn version-packages

# 3. Build packages
yarn build

# 4. Publish
yarn release
```

## Verifying Publication

After publishing, check that your packages are live:

1. Go to https://github.com/cmaccarone?tab=packages
2. You should see all your `@cmaccarone/react-pdf-*` packages listed

## Using Your Published Packages

To use these packages in another project:

1. **Create `.npmrc` in your project:**
   ```bash
   echo "//npm.pkg.github.com/:_authToken=\${NODE_AUTH_TOKEN}" > .npmrc
   echo "@cmaccarone:registry=https://npm.pkg.github.com" >> .npmrc
   ```

2. **Install:**
   ```bash
   npm install @cmaccarone/react-pdf-renderer
   # or
   yarn add @cmaccarone/react-pdf-renderer
   ```

## Troubleshooting

### "NODE_AUTH_TOKEN is not set"
```bash
export NODE_AUTH_TOKEN=your_token_here
```

### "401 Unauthorized"
- Check your token hasn't expired
- Verify it has the correct scopes
- Make sure `.npmrc` file exists in the project root

### "403 Forbidden"
- Ensure you're the owner of the GitHub repository
- Check the package scope matches your username (`@cmaccarone`)

### Build Errors
```bash
# Clean and rebuild
rm -rf packages/*/lib
yarn build
```

## Quick Reference

| Command | Description |
|---------|-------------|
| `./publish.sh` | Build and publish everything |
| `yarn build` | Build all packages |
| `yarn changeset` | Create a changeset |
| `yarn version-packages` | Update versions |
| `yarn release` | Publish to GitHub Packages |

## Notes

- All packages are **private** - only accessible to those with repo access
- Each package is versioned independently
- Publishing is manual and local (no CI/CD)


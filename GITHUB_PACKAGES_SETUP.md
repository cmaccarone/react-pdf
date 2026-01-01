# GitHub Packages Setup Summary

This document summarizes all changes made to configure this monorepo for publishing to GitHub Packages as private packages.

## Changes Made

### 1. Package Scope Updates

All packages have been renamed from `@react-pdf/*` to `@cmaccarone/*`:

- `@react-pdf/renderer` → `@cmaccarone/react-pdf-renderer`
- `@react-pdf/layout` → `@cmaccarone/react-pdf-layout`
- `@react-pdf/fns` → `@cmaccarone/react-pdf-fns`
- `@react-pdf/font` → `@cmaccarone/react-pdf-font`
- `@react-pdf/image` → `@cmaccarone/react-pdf-image`
- `@react-pdf/pdfkit` → `@cmaccarone/react-pdf-pdfkit`
- `@react-pdf/primitives` → `@cmaccarone/react-pdf-primitives`
- `@react-pdf/reconciler` → `@cmaccarone/react-pdf-reconciler`
- `@react-pdf/render` → `@cmaccarone/react-pdf-render`
- `@react-pdf/stylesheet` → `@cmaccarone/react-pdf-stylesheet`
- `@react-pdf/textkit` → `@cmaccarone/react-pdf-textkit`
- `@react-pdf/png-js` → `@cmaccarone/react-pdf-png-js`
- `@react-pdf/types` → `@cmaccarone/react-pdf-types`

### 2. Package Configuration

Each publishable package now includes:

```json
"publishConfig": {
  "registry": "https://npm.pkg.github.com",
  "access": "restricted"
}
```

### 3. Internal Dependencies

All internal dependencies have been updated to use the new `@cmaccarone/*` scope.

### 4. Repository URLs

All repository URLs have been updated from:
- `https://github.com/diegomura/react-pdf.git`

To:
- `https://github.com/cmaccarone/react-pdf.git`

### 5. Configuration Files

#### `.npmrc` (New)
Configures authentication for the `@cmaccarone` scope:
```
//npm.pkg.github.com/:_authToken=${NODE_AUTH_TOKEN}
@cmaccarone:registry=https://npm.pkg.github.com
```

#### `lerna.json` (Updated)
Added publish configuration:
```json
"command": {
  "publish": {
    "registry": "https://npm.pkg.github.com",
    "ignoreChanges": ["**/*.md", "**/*.test.ts", "**/*.test.tsx", "**/*.test.js"]
  }
}
```

#### `.changeset/config.json` (New)
Configured changesets for version management:
- Access: `restricted`
- Changelog: GitHub-based
- Ignores example packages

### 6. Helper Scripts

#### `publish.sh` (New)
Quick script to build and publish all packages:
```bash
./publish.sh
```

### 7. Documentation

#### `PUBLISHING.md` (New)
Comprehensive guide covering:
- Prerequisites and authentication
- Publishing steps (changesets and lerna)
- Installing published packages
- Troubleshooting
- CI/CD integration

## Next Steps

### Before Publishing

1. **Create a GitHub Personal Access Token**:
   - Go to https://github.com/settings/tokens
   - Click "Generate new token (classic)"
   - Select scopes: `write:packages`, `read:packages`, `repo`
   - Copy the token

2. **Set the token as an environment variable**:
   ```bash
   export NODE_AUTH_TOKEN=your_github_token_here
   ```

3. **Verify the setup**:
   ```bash
   echo $NODE_AUTH_TOKEN  # Should show your token
   ```

### Publishing

#### Option 1: Using the helper script
```bash
./publish.sh
```

#### Option 2: Manual steps
```bash
# 1. Create a changeset
yarn changeset

# 2. Version packages
yarn version-packages

# 3. Build
yarn build

# 4. Publish
yarn release
```

### After Publishing

1. **Verify packages are published**:
   - Visit: https://github.com/cmaccarone?tab=packages
   - You should see all published packages

2. **Test installation in another project**:
   ```bash
   # Create .npmrc in your project
   echo "//npm.pkg.github.com/:_authToken=\${NODE_AUTH_TOKEN}" > .npmrc
   echo "@cmaccarone:registry=https://npm.pkg.github.com" >> .npmrc
   
   # Install a package
   npm install @cmaccarone/react-pdf-renderer
   ```

## Important Notes

1. **Private Packages**: All packages are configured as private (`"access": "restricted"`). Only users with access to the repository can install them.

2. **Authentication Required**: Anyone installing these packages must have:
   - A GitHub account with access to the repository
   - A GitHub PAT with `read:packages` scope
   - Proper `.npmrc` configuration

3. **Monorepo Structure**: The internal dependencies are automatically managed by Lerna and Changesets.

4. **Version Management**: This setup uses independent versioning (each package has its own version).

## Troubleshooting

See `PUBLISHING.md` for detailed troubleshooting steps.

## Additional Resources

- [GitHub Packages Documentation](https://docs.github.com/en/packages)
- [Changesets Documentation](https://github.com/changesets/changesets)
- [Lerna Documentation](https://lerna.js.org/)


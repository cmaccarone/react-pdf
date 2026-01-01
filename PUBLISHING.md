# Publishing to GitHub Packages

This guide explains how to publish the react-pdf monorepo packages to GitHub Packages as private packages.

## Prerequisites

1. **GitHub Personal Access Token (PAT)**: You need a GitHub PAT with the following scopes:
   - `write:packages` - to publish packages
   - `read:packages` - to download packages
   - `repo` - for private repositories

   Create one at: https://github.com/settings/tokens

2. **Authentication Setup**: Set your token as an environment variable:
   ```bash
   export NODE_AUTH_TOKEN=your_github_token_here
   ```

   Or add it to your `~/.bashrc` or `~/.zshrc`:
   ```bash
   echo 'export NODE_AUTH_TOKEN=your_github_token_here' >> ~/.zshrc
   source ~/.zshrc
   ```

## Configuration

All packages have been configured with:
- Scoped package names: `@cmaccarone/react-pdf-*`
- GitHub Packages registry: `https://npm.pkg.github.com`
- Private access: `"access": "restricted"`

The `.npmrc` file in the root directory configures authentication for the `@cmaccarone` scope.

## Publishing Steps

### Option 1: Using Changesets (Recommended)

1. **Create a changeset** for your changes:
   ```bash
   yarn changeset
   ```
   Follow the prompts to describe your changes and select which packages are affected.

2. **Version packages** (updates package.json versions and changelogs):
   ```bash
   yarn version-packages
   ```

3. **Build all packages**:
   ```bash
   yarn build
   ```

4. **Publish to GitHub Packages**:
   ```bash
   yarn release
   ```

### Option 2: Using Lerna Directly

1. **Build all packages**:
   ```bash
   yarn build
   ```

2. **Publish with Lerna**:
   ```bash
   npx lerna publish --registry https://npm.pkg.github.com
   ```

## Installing Published Packages

To use these private packages in other projects:

1. **Create or update `.npmrc`** in your project:
   ```
   //npm.pkg.github.com/:_authToken=${NODE_AUTH_TOKEN}
   @cmaccarone:registry=https://npm.pkg.github.com
   ```

2. **Install packages**:
   ```bash
   npm install @cmaccarone/react-pdf-renderer
   # or
   yarn add @cmaccarone/react-pdf-renderer
   ```

## Package List

The following packages will be published:
- `@cmaccarone/react-pdf-renderer` - Main renderer package
- `@cmaccarone/react-pdf-layout` - Layout engine
- `@cmaccarone/react-pdf-fns` - Helper functions
- `@cmaccarone/react-pdf-font` - Font handling
- `@cmaccarone/react-pdf-image` - Image processing
- `@cmaccarone/react-pdf-pdfkit` - PDF generation
- `@cmaccarone/react-pdf-primitives` - Primitive components
- `@cmaccarone/react-pdf-reconciler` - React reconciler
- `@cmaccarone/react-pdf-render` - Render engine
- `@cmaccarone/react-pdf-stylesheet` - Stylesheet engine
- `@cmaccarone/react-pdf-textkit` - Text layout
- `@cmaccarone/react-pdf-png-js` - PNG decoder
- `@cmaccarone/react-pdf-types` - TypeScript definitions

## Troubleshooting

### Authentication Errors

If you get authentication errors:
1. Verify your `NODE_AUTH_TOKEN` is set: `echo $NODE_AUTH_TOKEN`
2. Ensure your token has the correct scopes
3. Check that the token hasn't expired

### Package Not Found

If packages can't be found after publishing:
1. Verify the package was published: https://github.com/cmaccarone?tab=packages
2. Ensure you have read access to the repository
3. Check that your `.npmrc` is configured correctly

### Permission Denied

If you get permission denied errors:
1. Ensure you're the owner of the repository
2. Verify your token has `write:packages` scope
3. Check that the package scope matches your GitHub username

## Quick Start

For a quick local publish, use the helper script:

```bash
./publish.sh
```

This script will:
1. Check that `NODE_AUTH_TOKEN` is set
2. Build all packages
3. Publish to GitHub Packages


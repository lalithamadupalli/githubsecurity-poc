# GitHub-native security POC

Controls: CodeQL (python + actions) with a failing gate, dependency review, Dependabot,
secret scanning + push protection, SHA-pinned actions, least-privilege tokens,
artifact attestations, and a ruleset on main. No third-party tools.

## Setup
1. Create a **public** repo (or a private one with GitHub Code Security / Secret Protection) and push these files.
2. Edit `.github/CODEOWNERS` with your username.
3. Run: `./scripts/setup-repo-security.sh OWNER/REPO`
4. Open a small PR so the check names register, then confirm they match `ruleset.json`.

## Demo
See `demo/README.md`.

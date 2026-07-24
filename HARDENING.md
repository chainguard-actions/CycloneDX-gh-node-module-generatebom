<!-- markdownlint-disable -->

# Hardening Report: CycloneDX--gh-node-module-generatebom/v1.0.3

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **CycloneDX--gh-node-module-generatebom/v1.0.3** was hardened automatically. 2 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

The workflow uses three external actions pinned to mutable version tags (@v3) rather than immutable full 40-character SHA commit digests. This exposes the workflow to supply-chain attacks if the tag is moved to a malicious commit. Failing references: `actions/checkout@v3` (line 33), `actions/setup-node@v3` (line 34), `actions/upload-artifact@v3` (line 43). Each should be replaced with the corresponding full SHA, e.g. `actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v3`.

Locations:

- `.github/workflows/test.yml:33`
- `.github/workflows/test.yml:34`
- `.github/workflows/test.yml:43`

### missing-permissions (severity: medium)

The workflow file has no top-level `permissions:` key and the `dogfooding` job also has no job-level `permissions:` key. Without explicit permissions, the workflow inherits the repository's default token permissions (which may be `write-all` for older repositories). A minimal `permissions:` block (e.g. `contents: read`) should be added at the top level or on every job.

Locations:

- `.github/workflows/test.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, missing-permissions

**Notes:**

Fixed hardened/action/.github/workflows/test.yml: (1) Pinned all three external action references to full SHA digests — actions/checkout@v3 → @a37ce9120846195fa4ece8f58b268e6043cb2f26, actions/setup-node@v3 → @3235b876344d2a9aa001b8d1453c930bba69e610, actions/upload-artifact@v3 → @ff15f0306b3f739f7b6fd43fb5d26cd321bd4de5 — with original tags preserved as comments. (2) Added a top-level `permissions: contents: read` block to restrict the GITHUB_TOKEN to the minimum required permissions.


# CLAUDE.local.md — our private operating layer (NOT for upstream)

This file + `.claude/` are OUR dev tooling. They live only on `tot-workspace` of `jarlbrak/rustycore` and must NEVER appear in an upstream PR. The project standard is upstream's `AGENTS.md` (imported by the committed `CLAUDE.md` stub); this file only adds OUR local workflow. It replaces the private `AGENTS.md` we carried before upstream claimed that filename (2026-08-02).

## Topology (post-3.4.3 rebrand)

- `origin` = jarlbrak/rustycore · `upstream` = alseif0x/rustycore · gh active account = jarlbrak.
- Upstream branch model: version branches, TrinityCore-style. Integration + default branch = **`3.4.3`**; all work is feature branches → PR into `3.4.3`. Upstream `main`/`develop` are **deleted** (backup: `backup/pre-3.4.3-rebrand`). `main` on our fork is an optional stable pointer only.
- Local: `tot-workspace` = default branch, carries this tooling, rebased onto upstream/3.4.3. Local `3.4.3` = clean mirror of upstream/3.4.3 = **PR base**. Local `develop` is a legacy pointer — do not base new work on it.
- Cut every slice branch off `3.4.3`. Tooling never on a slice/PR branch.
- Plan tracking = GitHub issues on alseif0x/rustycore ordered by the `[NN]` title prefix (pinned `[INDEX]` issue; GitHub #numbers are creation order — ignore them). One issue = one session = one branch = one PR.
- Status source of truth: `docs/migration/STATE.md` + `docs/migration/PORT_PLAN.md` (per AGENTS.md). The old `current-session-handoff.md` is frozen; old coverage headlines (96.97%) are not authoritative.

## Known local quirk: _attic case collision

`crates/wow-world/_attic/` tracks both `MIGRATE_character.sh` and `migrate_character.sh` (different blobs). On macOS's case-insensitive FS one disk file serves both paths, so git perpetually shows one as modified. This is an artifact, not real edits — never stage/commit it, and don't try to "fix" it by checking out (it flip-flops). Worth an upstream PR to drop one name eventually.

## C++ reference

`~/Documents/Projects/rustycore-ref/trinitycore-wotlk_classic` (TrinityCore wotlk_classic, HEAD 12c81a6f86cddbd47710b4e27aeff3f4eb7c4ced). The source of truth for all behavior/wire contrast. Upstream AGENTS.md paths like `/home/server/*` are the maintainer's machine, not ours — translate to local paths.

## Runtime / smoke

Run dir `~/Documents/Projects/rustycore-run`; bring-up + 6 compat shims in kb_6e1663e4. Use the `real-client-smoke` skill. World-auth is BYPASSED locally (insecure) — never ship.

## ninum

Knowledge hub = project `proj_93c59c00` (RustyCore). Runbook kb_6e1663e4, packet log kb_9727e534.
**CAVEAT:** `ninum-knowledge` (`.claude/settings.json`) is a **stdio MCP server** — a local subprocess on this Mac (`/Users/tbrack/Documents/Projects/Agents` venv + local SQLite). It works in **local** sessions only; a **cloud/remote** session CANNOT reach it. For cloud ninum, either deploy ninum as an HTTP MCP endpoint or export the needed kb entries into committed docs. Env var `ANNAS_ARCHIVE_API_KEY` must be exported for book-download tools (core kb tools work without it).

## Agents (.claude/agents) & skills (.claude/skills)

rust-systems-engineer, cpp-systems-engineer (reads the C++ reference), deploy-orchestrator (local build/run/smoke), knowledge-curator, rustycore-port-engineer, wow-protocol-fidelity · skills: port-a-slice, real-client-smoke, rustycore-pr. Note upstream now also ships repo-scoped skills under `.agents/skills/` (ARCH.1, #132) — those are the project's, ours live in `.claude/`.

## Validation suite (before any commit/PR)

`cargo fmt --all -- --check` · `cargo clippy -p <crate> --all-targets` · `PROTOC=/opt/homebrew/bin/protoc cargo test -p <crate> <name> --lib` · `git diff --check` · TSV 9-column check.

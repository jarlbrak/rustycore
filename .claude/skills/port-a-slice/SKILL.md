---
name: port-a-slice
description: Execute one rustycore porting slice end-to-end following rustycore's Mandatory Porting Method. Use when implementing/porting a documented gap from docs/migration into rustycore.
---

# Port a slice (rustycore)

Follow rustycore's `CLAUDE.md` Mandatory Porting Method exactly. Create a todo per step.

1. `git switch develop && git pull`; read `docs/migration/current-session-handoff.md`.
2. Pick ONE documented gap. State it + its `#NEXT` id.
3. Locate exact C++ anchors in `~/Documents/Projects/rustycore-ref/trinitycore-wotlk_classic` (cite file:line).
4. Read the current Rust; write how it differs from C++ BEFORE editing.
5. `git switch -c port/<slug> develop` (clean base; never branch off tot-workspace).
6. Smallest faithful slice. Prefer `*_like_cpp` helpers; mirror C++ names/order.
7. Add positive AND negative tests.
8. Update `docs/migration` docs + add the `#NEXT.*` item; keep inventory TSVs at 9 columns.
9. Validation (ALL): `cargo fmt --all -- --check` · `cargo clippy -p <crate> --all-targets` · `PROTOC=/opt/homebrew/bin/protoc cargo test -p <crate> <name> --lib` · `git diff --check` · TSV check.
10. Commit on the slice branch (short faithful summary). Do NOT include `.claude/` or `AGENTS.md`.
11. When ready to open the PR, use the `rustycore-pr` skill.

Never bulk-close inventory. Never mark manual-test-ready without a real-client run.

---
name: rustycore-pr
description: Open a clean upstream PR to alseif0x/rustycore from our fork, guaranteeing no private tooling leaks. Use when a slice is validated and ready to contribute.
---

# rustycore PR

GUARANTEE: tooling (`.claude/`, `AGENTS.md`, `memory/`) NEVER appears in a PR.

1. Confirm the slice branch was cut from clean `develop` (not `tot-workspace`):
   `git merge-base --is-ancestor origin/develop HEAD && echo OK`
2. Confirm NO tooling in the diff:
   `git diff --name-only upstream/develop...HEAD | grep -E '\.claude/|^AGENTS\.md$|^memory/' && echo "ABORT: tooling in diff" || echo CLEAN`
3. Re-run full validation (fmt/clippy/tests/diff-check/TSV).
4. Ensure migration docs + `#NEXT` updated for the slice.
5. `git push origin <slice>`.
6. `gh pr create -R alseif0x/rustycore --base develop --head jarlbrak:<slice> --title "..." --body "..."` — body cites C++ anchors, tests, links the tracking issue.
7. Record the PR in ninum `proj_93c59c00`.

If step 2 is not CLEAN, STOP and rebuild the branch off clean develop.

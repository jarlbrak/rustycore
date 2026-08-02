---
name: real-client-smoke
description: Bring up rustycore locally and drive a real 3.4.3.54261 client through login/world-entry, capturing wire-hex for protocol diffing. Use to validate live-runtime / manual-test readiness.
---

# Real-client smoke (rustycore)

Runtime dir: `~/Documents/Projects/rustycore-run` (configs, Data/, certs, compat shims, logs). DBs: MariaDB `auth/characters/world/hotfixes` (trinity/trinity@127.0.0.1). Full bring-up + the 6 compat shims (`rustycore-compat-shims.sql`) are in kb_6e1663e4.

1. Build: `cd ~/Documents/Projects/rustycore && PROTOC=/opt/homebrew/bin/protoc cargo build -p bnet-server -p world-server`.
2. Ensure MariaDB up + shims applied; account `test@test.com`/`test` exists.
3. Start servers from the run dir (`cd ~/Documents/Projects/rustycore-run`):
   - bnet: `<...>/target/debug/bnet-server > bnet.log 2>&1 &`
   - world: `RUST_LOG=world_server=info,wow_network=debug <...>/target/debug/world-server > world.log 2>&1 &`
   - confirm listeners 1119/8081/8085/8086; realm online.
4. Stop HermesProxy (`pkill -f HermesProxy`) to free 1119/8081; launch client `~/Games/launch-wow.sh`.
5. Log in (`test@test.com`/`test`) → realm Trinity → char → Enter World. Observe.
6. On crash: grep `world.log` for `wire_hex=`/EOF; hand the suspect packet to the `wow-protocol-fidelity` agent with the HermesProxy `~/Games/WoW-3.4.3-ToT/proxy/PacketsLog/` capture.
7. Restore the proxy path: `~/Games/WoW-3.4.3-ToT/proxy/run-hermes.sh`.

World-auth is currently BYPASSED (insecure, local-only). Never ship the bypass.

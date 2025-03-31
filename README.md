# CWRUNix Website

## TODO

- [x] Scaffold basic ui with mock data
- [ ] Set up a database
- [ ] Attach database to UI
- [ ] Make it deploy
- [ ] Add authentication
- [ ] Add image upload
- [ ] Error management (w/ Sentry)
- [ ] Routing/image page (parallel route)
- [ ] Delete button (w/ Server Actions)
- [ ] Ratelimiting (upstash)
- [ ] Devenv support
    - [x] Initial setup
    - [x] Pre-commit checks
    - [ ] Dependency management
    - [ ] Build/Test

## Dev Instructions
Dependencies:
```
pnpm podman netcat
```
Setup and start:
```
pnpm install
pnpm dev 
```
Setup database:
```
./start-database.sh
```
Check code format:
```
pnpm check
```

## Pre-commit checks
Fix code format:
```
pnpm check:write
```
Run typecheck:
```
pnpm tsc --noEmit
```

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
Setup environment (copy .env example and edit it):
```
cp .env.example .env
```
Install Node dependencies:
```
pnpm install
```
Start app:
```
pnpm dev
```
Setup database:
```
./start-database.sh
```

## Pre-commit checks
Check code format:
```
pnpm check
```
Fix code format:
```
pnpm check:write
```
Run typecheck:
```
pnpm tsc --noEmit
```

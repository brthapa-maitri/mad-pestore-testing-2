# MAD Petstore

A hands-on course for the MAD Framework. You make the decisions; a MAD agent team builds a small
pet-shop app, reviews it, tests it and releases it, and you run it on your own machine. No cloud
account is needed. It takes about 3 hours, and Claude guides you through every step.

**What you build:** a web app for the staff of Paws & Co, a pet shop. Staff can list pets by
status (available, pending, sold) and add a pet when one arrives. The app is built from the
[Swagger Petstore](https://petstore.swagger.io/): its pet API, cut down to what the shop needs,
is the contract the team builds to.

## 1. Create your copy

**[→ Create your copy of mad-petstore](https://github.com/new?template_owner=Maitri-Services&template_name=mad-petstore-template)**

Pick your own account as the owner, name the repo, keep it **Private**, and click
**Create repository**. Use the template; do not fork. If the link shows a 404, ask your
facilitator for access.

## 2. Install Docker

Install [Docker](https://docs.docker.com/get-docker/) and start it. Claude tells you about anything
else you need when a step needs it.

## 3. Clone and prepare

```bash
git clone <your repo URL> && cd <your repo>
git switch -c develop && git push -u origin develop
```

> **New to MAD? Try the MAD Sandbox first.**
> Click through a simulated run of this exact course in your browser: 15–20 min, nothing to install.
>
> **https://maitri-services.github.io/mad-petstore-reference/**

## 4. Start the course

```bash
claude "start"
```

Claude welcomes you, explains the course, and takes you through it one step at a time. It tells
you what to type, explains what was built after each step, and checks your work.

**Lost? Type `/course`.** At any time, even after closing and reopening `claude`, it shows which
steps you have done, where you are now, and the exact command to type next.

The steps you will go through:

1. **Set up MAD**: `/agent-team-setup`
2. **Architecture**: `/mad-plan` asks for your stack; choose **None (local only)** for where it runs
3. **Spec and plan**: `/mad-plan` asks you the questions only you can answer
4. **Beads**: the plan becomes a backlog
5. **Team run**: `/start` shows the work and suggests a team, `/spawn-team` spawns it, `go` starts it; agents build, a reviewer agent reviews every PR
6. **QA**: the QA agent tests the app; you decide which bugs are real
7. **Release**: you merge `develop` into `main`, and only you can
8. **Deploy** (optional, only if you chose a cloud): you deploy to your cloud account
9. **Teardown** (optional): you remove everything from your cloud

## 5. When you are done

Run the app on your machine. It is on `develop`, and on `main` after the release.

```bash
git checkout develop && git pull
docker compose --profile app up -d --build   # first build takes a few minutes
open http://localhost:3000                   # API at http://localhost:8000
docker compose --profile app down            # stop it
```

No Docker? Follow the README in `api/` and in `web/`: the team writes the native run steps for the
stack you chose.

---

### For facilitators

- **Checks:** `course/checks/S02.sh` … `S09.sh` grade a stage (exit 0 = pass); `course/checks/check-all.sh [S##]`
  runs them all, or up to a stage. The guide runs them for the learner.
- **Catch-up:** `course/skip.sh S04|S05|S06` fast-forwards a stuck stage from the private reference repo.
- **Dashboard:** `(cd course && npm run dashboard)` shows the beads board and PRs on http://localhost:4310.
- **The guide:** `CLAUDE.md` turns the lead session into the course guide; `/course` shows progress.
- **Repo map:** `docs/raw-intent.md` (MAD Stage 1, all the team gets), `contracts/` (API contract,
  original Swagger files, test ids), `prototype/` (static screens), `.claude/skills/mad-*` (project
  rules), `course/` (checks, catch-up, dashboard, seeded bug), `tests/` (contract and reference E2E
  tests), `e2e/` and `.mcp.json` (the QA agent's Playwright workspace), `compose.yaml` (local runtime).

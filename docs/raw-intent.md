<!-- docs/raw-intent.md -->
# Project: Paws & Co pet shop

## What are we building?
A small web app for shop staff: see the pets in the shop by status (available, pending or sold)
and add a new pet when it arrives (name, status, and optionally a category such as "Dogs").
We build it from the Swagger Petstore (https://petstore.swagger.io/): its pet API, cut down to
what this shop needs, is our contract (`contracts/petstore-pets.yaml`).

## Who is it for?
Paws & Co shop staff, on a desktop browser at the counter.

## What problem does it solve?
Staff track pets on paper and keep selling pets that are already reserved.

## What does success look like?
- Staff can see which pets are available before promising one to a customer.
- A new pet appears in the list as soon as it is added.
- The app runs on our own machine with one command.

## Known constraints
- Deploy target: none for now. Run the app locally (recommended); no cloud account is needed.
- Timeline: one working session (about 3 hours, team run included).
- Tech stack preferences: none; decide in planning from the stacks MAD supports.
- Local runtime: `compose.yaml` builds the API from `api/` (port 8000) and the web app from `web/`
  (port 3000), each with its own Dockerfile. Keep those folders and ports.
  `api/` and `web/` each also have a README with the commands to run them without Docker:
  install, start, environment variables and the database URL.
- Regulatory: none. No logins, no personal data.

## Rules the app must keep
- The API follows `contracts/petstore-pets.yaml` exactly (a cut-down Swagger Petstore). Never
  change the contract.
- Screens follow `prototype/index.html`; every element listed in `contracts/testids.md` carries
  exactly that `data-testid`. The prototype gives the layout and fields, not the look: the screens
  must look finished and pleasant for staff, with a clear header, styled inputs and buttons, a
  coloured badge per status, good spacing, and form errors next to the form.
- Pet ids are 64-bit and are sent as decimal strings; the id sequence starts above 2^53, so
  never turn an id into a JavaScript number.
- Form errors show in the `form-error` element; do not rely on the browser's built-in
  `required` check.
- One URL serves the app, and `GET /health` on it returns 200.

## Out of scope for now
Logins, orders, customers, photos.

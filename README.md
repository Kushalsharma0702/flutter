# EcoTrack (Flutter prototype)

Early Flutter prototype for an eco-tracking mobile app.

## Done so far

- Flutter project scaffold in `ecotrack_app/` for Android, iOS, web, Windows, Linux and macOS
- Entry point `lib/main.dart` with the HTTP package added for calling a backend API
- A small Node.js project at the repo root (`index.js`, `package.json`)

## Run

```bash
cd ecotrack_app
flutter pub get
flutter run
```

## Status

Starter-level prototype. `node_modules/` is committed at the repo root and should be removed from git.

## Future scope

- Screens for logging eco actions (transport, energy, waste) and a footprint score
- Backend API and user accounts
- Charts of weekly progress and goals
- Clean the repo (remove `node_modules`, add `.gitignore`) or merge into a single project
- My larger Flutter project: [tax_ease-clientapp](https://github.com/Kushalsharma0702/tax_ease-clientapp)

# Testing Guide

This project follows the 6-stage task pipeline defined in `sprints.md`.

## Local commands

### Static analysis

```bash
flutter analyze
```

### Unit + widget tests

```bash
flutter test
```

### Integration tests (Flutter `integration_test/`)

List devices:
```bash
flutter devices
```

Run on macOS desktop:
```bash
flutter test integration_test -d macos
```

Run on iOS simulator (example):
```bash
flutter test integration_test -d "iPhone 16e"
```

### Patrol (UI + E2E)

Install Patrol CLI (one-time):
```bash
dart pub global activate patrol_cli
```

Run Patrol tests (examples):
```bash
patrol test -d macos
patrol test -d "iPhone 16e"
```

> Note: Patrol execution requirements vary by target platform. If `patrol test` is unavailable,
ensure `patrol_cli` is activated and your PATH includes the pub global bin directory.


/// Compile-time secrets. No value is hardcoded here — supply it at build/run
/// time with `--dart-define=GOOGLE_CLOUD_API_KEY=your_key_here`
/// (or `--dart-define-from-file=<path>.json` for a local, gitignored file).
///
/// This file is safe to commit: it never contains a real key, only the
/// lookup. Kept as the established no-hardcoded-secrets pattern (see
/// `DECISIONS.md`/TASK-002) even though the one feature that consumed this
/// specific key (`getAddress` reverse-geocoding in
/// `location_controller.dart`) was removed as dead code - reuse this
/// pattern for any future feature that needs a real compile-time secret.
const String kGoogleCloudApiKey =
    String.fromEnvironment('GOOGLE_CLOUD_API_KEY');

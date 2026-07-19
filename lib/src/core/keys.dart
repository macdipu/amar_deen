/// Compile-time secrets. No value is hardcoded here — supply it at build/run
/// time with `--dart-define=GOOGLE_CLOUD_API_KEY=your_key_here`
/// (or `--dart-define-from-file=<path>.json` for a local, gitignored file).
///
/// This file is safe to commit: it never contains a real key, only the
/// lookup. Reverse-geocoding (getAddress in location_controller.dart)
/// simply fails gracefully with an empty key instead of the build breaking
/// on a missing file.
const String kGoogleCloudApiKey =
    String.fromEnvironment('GOOGLE_CLOUD_API_KEY');

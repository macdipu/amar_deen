/// On-device prayer time calculation method - each preset carries its own
/// twilight-angle/adjustment table for the underlying calculation engine.
enum PrayerCalculationMethod {
  muslimWorldLeague,
  northAmerica,
  egyptian,
  ummAlQura,
  karachi,
  tehran,
  jafari,
}

/// Asr calculation school - affects when the Asr window begins.
enum PrayerMadhab { shafi, hanafi }

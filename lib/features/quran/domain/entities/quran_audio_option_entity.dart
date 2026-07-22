/// A single Quran audio reciter/edition option (id, display names,
/// narration type, language, bitrate quality). Moved here verbatim from
/// `lib/src/features/quran/audio/quran_audio_catalog.dart` - zero logic
/// changes.
class QuranAudioOption {
  final String id;
  final String name;
  final String englishName;
  final String type;
  final String language;
  final int quality;

  const QuranAudioOption({
    required this.id,
    required this.name,
    required this.englishName,
    required this.type,
    required this.language,
    required this.quality,
  });
}

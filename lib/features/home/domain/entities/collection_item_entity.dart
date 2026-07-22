import 'package:equatable/equatable.dart';

/// A single navigation tile shown in the home screen's collection grid
/// (Quran, Prayer Times, Qibla, Azkar, Tasbih, Dua, Allah Names, Live TV,
/// Ramadan, Zakat, Voluntary Prayers, ...).
class CollectionItemEntity extends Equatable {
  final String assetName;
  final String title;
  final String routeName;

  const CollectionItemEntity(this.assetName, this.title, this.routeName);

  @override
  List<Object> get props => [assetName, title, routeName];
}

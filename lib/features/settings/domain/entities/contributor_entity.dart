/// A single credited contributor shown on the Thank You screen.
class ContributorEntity {
  final String name;
  const ContributorEntity(this.name);
}

/// Hardcoded credits list - no external source to abstract behind a
/// repository, same "nothing to abstract" precedent as Zakat.
class Contributors {
  static const List<ContributorEntity> contributors = [
    ContributorEntity('Muhammad Talha Sultan'),
    ContributorEntity('Cheam Jing En'),
    ContributorEntity('Noman Shoaib'),
    ContributorEntity('Flutter Developer'),
    ContributorEntity('Flutter Developer'),
    ContributorEntity('Graphic Designer'),
  ];

  static int get firstColumnCount {
    final int total = contributors.length;

    if (total % 2 == 0) {
      return (total / 2).round();
    } else {
      return (total / 2).round() + 1;
    }
  }

  static int get secondColumnCount => contributors.length - firstColumnCount;
}

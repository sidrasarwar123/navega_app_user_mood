class FavoriteCollectionStore {
  FavoriteCollectionStore._();

  static final List<String> names = ['Samra Yousuf'];

  static void add(String name) {
    final trimmedName = name.trim();
    if (trimmedName.isNotEmpty && !names.contains(trimmedName)) {
      names.add(trimmedName);
    }
  }
}

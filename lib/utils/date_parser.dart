DateTime? parseDate(dynamic value) {
  if (value == null) return null;

  final str = value.toString();
  if (str.isEmpty) return null;

  return DateTime.tryParse(str);
}

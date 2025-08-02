import 'package:flutter/material.dart';

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
    <K, List<E>>{},
    (Map<K, List<E>> map, E element) =>
        map..putIfAbsent(keyFunction(element), () => <E>[]).add(element),
  );
}

extension IterableExtension<T> on List<T> {
  Iterable<T> distinctBy(Object Function(T e) getCompareValue) {
    var idSet = <Object>{};
    var distinct = <T>[];
    for (var d in this) {
      if (idSet.add(getCompareValue(d))) {
        distinct.add(d);
      }
    }

    return distinct;
  }
}

extension ColorExtension on Color {
  Color containerColorShade1() {
    return withOpacity(0.6);
  }

  Color containerColorShade2() {
    return withOpacity(0.3);
  }
}

extension StatusCodeExtension on int? {
  bool isSuccessStatusCode() {
    return this == null ? false : (this! >= 200 && this! < 300);
  }
}

extension FileExtension on String {
  String get getFileName => split('/').last.split('.').first;
  String get getFileExtension => split('/').last.split('.').last;
  String get getFileNameWithExtension => split('/').last;
  String get getUniqueNameForFile => DateTime.now()
      .toIso8601String()
      .replaceAll('-', '')
      .replaceAll(':', '')
      .replaceAll('.', '');
  bool get isNetworkFile => contains('http');
  bool get isAssetFile => contains('asset');
}

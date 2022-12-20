

extension StringCasingExtension on String {

  String toClean() => this.replaceAll('"', '').trim();

  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':''; // Hello world

  String toUCFirst() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' '); // Hello World

}
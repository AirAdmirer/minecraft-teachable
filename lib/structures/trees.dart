import 'package:minecraft/resources/blocks.dart';
import 'package:minecraft/resources/structures.dart';

Structure birchTree = Structure(structure: [
  [null, Blocks.birchLeaf, Blocks.birchLeaf, Blocks.birchLeaf, null],
  [
    Blocks.birchLeaf,
    Blocks.birchLeaf,
    Blocks.birchLeaf,
    Blocks.birchLeaf,
    Blocks.birchLeaf
  ],
  [
    Blocks.birchLeaf,
    Blocks.birchLeaf,
    Blocks.birchLeaf,
    Blocks.birchLeaf,
    Blocks.birchLeaf
  ],
  [null, null, Blocks.birchLog, null, null],
  [null, null, Blocks.birchLog, null, null],
], maxOccurences: 1, maxWidth: 5);

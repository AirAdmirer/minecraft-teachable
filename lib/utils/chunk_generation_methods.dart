import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:fast_noise/fast_noise.dart';
import 'package:minecraft/global/global_game_reference.dart';
import 'package:minecraft/resources/biomes.dart';
import 'package:minecraft/resources/blocks.dart';
import 'package:minecraft/resources/ores.dart';
import 'package:minecraft/resources/structures.dart';
import 'package:minecraft/structures/trees.dart';
import 'package:minecraft/utils/constants.dart';
import 'package:minecraft/utils/game_methods.dart';

class ChunkGenerationMethods {
  static ChunkGenerationMethods get instance {
    return ChunkGenerationMethods();
  }

  List<List<Blocks?>> generateNullChunk() {
    return List.generate(
      chunkHeight,
      (index) => List.generate(chunkWidth, (index) => null),
    );
  }

  List<List<Blocks?>> generateChunk(int chunkIndex) {
    Biomes biome = Random().nextBool() ? Biomes.desert : Biomes.birchForest;

    List<List<Blocks?>> chunk = generateNullChunk();

    List<List<double>> rawNoise = noise2(
        chunkIndex >= 0
            ? chunkWidth * (chunkIndex + 1)
            : chunkWidth * (chunkIndex.abs()),
        1,
        noiseType: NoiseType.Perlin,
        frequency: 0.05,
        seed: chunkIndex >= 0
            ? GlobalGameReference.instance.gameReference.worldData.seed
            : GlobalGameReference.instance.gameReference.worldData.seed + 10);

    List<int> yValues = getYValuesFromRawNoise(rawNoise);

    yValues.removeRange(
        0,
        chunkIndex >= 0
            ? chunkWidth * chunkIndex
            : chunkWidth * (chunkIndex.abs() - 1));

    chunk = generatePrimarySoil(chunk, yValues, biome);

    chunk = generateSecondarySoil(chunk, yValues, biome);

    chunk = generateStone(chunk);

    chunk = addStructureToChunk(chunk, yValues, biome);

    chunk = addBedrock(chunk);

    chunk = addOreToChunk(chunk, Ores.coalOre);
    chunk = addOreToChunk(chunk, Ores.ironOre);
    chunk = addOreToChunk(chunk, Ores.diamondOre);
    chunk = addOreToChunk(chunk, Ores.goldOre);

    return chunk;
  }

  List<List<Blocks?>> addBedrock(List<List<Blocks?>> chunk) {
    chunk.last.replaceRange(
        0, chunkWidth, List.generate(chunkWidth, (index) => Blocks.bedrock));

    return chunk;
  }

  List<List<Blocks?>> generatePrimarySoil(
      List<List<Blocks?>> chunk, List<int> yValues, Biomes biome) {
    //primary soil function blah blah

    yValues.asMap().forEach((int index, int value) {
      chunk[value][index] = BiomeData.getBiomeDataFor(biome).primarySoil;
    });

    return chunk;
  }

  List<List<Blocks?>> generateSecondarySoil(
      List<List<Blocks?>> chunk, List<int> yValues, Biomes biome) {
    //primary soil function blah blah

    yValues.asMap().forEach((int index, int value) {
      for (int i = value + 1;
          i <= GameMethods.instance.maxSecondarySoilExtent;
          i++) {
        chunk[i][index] = BiomeData.getBiomeDataFor(biome).secondarySoil;
      }
    });

    return chunk;
  }

  List<List<Blocks?>> generateStone(List<List<Blocks?>> chunk) {
    for (int index = 0; index < chunkWidth; index++) {
      for (int i = GameMethods.instance.maxSecondarySoilExtent + 1;
          i < chunk.length;
          i++) {
        chunk[i][index] = Blocks.stone;
      }
    }

    int x1 = Random().nextInt(chunkWidth ~/ 2);
    int x2 = x1 + Random().nextInt(chunkWidth ~/ 2);

    chunk[GameMethods.instance.maxSecondarySoilExtent]
        .fillRange(x1, x2, Blocks.stone);

    return chunk;
  }

  List<List<Blocks?>> addStructureToChunk(
      List<List<Blocks?>> chunk, List<int> yValues, Biomes biome) {
    BiomeData.getBiomeDataFor(biome)
        .generatingStructures
        .asMap()
        .forEach((key, Structure currentStructure) {
      for (int occurence = 0;
          occurence < currentStructure.maxOccurences;
          occurence++) {
        List<List<Blocks?>> structureList =
            List.from(currentStructure.structure.reversed);

        int xPositionOfStructure =
            Random().nextInt(chunkWidth - currentStructure.maxWidth);

        int yPositionOfStructure =
            (yValues[xPositionOfStructure + (currentStructure.maxWidth ~/ 2)]) -
                1;

        for (int indexOfRow = 0;
            indexOfRow < currentStructure.structure.length;
            indexOfRow++) {
          List<Blocks?> rowOfBlocksInStrcuture = structureList[indexOfRow];

          rowOfBlocksInStrcuture
              .asMap()
              .forEach((int index, Blocks? blockInStructure) {
            if (chunk[yPositionOfStructure - indexOfRow]
                    [xPositionOfStructure + index] ==
                null) {
              chunk[yPositionOfStructure - indexOfRow]
                  [xPositionOfStructure + index] = blockInStructure;
            }
          });
        }
      }
    });

    return chunk;
  }

  List<int> getYValuesFromRawNoise(List<List<double>> rawNoise) {
    List<int> yValues = [];

    rawNoise.asMap().forEach((int index, List<double> value) {
      yValues
          .add((value[0] * 10).toInt().abs() + GameMethods.instance.freeArea);
    });

    return yValues;
  }

  List<List<Blocks?>> addOreToChunk(List<List<Blocks?>> chunk, Ores ore) {
    List<List<double>> rawNoise = noise2(chunkHeight, chunkWidth,
        noiseType: NoiseType.Perlin,
        frequency: 0.1,
        seed: Random().nextInt(11000000));

    List<List<int>> processedNoise =
        GameMethods.instance.processNoise(rawNoise);

    processedNoise
        .asMap()
        .forEach((int rowOfProcessedNoiseIndex, List<int> rowOfProcessedNoise) {
      rowOfProcessedNoise.asMap().forEach((int index, int value) {
        if (value < ore.rarity &&
            chunk[rowOfProcessedNoiseIndex][index] == Blocks.stone) {
          chunk[rowOfProcessedNoiseIndex][index] = ore.block;
        }
      });
    });

    return chunk;
  }
}

/*

chunk= [

[Air, air , ar],
[Blocks.grass, Blocks.dirt],
[],
[],
[],
[],
[],
[null, null, null, null, null],
[],
[],
[],
[],

]



*/

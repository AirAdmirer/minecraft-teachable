import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minecraft/global/global_game_reference.dart';
import 'package:minecraft/resources/blocks.dart';
import 'package:minecraft/resources/items.dart';
import 'package:minecraft/utils/constants.dart';

enum Direction {
  top,
  bottom,
  left,
  right,
}

enum SlotType { inventory, itemBar, crafting, craftingOutput }

class GameMethods {
  static GameMethods get instance {
    return GameMethods();
  }

  Vector2 get blockSize {
    return Vector2.all(getScreenSize().width / chunkWidth);
    return Vector2.all(30);
  }

  double get slotSize {
    return getScreenSize().height * 0.09;
  }

  int get freeArea {
    return (chunkHeight * 0.4).toInt();
  }

  int get maxSecondarySoilExtent {
    return freeArea + 6;
  }

  double get playerXIndexPosition {
    return GlobalGameReference
            .instance.gameReference.playerComponent.position.x /
        blockSize.x;
  }

  double get playerYIndexPosition {
    return GlobalGameReference
            .instance.gameReference.playerComponent.position.y /
        blockSize.x;
  }

  int get currentChunkPlayerIndex {
    return playerXIndexPosition >= 0
        ? playerXIndexPosition ~/ chunkWidth
        : (playerXIndexPosition ~/ chunkWidth) - 1;
  }

  double get gravity {
    return blockSize.x * 0.8;
  }

  int getChunkIndexFromPositionIndex(Vector2 positionIndex) {
    return positionIndex.x >= 0
        ? positionIndex.x ~/ chunkWidth
        : (positionIndex.x ~/ chunkWidth) - 1;
  }

  Vector2 getIndexPositionFromPixels(Vector2 clickPosition) {
    return Vector2((clickPosition.x / blockSize.x).floorToDouble(),
        (clickPosition.y / blockSize.x).floorToDouble());
  }

  Size getScreenSize() {
    return MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
  }

  SpriteSheet getBlockSpriteSheet() {
    return SpriteSheet(
        image: Flame.images
            .fromCache("sprite_sheets/blocks/block_sprite_sheet.png"),
        srcSize: Vector2.all(60));
  }

  SpriteSheet getItemSpriteSheet() {
    return SpriteSheet(
        image:
            Flame.images.fromCache("sprite_sheets/item/item_sprite_sheet.png"),
        srcSize: Vector2.all(60));
  }

  Sprite getSpriteFromBlock(Blocks block) {
    SpriteSheet spriteSheet = getBlockSpriteSheet();
    return spriteSheet.getSprite(0, block.index);
  }

  Sprite getSpriteFromItem(Items item) {
    SpriteSheet spriteSheet = getItemSpriteSheet();
    return spriteSheet.getSprite(0, item.index);
  }

  void addChunkToWorldChunks(
      List<List<Blocks?>> chunk, bool isInRightWorldChunks) {
    if (isInRightWorldChunks) {
      //chunk
      chunk.asMap().forEach((int yIndex, List<Blocks?> value) {
        //
        GlobalGameReference
            .instance.gameReference.worldData.rightWorldChunks[yIndex]
            .addAll(value);
      });
    } else {
      chunk.asMap().forEach((int yIndex, List<Blocks?> value) {
        //
        GlobalGameReference
            .instance.gameReference.worldData.leftWorldChunks[yIndex]
            .addAll(value);
      });
    }
  }

  List<List<Blocks?>> getChunk(int chunkIndex) {
    List<List<Blocks?>> chunk = [];

    if (chunkIndex >= 0) {
      GlobalGameReference.instance.gameReference.worldData.rightWorldChunks
          .asMap()
          .forEach((int index, List<Blocks?> rowOfBlocks) {
        chunk.add(rowOfBlocks.sublist(
            chunkWidth * chunkIndex, chunkWidth * (chunkIndex + 1)));
      });

      //leftWorldChunks
    } else {
      GlobalGameReference.instance.gameReference.worldData.leftWorldChunks
          .asMap()
          .forEach((int index, List<Blocks?> rowOfBlocks) {
        chunk.add(rowOfBlocks
            .sublist(chunkWidth * (chunkIndex.abs() - 1),
                chunkWidth * (chunkIndex.abs()))
            .reversed
            .toList());
      });
    }

    return chunk;
  }

  List<List<int>> processNoise(List<List<double>> rawNoise) {
    List<List<int>> processedNoise = List.generate(
      rawNoise.length,
      (index) => List.generate(rawNoise[0].length, (index) => 255),
    );
    for (var x = 0; x < rawNoise.length; x++) {
      for (var y = 0; y < rawNoise[0].length; y++) {
        int value = (0x80 + 0x80 * rawNoise[x][y]).floor(); // grayscale
        processedNoise[x][y] = value;
      }
    }

    return processedNoise;
  }

  void replaceBlockAtWorldChunks(Blocks? block, Vector2 blockIndex) {
    //Replace in the rightWorlChunks
    if (blockIndex.x >= 0) {
      GlobalGameReference.instance.gameReference.worldData
          .rightWorldChunks[blockIndex.y.toInt()][blockIndex.x.toInt()] = block;

      //left world chunks
    } else {
      //
      GlobalGameReference.instance.gameReference.worldData
              .leftWorldChunks[blockIndex.y.toInt()]
          [blockIndex.x.toInt().abs() - 1] = block;
    }
  }

  bool playerIsWithinRange(Vector2 positionIndex) {
    if ((positionIndex.x - playerXIndexPosition).abs() <= maxReach &&
        (positionIndex.y - playerYIndexPosition).abs() <= maxReach) {
      return true;
    }

    return false;
  }

  Blocks? getBlockAtIndexPosition(Vector2 blockIndex) {
    if (blockIndex.x >= 0) {
      return GlobalGameReference.instance.gameReference.worldData
          .rightWorldChunks[blockIndex.y.toInt()][blockIndex.x.toInt()];

      //left world chunks
    } else {
      //
      return GlobalGameReference.instance.gameReference.worldData
              .leftWorldChunks[blockIndex.y.toInt()]
          [blockIndex.x.toInt().abs() - 1];
    }
  }

  Blocks? getBlockAtDirection(Vector2 blockIndex, Direction direction) {
    switch (direction) {
      case Direction.top:
        try {
          return getBlockAtIndexPosition(
              Vector2(blockIndex.x, blockIndex.y - 1));
        } catch (e) {
          break;
        }

      case Direction.bottom:
        try {
          return getBlockAtIndexPosition(
              Vector2(blockIndex.x, blockIndex.y + 1));
        } catch (e) {
          break;
        }

      case Direction.left:
        try {
          return getBlockAtIndexPosition(
              Vector2(blockIndex.x - 1, blockIndex.y));
        } catch (e) {
          break;
        }

      case Direction.right:
        try {
          return getBlockAtIndexPosition(
              Vector2(blockIndex.x + 1, blockIndex.y));
        } catch (e) {
          break;
        }
    }

    return null;
  }

  bool adjacentBlocksExist(Vector2 blockIndex) {
    if (getBlockAtDirection(blockIndex, Direction.top) is Blocks) {
      return true;
    } else if (getBlockAtDirection(blockIndex, Direction.bottom) is Blocks) {
      return true;
    } else if (getBlockAtDirection(blockIndex, Direction.left) is Blocks) {
      return true;
    } else if (getBlockAtDirection(blockIndex, Direction.right) is Blocks) {
      return true;
    }

    return false;
  }

  Vector2 getSpawnPositionForMob() {
    int chunkIndex = Random().nextBool()
        ? GlobalGameReference
            .instance.gameReference.worldData.currentlyRenderedChunks.first
        : GlobalGameReference
            .instance.gameReference.worldData.currentlyRenderedChunks.last;

    List<List<Blocks?>> chunk = getChunk(chunkIndex);

    int spawnXPosition = Random().nextInt(chunkWidth);

    int spawnYPosition = 0;

    for (int rowOfBlocksIndex = 0;
        rowOfBlocksIndex < chunk.length;
        rowOfBlocksIndex++) {
      if (chunk[rowOfBlocksIndex][spawnXPosition] is Blocks &&
          BlockData.getBlockDataFor(chunk[rowOfBlocksIndex][spawnXPosition]!)
              .isCollidable) {
        spawnYPosition = rowOfBlocksIndex;
        break;
      }
    }

    //4
    return Vector2((spawnXPosition.toDouble()) + (chunkIndex * chunkWidth),
        spawnYPosition.toDouble());
  }

  Vector2 getSpawnPositionForPlayer() {
    int chunkIndex = 0;

    List<List<Blocks?>> chunk = getChunk(chunkIndex);

    int spawnXPosition = 0;

    int spawnYPosition = 0;

    for (int rowOfBlocksIndex = 0;
        rowOfBlocksIndex < chunk.length;
        rowOfBlocksIndex++) {
      if (chunk[rowOfBlocksIndex][spawnXPosition] is Blocks &&
          BlockData.getBlockDataFor(chunk[rowOfBlocksIndex][spawnXPosition]!)
              .isCollidable) {
        spawnYPosition = rowOfBlocksIndex;
        break;
      }
    }

    //4
    return Vector2((spawnXPosition.toDouble()) + (chunkIndex * chunkWidth),
        spawnYPosition.toDouble());
  }

  int getRandomSeed() {
    int seed = 100000 + Random().nextInt(100000);
    return seed;
  }

  TextStyle get minecraftTextStyle {
    return const TextStyle(
      color: Colors.white,
      fontFamily: "MinecraftFont",
      fontSize: 20,
      shadows: [
        BoxShadow(
          color: Colors.black,
          offset: Offset(1, 1),
        ),
      ],
    );
  }
}

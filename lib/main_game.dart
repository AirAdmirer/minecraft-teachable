import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:minecraft/components/block_breaking_component.dart';
import 'package:minecraft/components/block_component.dart';
import 'package:minecraft/components/item_component.dart';
import 'package:minecraft/components/player_component.dart';
import 'package:minecraft/components/sky_component.dart';
import 'package:minecraft/global/global_game_reference.dart';
import 'package:minecraft/global/player_data.dart';
import 'package:minecraft/global/world_data.dart';
import 'package:minecraft/mobs/spider.dart';
import 'package:minecraft/mobs/zombie.dart';
import 'package:minecraft/resources/blocks.dart';
import 'package:minecraft/resources/foods.dart';
import 'package:minecraft/resources/items.dart';
import 'package:minecraft/resources/sky_timer.dart';
import 'package:minecraft/utils/chunk_generation_methods.dart';
import 'package:minecraft/utils/constants.dart';
import 'package:minecraft/utils/game_methods.dart';

class MainGame extends FlameGame
    with HasCollisionDetection, HasTappables, HasKeyboardHandlerComponents {
  final WorldData worldData;

  MainGame({required this.worldData}) {
    globalGameReference.gameReference = this;
  }

  GlobalGameReference globalGameReference = Get.put(GlobalGameReference());

  PlayerComponent playerComponent = PlayerComponent();

  SkyComponent skyComponent = SkyComponent();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    add(playerComponent);

    add(skyComponent);
  }

  void renderChunk(int chunkIndex) {
    List<List<Blocks?>> chunk = GameMethods.instance.getChunk(chunkIndex);

    chunk.asMap().forEach((int yIndex, List<Blocks?> rowOfBlocks) {
      rowOfBlocks.asMap().forEach((int xIndex, Blocks? block) {
        if (block != null) {
          add(BlockData.getParentForBlock(
              block,
              Vector2((chunkIndex * chunkWidth) + xIndex.toDouble(),
                  yIndex.toDouble()),
              chunkIndex));
        }
      });
    });
  }

  @override
  void update(double dt) {
    //10ps
    //0.1

    super.update(dt);

    worldData.skyTimer.updateTimer(dt);

    itemRenderingLogic();

    if (worldData.skyTimer.skyTime == SkyTimerEnum.night) {
      worldData.mobs.spawnHostileMobs();
    }

    worldData.chunksThatShouldBeRendered
        .asMap()
        .forEach((int index, int chunkIndex) {
      //chunks isnt rendered
      if (!worldData.currentlyRenderedChunks.contains(chunkIndex)) {
        //for rightWorldChunks
        if (chunkIndex >= 0) {
          //Chunk has not been created
          if (worldData.rightWorldChunks[0].length ~/ chunkWidth <
              chunkIndex + 1) {
            GameMethods.instance.addChunkToWorldChunks(
                ChunkGenerationMethods.instance.generateChunk(chunkIndex),
                true);
          }

          renderChunk(chunkIndex);

          worldData.currentlyRenderedChunks.add(chunkIndex);

          //logic for leftWorldChunks
        } else {
          //0th chunk in leftWolrdChunk, chunkIndex 1
          if (worldData.leftWorldChunks[0].length ~/ chunkWidth <
              chunkIndex.abs()) {
            GameMethods.instance.addChunkToWorldChunks(
                ChunkGenerationMethods.instance.generateChunk(chunkIndex),
                false);
          }

          renderChunk(chunkIndex);

          worldData.currentlyRenderedChunks.add(chunkIndex);
        }
      }
    });
  }

  void itemRenderingLogic() {
    //logic
    worldData.items.asMap().forEach((int index, ItemComponent item) {
      if (!item.isMounted) {
        if (worldData.chunksThatShouldBeRendered.contains(GameMethods.instance
            .getChunkIndexFromPositionIndex(item.spawnBlockIndex))) {
          add(item);
        }
      } else {
        if (!worldData.chunksThatShouldBeRendered.contains(GameMethods.instance
            .getChunkIndexFromPositionIndex(item.spawnBlockIndex))) {
          remove(item);
        }
      }
    });
  }

  @override
  void onTapDown(int pointerId, TapDownInfo info) {
    super.onTapDown(pointerId, info);

    Vector2 blockPlacingPosition = GameMethods.instance
        .getIndexPositionFromPixels(info.eventPosition.game);

    placeBlockLogic(blockPlacingPosition);

    eatingLogic();
  }

  void eatingLogic() {
    dynamic currentItem = worldData
        .inventoryManager
        .inventorySlots[
            worldData.inventoryManager.currentSelectedInventorySlot.value]
        .block;

    if (currentItem is Items &&
        ItemData.getItemDataForItem(currentItem).isEatable) {
      playerComponent.changeHungerBy(getFoodPointsForFood[currentItem] ?? 0);
      worldData
          .inventoryManager
          .inventorySlots[
              worldData.inventoryManager.currentSelectedInventorySlot.value]
          .decrementSlot();
    }
  }

  void placeBlockLogic(Vector2 blockPlacingPosition) {
    if (blockPlacingPosition.y > 0 &&
        blockPlacingPosition.y < chunkHeight &&
        GameMethods.instance.playerIsWithinRange(blockPlacingPosition) &&
        GameMethods.instance.getBlockAtIndexPosition(blockPlacingPosition) ==
            null &&
        GameMethods.instance.adjacentBlocksExist(blockPlacingPosition) &&
        worldData
                .inventoryManager
                .inventorySlots[worldData
                    .inventoryManager.currentSelectedInventorySlot.value]
                .block !=
            null &&
        GameMethods.instance.adjacentBlocksExist(blockPlacingPosition) &&
        worldData
            .inventoryManager
            .inventorySlots[
                worldData.inventoryManager.currentSelectedInventorySlot.value]
            .block is Blocks) {
      GameMethods.instance.replaceBlockAtWorldChunks(
          worldData
              .inventoryManager
              .inventorySlots[
                  worldData.inventoryManager.currentSelectedInventorySlot.value]
              .block,
          blockPlacingPosition);

      add(BlockData.getParentForBlock(
          worldData
              .inventoryManager
              .inventorySlots[
                  worldData.inventoryManager.currentSelectedInventorySlot.value]
              .block!,
          blockPlacingPosition,
          GameMethods.instance
              .getChunkIndexFromPositionIndex(blockPlacingPosition)));

      worldData
          .inventoryManager
          .inventorySlots[
              worldData.inventoryManager.currentSelectedInventorySlot.value]
          .decrementSlot();
    }
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    super.onKeyEvent(event, keysPressed);

    //Keys that makes the player go right
    if (keysPressed.contains(LogicalKeyboardKey.arrowRight) ||
        keysPressed.contains(LogicalKeyboardKey.keyD)) {
      worldData.playerData.componentMotionState =
          ComponentMotionState.walkingRight;
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft) ||
        keysPressed.contains(LogicalKeyboardKey.keyA)) {
      worldData.playerData.componentMotionState =
          ComponentMotionState.walkingLeft;
    }
    if (keysPressed.contains(LogicalKeyboardKey.space) ||
        keysPressed.contains(LogicalKeyboardKey.keyW) ||
        keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      worldData.playerData.componentMotionState = ComponentMotionState.jumping;
    }

    if (keysPressed.isEmpty) {
      worldData.playerData.componentMotionState = ComponentMotionState.idle;
    }

    return KeyEventResult.ignored;
  }
}

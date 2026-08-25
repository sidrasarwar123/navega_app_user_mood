import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navega_app/Feature/client_mood/models/favorite_collection.dart';
import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/routes/app_routes.dart';

Future<void> showFavoriteCollectionDialog() async {
  await Get.dialog<void>(
    const _FavoriteCollectionDialog(),
    barrierColor: Colors.black38,
  );
}

class _FavoriteCollectionDialog extends StatelessWidget {
  const _FavoriteCollectionDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 13, 10, 12),
            child: Row(
              children: [
                const Expanded(child: Text('Favorites lists', style: _dialogTitle)),
                InkWell(
                  onTap: Get.back,
                  child: const Icon(Icons.close, size: 16),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.divider),
          InkWell(
            onTap: () {
              Get.back();
              Get.toNamed(Routes.createFavoriteList);
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 13),
              child: Row(
                children: [
                  Icon(Icons.add, size: 16, color: AppColors.primaryBlue),
                  SizedBox(width: 8),
                  Text('Create a new favorites list', style: _createText,),
                ],
              ),
            ),
          ),
          const Divider(height: 1, color: AppColors.divider),
          for (final name in FavoriteCollectionStore.names)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 13, 12, 13),
              child: Text(name, style: _listText),
            ),
        ],
      ),
    );
  }
}

const _dialogTitle = TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.textDark);
const _createText = TextStyle(fontSize: 15, color: AppColors.primaryBlueDark);
const _listText = TextStyle(fontSize: 15, color: AppColors.textDark);

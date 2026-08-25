import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navega_app/Feature/client_mood/models/favorite_collection.dart';
import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/routes/app_routes.dart';
import 'package:navega_app/core/widgets/button/primary_button.dart';
import 'package:navega_app/core/widgets/fields/custom_textfield.dart';

class CreateFavoriteListScreen extends StatefulWidget {
  const CreateFavoriteListScreen({super.key});

  @override
  State<CreateFavoriteListScreen> createState() => _CreateFavoriteListScreenState();
}

class _CreateFavoriteListScreenState extends State<CreateFavoriteListScreen> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _createList() {
    FavoriteCollectionStore.add(_nameController.text);
    if (_nameController.text.trim().isNotEmpty) {
      Get.offNamed(Routes.favorites);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(21, 20, 21, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: Get.back,
                customBorder: const CircleBorder(),
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.fieldBorder),
                  ),
                  child: const Icon(Icons.arrow_back, size: 17),
                ),
              ),
              const SizedBox(height: 31),
              const Text('Create New', style: _titleStyle),
              const SizedBox(height: 11),
             CustomTextField(hintText: "name",
              controller: _nameController,
             ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: PrimaryButton(label:"Create",
                
                  onPressed: (){
                  Get.toNamed(Routes.favouriteList);
                  }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const _titleStyle = TextStyle(
  fontFamily: 'Outfit',
  fontSize: 12,
  fontWeight: FontWeight.w600,
  color: AppColors.textDark,
);

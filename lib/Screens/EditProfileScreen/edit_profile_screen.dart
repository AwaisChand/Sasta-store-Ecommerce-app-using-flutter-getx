import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:sasta_store/Controllers/ProfileController/profile_controller.dart';

import '../../Helper/validation.dart';
import '../../Utils/color.dart';
import '../../Widget/component.dart';
import '../../Widget/custom_cache_image.dart';
import '../../Widget/custom_loader.dart';
import '../../Widget/custom_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  final String image;
  final String name;
  final String phone;
  final String email;

  const EditProfileScreen(
      {super.key,
      required this.image,
      required this.name,
      required this.phone,
      required this.email});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  ProfileController profileController = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileController.phoneController.text = widget.phone;
      profileController.nameController.text = widget.name;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
          ),
          title: const Text('Edit Profile'),
        ),
        body: Obx(() {
          return LoadingOverlay(
              isLoading: profileController.isLoading.value,
              progressIndicator: CustomLoader(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(children: [
                        profileController.isFromPath.value == true
                            ? Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: width * 0.2),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Container(
                                      width: 150,
                                      height: 150.0,
                                      child: Image.file(
                                          profileController.profileImage!,
                                          fit: BoxFit.cover),
                                    )),
                              )
                            : Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: width * 0.2),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CustomCacheImage(
                                    url: widget.image,
                                    width: 150,
                                    height: 150.0,
                                    circular: false,
                                  ),
                                ),
                              ),
                        // Center(
                        //     child: CircleAvatar(
                        //   radius: 50,
                        //   backgroundImage:
                        //       CachedNetworkImageProvider(widget.image),
                        // )),
                        Container(
                            margin: const EdgeInsets.only(left: 190, top: 80),
                            child: IconButton(
                                onPressed: () {
                                  profileController.pickImage();
                                },
                                icon: Icon(
                                  Icons.photo_camera,
                                  color: AppColors.secondryColor,
                                  size: 30,
                                )))
                      ]),
                      SizedBox(height: height * .01),
                      SizedBox(height: height * .01),
                      Text('Name:'),
                      CustomTextField(
                        validation: VALIDATIONS.validateName,
                        isPass: false,
                        maxLines: 1,
                        controller: profileController.nameController,
                        hint: profileController.nameController.text,
                        isReadOnly: false,
                        passwordvisibility: false,
                      ),
                      // MyWidget.textField('Shoaib', nameController,
                      //     prefixIcon: Icons.account_circle),
                      SizedBox(height: height * .01),
                      Text('Email:'),

                      CustomTextField(
                        validation: VALIDATIONS.validatePassword,
                        isPass: false,
                        maxLines: 1,
                        hint: widget.email,
                        isReadOnly: true,
                        passwordvisibility: false,
                      ),
                      SizedBox(height: height * .01),
                      Text('Phone:'),
                      CustomTextField(
                        validation: VALIDATIONS.validatePassword,
                        isPass: false,
                        maxLines: 1,
                        controller: profileController.phoneController,
                        hint: profileController.phoneController.text,
                        isReadOnly: false,
                        passwordvisibility: false,
                      ),
                      // MyWidget.textField('+92300 99 88 77', phoneController,
                      //     prefixIcon: Icons.phone),
                      SizedBox(height: height * .03),
                      Center(
                          child: MyWidget.roundButton(
                        context,
                        'Save',
                        () {
                          profileController.updateProfileData(
                              context: context,
                              image: widget.image,
                              email: widget.email);
                        },
                        height: height * .05,
                        width: width,
                        containerColor: AppColors.secondryColor,
                      )),
                    ],
                  ),
                ),
              ));
        }));
  }
}

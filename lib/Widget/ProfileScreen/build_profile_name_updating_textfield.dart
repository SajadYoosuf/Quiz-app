import 'package:flutter/material.dart';
import 'package:quiz_app/ViewModel/profile_screen_provider.dart';

Row buildProfileNameUpdatingTextField(BuildContext context, double width,
    double height, ProfileScreenProvider profileProvider) {
  return Row(
    children: [
      SizedBox(
        height: height * 0.1,
        width: width,
        child: Stack(
          children: [
            Positioned(
              left: width * 0.25,
              top: height * 0.02,
              child: SizedBox(
                width: width * 0.5,
                height: height * 0.05,
                child: TextField(
                    controller: profileProvider.nameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        filled: true,
                        hintStyle: const TextStyle(color: Colors.white),
                        fillColor: Colors.black,
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(22)))),
              ),
            ),
            Positioned(
              left: width * 0.72,
              top: height * 0.01,
              child: IconButton(
                  onPressed: () {
                    profileProvider.updateUserName(
                        profileProvider.nameController.text, context);
                  },
                  icon: const Icon(
                    Icons.check,
                    size: 40,
                    color: Colors.white,
                  )),
            )
          ],
        ),
      ),
    ],
  );
}

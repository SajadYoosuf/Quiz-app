import 'package:quiz_app/ViewModel/profile_screen_provider.dart';
import 'package:quiz_app/Widget/ProfileScreen/build_profile_screen_body.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with RouteAware {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final provider = context.read<ProfileScreenProvider>();
        provider.fetchUserData(context);
        provider.calculateProfileStatistics();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(
        this, ModalRoute.of(context)! as PageRoute<dynamic>);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPushNext() {
    context.read<ProfileScreenProvider>().resetStatistics();
  }

  @override
  void didPopNext() {
    context.read<ProfileScreenProvider>().resetStatistics();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryScreenSizes.int(context);

    return Consumer<ProfileScreenProvider>(
        builder: (context, profileProvider, child) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.primaryAppColor,
          body: buildProfileScreenBody(MediaQueryScreenSizes.screenWidth,
              MediaQueryScreenSizes.screenheight, context, profileProvider));
    });
  }
}

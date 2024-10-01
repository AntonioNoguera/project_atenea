import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/app/providers/session_provider.dart';
import 'package:proyect_atenea/app/values/app_theme.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final SessionProvider sessionProvider = Provider.of<SessionProvider>(context, listen: false);

    return FutureBuilder(
      future: sessionProvider.loadSession(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: SvgPicture.asset(
                      'assets/svg/Bearny.svg',
                      height: 300.0,
                      width: 300.0,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const CircularProgressIndicator(),
                ],
              ),
            ),
          );
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!sessionProvider.hasSession()) {
              Navigator.pushReplacementNamed(context, '/home');
            } else {
              Navigator.pushReplacementNamed(context, '/auth/login');
            }
          });

          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: SvgPicture.asset(
                      'assets/svg/Bearny.svg',
                      height: 250.0,
                      width: 250.0,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const CircularProgressIndicator(color: AppColors.primaryColor),
                  const Spacer(),
                  Text(
                    "Versión: 24.09",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.builder(color: AppColors.primaryColor, size: FontSizes.body1, weight: FontWeights.semibold),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

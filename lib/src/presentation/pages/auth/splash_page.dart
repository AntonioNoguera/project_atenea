import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/domain/entities/academy_entity.dart';
import 'package:proyect_atenea/src/domain/entities/content_entity.dart';
import 'package:proyect_atenea/src/domain/entities/department_entity.dart';
import 'package:proyect_atenea/src/domain/entities/plan_content_entity.dart';
import 'package:proyect_atenea/src/domain/entities/session_entity.dart';
import 'package:proyect_atenea/src/domain/entities/shared/atomic_permission_entity.dart';
import 'package:proyect_atenea/src/domain/entities/subject_entity.dart';
import 'package:proyect_atenea/src/domain/entities/user_entity.dart';
import 'package:proyect_atenea/src/domain/entities/shared/enum_fixed_values.dart';
import 'package:proyect_atenea/src/domain/entities/shared/permission_entity.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/academy_provider.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/department_provider.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/session_provider.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/subject_provider.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/user_provider.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionProvider =
        Provider.of<SessionProvider>(context, listen: false);
    final departmentProvider =
        Provider.of<DepartmentProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final academyProvider =
        Provider.of<AcademyProvider>(context, listen: false);
    final subjectProvider =
        Provider.of<SubjectProvider>(context, listen: false);
        
    // Contenido de la pantalla de splash
    final splashContent = SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: AppColors.primaryColor,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    const SizedBox(width: 20.0),
                    Image.asset(
                      'assets/images/backgrounds/uanl.png',
                      width: 150.0,
                      height: 63.3,
                      fit: BoxFit.contain,
                    ),
                    const Spacer(),
                    Image.asset(
                      'assets/images/backgrounds/fime.png',
                      width: 150.0,
                      height: 64.8,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 20.0),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: SvgPicture.asset(
                    'assets/svg/Bearny.svg',
                    height: 200.0,
                    width: 200.0,
                    color: AppColors.ateneaWhite.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 20),
                const CircularProgressIndicator(color: AppColors.ateneaWhite),
                const Spacer(),
                Text(
                  'Versión: 24.09',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.builder(
                    color: AppColors.ateneaWhite,
                    size: FontSizes.body2,
                    weight: FontWeights.semibold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Bienvenido al Proyecto Atenea',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.builder(
                    color: AppColors.ateneaWhite,
                    size: FontSizes.body4,
                    weight: FontWeights.regular,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );

    return FutureBuilder(
      future: sessionProvider.loadSession(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return splashContent;
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(const Duration(seconds: 3), () {
              if (sessionProvider.hasSession()) {
                Navigator.pushReplacementNamed(context, '/home');
              } else {
                Navigator.pushReplacementNamed(context, '/auth/login');
              }
            });
          });

          return splashContent;
        }
      },
    );
  }


}
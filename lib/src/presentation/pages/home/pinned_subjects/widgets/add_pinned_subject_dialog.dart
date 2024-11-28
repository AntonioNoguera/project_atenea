import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proyect_atenea/src/domain/entities/session_entity.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proyect_atenea/src/domain/entities/session_entity.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_field.dart';

class AddPinnedSubjectDialog extends StatelessWidget { 

  const AddPinnedSubjectDialog({
    Key? key, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AteneaButtonV2(
      text: 'Añadir Nueva Materia',
      xpndText: true,
      svgIcon: SvgButtonStyle(
        svgPath: 'assets/svg/add.svg',
      ),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          builder: (BuildContext context) {
            return _EditProfileDialogContent( 
            );
          },
        );
      },
    );
  }
}

class _EditProfileDialogContent extends StatefulWidget { 

  const _EditProfileDialogContent({
    Key? key, 
  }) : super(key: key);

  @override
  State<_EditProfileDialogContent> createState() =>
      _EditProfileDialogContentState();
}

class _EditProfileDialogContentState extends State<_EditProfileDialogContent> {
  

  @override
  void initState() { 
  }

  @override
  void dispose() {
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double modalHeight = MediaQuery.of(context).size.height * 0.9;

    return SizedBox(
      height: modalHeight,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Editar Perfil',
                style: AppTextStyles.builder(
                  size: FontSizes.h3,
                  weight: FontWeights.semibold,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
             
          ],
        ),
      ),
    );
  }
}

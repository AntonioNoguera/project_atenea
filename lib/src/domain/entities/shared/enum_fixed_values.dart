import 'package:proyect_atenea/src/presentation/values/app_theme.dart';

enum AcademyDepartments {
  administracion,
  sistemas,
  manufactura,
}


enum SystemEntitiesTypes {
  department('departments'),
  academy('academies'),
  subject('subjects');

  const SystemEntitiesTypes(this.value);

  final String value;
}


enum PlanOption {
  none,
  plan401,
  plan4XX,
}

enum UserType {
  superAdmin,
  admin,
  regularUser,
}
 
enum PermitTypes { 
  edit,
  delete,
  manageContributors, 
}


// Virtual Enums (Not real enums but they are used as such)
enum AteneaRowStyles {
  backgroundStyle,
  fontStyle,
}

class AteneaRowStyleValues {
  static const Map<AteneaRowStyles, List<dynamic>> values = {
    AteneaRowStyles.backgroundStyle: [AppColors.primaryColor, AppColors.lightSecondaryColor],
    AteneaRowStyles.fontStyle: [AppColors.ateneaWhite, AppColors.primaryColor],
  };
}

const selectedState = 1;
const unselectedState = 0;
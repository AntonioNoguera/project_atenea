import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'package:proyect_atenea/src/domain/entities/session_entity.dart';
import 'package:proyect_atenea/src/domain/entities/subject_entity.dart';
import 'package:proyect_atenea/src/presentation/pages/home/pinned_subjects/widgets/pin_subject_item_row.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/session_provider.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/subject_provider.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_card.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proyect_atenea/src/presentation/pages/home/pinned_subjects/widgets/add_pinned_subject_dialog.dart';

class MySubjectsPage extends StatelessWidget {
  const MySubjectsPage({super.key});

  Future<List<SubjectEntity>> _fetchPinnedSubjects(
  BuildContext context,
  List<String> pinnedIds,
) async {
  // Obtenemos el SubjectProvider para usar `getSubject(...)`
  final subjectProvider = Provider.of<SubjectProvider>(context, listen: false);

  final List<SubjectEntity> results = [];
  for (final subjectId in pinnedIds) {
    final subject = await subjectProvider.getSubject(subjectId);
    if (subject != null) {
      results.add(subject);
    }
  }
  return results;
}


  @override
  Widget build(BuildContext context) {
    return AteneaScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0),
        child: Column(
          children: [
            Text(
              'Mis Materias',
              style: AppTextStyles.builder(
                color: AppColors.primaryColor,
                size: FontSizes.h2,
                weight: FontWeights.semibold,
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
              ),
              child: const AddPinnedSubjectDialog(),
            ),
            const SizedBox(height: 20.0),

            Expanded(
  child: Consumer<SessionProvider>(
    builder: (context, sessionProvider, _) {
      final session = sessionProvider.currentSession;

      // Si no hay sesión o la lista de pinnedSubjects está vacía, mostrar la vista "vacía".
      if (session == null || session.pinnedSubjects.isEmpty) {
        return _buildEmptyView(context);
      }

      // Usamos un FutureBuilder para cargar los SubjectEntity de pinnedSubjects
      return FutureBuilder<List<SubjectEntity>>(
        future: _fetchPinnedSubjects(context, session.pinnedSubjects),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Mientras esperamos la data, mostramos un indicador de carga
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Si hubo un error en la carga
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Si no hay datos o la lista de SubjectEntity vino vacía
            return _buildEmptyView(context);
          }

          // Tenemos nuestra lista de SubjectEntity
          final subjects = snapshot.data!;

          // Renderizamos esa lista
          return ListView.builder(
            itemCount: subjects.length,
            itemBuilder: (context, index) {
              final subject = subjects[index];
              return Padding ( 
                padding: const EdgeInsets.symmetric(horizontal:  16.0), 
                child : PinSubjectItemRow(
                  subject: subject,
                  shouldUnpin: true,
                ));
            },
          );
        },
      );
    },
  ),
)

          ],
        ),
      ),
    );
  }

  Widget _buildEmptyView(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
        child: AteneaCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/svg/crossed_folder.svg',
                height: 50,
                width: 50,
                color: AppColors.grayColor.withOpacity(0.9),
              ),
              const SizedBox(height: 10.0),
              Text(
                'No tienes materias destacadas',
                style: AppTextStyles.builder(
                  color: AppColors.ateneaBlack,
                  weight: FontWeights.semibold,
                  size: FontSizes.body1,
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                'No hay ninguna materia destacada en tu lista de materias. '
                'Añade una nueva materia, podrás encontrarlas por acá.',
                style: AppTextStyles.builder(
                  color: AppColors.textColor,
                  weight: FontWeights.regular,
                  size: FontSizes.body2,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

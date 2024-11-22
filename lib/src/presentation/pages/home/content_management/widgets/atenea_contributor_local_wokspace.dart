//Main idea, is to have the contributor workspace, where the user can see the list of the projects that he is contributing to, and the list of the projects that he has created.

//campos

//Lista de contribuidores

//EntityLevel
//EntityUUID

/*

_isLoading
  ? const Center(child: AteneaCircularProgress())
  : _contributors.isEmpty
      ? Center(
          child: Column(
            children: [
              const SizedBox(height: 10.0,),
              Text(
                'No hay contribuidores en este departamento.',
                style: AppTextStyles.builder(
                  size: FontSizes.body2,
                  weight: FontWeights.regular,
                  color: AppColors.grayColor,
                ),
              ),
              const SizedBox(height: 10.0,),
            ]
          )
        )
      : Flexible(
          child: SingleChildScrollView(
            child: Column(
              children: _contributors.map((user) {
                final permission =
                    user.userPermissions.department.isNotEmpty
                        ? user.userPermissions.department.first
                        : null;

                if (permission == null) {
                  return SizedBox.shrink();
                }
                return AcademyContributorRow(
                  key: ValueKey(user.id),
                  index: _contributors.indexOf(user),
                  contributorName: user.fullName,
                  permissionEntity: permission,
                  showDetail: () => showDialog(
                    context: context,
                    builder: (_) => ModifyContributorDialog(
                      entityUUID: widget.department.id,
                      permissionEntity: permission,
                      entityType: SystemEntitiesTypes.department,
                      userDisplayed: user,
                      onPermissionUpdated: (userEntity,
                              updatedPermission) =>
                          _modifyContributor(
                              userEntity, updatedPermission),
                      onPermissionRemoved: (userEntity) =>
                          _removeContributor(userEntity),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
                  */
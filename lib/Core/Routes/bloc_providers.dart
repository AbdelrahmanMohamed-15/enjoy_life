//configuring a BlocProvider for a specific type of Bloc, along with its corresponding screen.

class BlocProviders {
  // Instantiates ProfileBloc using its default constructor.
  // static MultiBlocProvider get provideBlocProfileWithProfileScreen =>
  //     MultiBlocProvider(
  //         providers: [
  //           BlocProvider<ProfileBloc>(
  //               create: (context) =>
  //                   DependencyInjectionHelper().sl<ProfileBloc>()),
  //           BlocProvider<ProfileOptionsBloc>(
  //               create: (context) =>
  //                   DependencyInjectionHelper().sl<ProfileOptionsBloc>()),
  //         ],
  //         child: const ProfileScreen(
  //           isNavBar: true,
  //         ));
  // BlocProvider<ProfileBloc>(
  //   create: (context) => DependencyInjectionHelper().sl<ProfileBloc>()
  //     ..add(GetProfileEvent()),
  //   child: const ProfileScreen(
  //     isNavBar: true,
  //   ),
  // );
}

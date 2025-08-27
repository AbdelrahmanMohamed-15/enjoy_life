import 'package:easy_life/Core/Enums/level_message_enums.dart';
import 'package:easy_life/Features/Home/Domain/Entity/slider_entity.dart';
import 'package:easy_life/Features/Home/Domain/Usecases/get_sliders_usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.getSlidersUsecases}) : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  late GetSlidersUsecases getSlidersUsecases;
  SliderEntity? slidersEntity;
  RequestState sliderRequestState = RequestState.initial;

  Future<void> getSliders() async {
    emit(HomeLoadingState());
    final result = await getSlidersUsecases.call();
    result.fold(
      (failure) {
        sliderRequestState = RequestState.error;
        emit(HomeErrorState(requestState: sliderRequestState));
      },
      (sliders) {
        slidersEntity = sliders;
        if (sliders.data!.isNotEmpty) {
          emit(HomeSuccessState(sliders: sliders));
        } else {
          sliderRequestState = RequestState.empty;
          emit(HomeErrorState(requestState: sliderRequestState));
        }
      },
    );
  }
}

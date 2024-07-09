import '../Utils/Allimports.dart';

@immutable
class homeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class homeInitailEvent extends homeEvent {
  String page_number;
  BuildContext context;
  homeInitailEvent(this.page_number, this.context);
}
class homeloadmoreEvent extends homeEvent {
  String page_number;
  BuildContext context;
  homeloadmoreEvent(this.page_number, this.context);
}

abstract class homeState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class homeStateInitialState extends homeState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class homeStateLoadingState extends homeState {

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class homeStateLoadedState extends homeState {
  var data;
  homeStateLoadedState(this.data);
}class homeStatemoreLoadedState extends homeState {
  var data;
  homeStatemoreLoadedState(this.data);
}

class homeerrorState extends homeState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
  String error;
  homeerrorState(this.error);
}

class homeBloc extends Bloc<homeEvent, homeState> {
  homeBloc() : super(homeStateInitialState()) {
    on<homeEvent>((event, emit) async {
          if(event is homeInitailEvent){
            emit(homeStateLoadingState());
            try {
          var state = await getUserList(event);
          emit(state);
        } catch (error) {
          emit(homeerrorState(error.toString()));
        }
      }   if(event is homeloadmoreEvent){

        try {
          var state = await getUserList(event);
          emit(state);
        } catch (error) {
          emit(homeerrorState(error.toString()));
        }
      }
    });
  }
}

Future<homeState> getUserList(homeEvent event) async {
  var state;
  var page_number;
  if (event is homeInitailEvent) {
    page_number = event.page_number;
  }if (event is homeloadmoreEvent) {
    page_number = event.page_number;
    AppAlertController().showProgressIndicator();

  }

  await APIManager().getuserList(
      page_number: page_number,
      successBlock: (data) {
        if (event is homeInitailEvent) {
          state = homeStateLoadedState(data);
        }if (event is homeloadmoreEvent) {
          state = homeStatemoreLoadedState(data);
        }
        if (event is homeInitailEvent) {
          AppAlertController().hideProgressIndicator(event!.context);
        }
      },
      failureBlock: (exception) {
        state = homeerrorState(exception.toString());
      });
  return state;
}



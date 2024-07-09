import '../Utils/Allimports.dart';

@immutable
class userEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class userInitailEvent extends userEvent {
  String userid;
  BuildContext context;
  userInitailEvent(this.userid, this.context);
}

class userloadmoreEvent extends userEvent {
  String page_number;
  BuildContext context;
  userloadmoreEvent(this.page_number, this.context);
}

abstract class userState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class userStateInitialState extends userState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class userStateLoadingState extends userState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class userStateLoadedState extends userState {
  var data;
  userStateLoadedState(this.data);
}

class usererrorState extends userState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
  String error;
  usererrorState(this.error);
}

class userBloc extends Bloc<userEvent, userState> {
  userBloc() : super(userStateInitialState()) {
    on<userEvent>((event, emit) async {
      if (event is userInitailEvent) {
        emit(userStateLoadingState());
        try {
          var state = await getUserdata(event);
          emit(state);
        } catch (error) {
          emit(usererrorState(error.toString()));
        }
      }
    });
  }
}

Future<userState> getUserdata(userEvent event) async {
  var state;
  var userid;
  if (event is userInitailEvent) {
    userid = event.userid;
  }
  await APIManager().getuserdata(
      userid: userid,
      successBlock: (data) {
        state = userStateLoadedState(data);
        if (event is userInitailEvent) {
          AppAlertController().hideProgressIndicator(event!.context);
        }
      },
      failureBlock: (exception) {
        state = usererrorState(exception.toString());
      });
  return state;
}

import '../Utils/Allimports.dart';

typedef SuccessCompletionBlock = void Function(dynamic);
typedef FailureCompletionBlock = void Function(Exception);

class APIManager {
  Future getuserList(
      {required SuccessCompletionBlock successBlock,
      required FailureCompletionBlock failureBlock,
      required String page_number,
      bool showIndicator = true}) async {
    dynamic response = await APIEngine().performRequest(
        APIRequestType.GET, '${AppUrlManager.userList(page_number)}',
        isWithToken: false, showIndicator: showIndicator);
    _handleResponseCallBack(response, successBlock, failureBlock);

    return response;
  }  Future getuserdata(
      {required SuccessCompletionBlock successBlock,
      required FailureCompletionBlock failureBlock,
      required String userid,
      bool showIndicator = true}) async {
    dynamic response = await APIEngine().performRequest(
        APIRequestType.GET, '${AppUrlManager.userData(userid)}',
        isWithToken: false, showIndicator: showIndicator);
    _handleResponseCallBack(response, successBlock, failureBlock);

    return response;
  }

  void _handleResponseCallBack(
      APIResponse response,
      SuccessCompletionBlock successBlock,
      FailureCompletionBlock failureBlock) {
    switch (response.status) {
      case APIResponseStatus.SUCCESS:
        successBlock(response.data);
        break;
      case APIResponseStatus.FAILED:
        failureBlock(response.exception!);
        break;
    }
  }
}

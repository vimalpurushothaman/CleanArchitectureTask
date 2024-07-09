class AppUrlManager{
static const baseUrl="https://reqres.in/";
static userList(page_number){
  return "${baseUrl}api/users?page=$page_number";
}static userData(userid){
  return "${baseUrl}api/users/${userid}";
}
}
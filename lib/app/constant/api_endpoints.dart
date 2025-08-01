class ApiEndpoints {
  ApiEndpoints._();
  // TimeOuts
  static const connectionTimeout = Duration(seconds: 1000);
  static const recieveTimeout = Duration(seconds: 1000);

  // For andoid emulator
  static const String serverAddress = "http://10.0.0.2:5000";
  // For IOS Emulator
  // static const String serverAddress = "http://localhost:5000";

  static const baseUrl = '$serverAddress/api/v1/';

  // AUTH API
  static const signup = 'auth/signup';
  static const login = 'auth/driver-login';

  // USER SPECIFIC API
  // TODO: this one needs to append user id to send the request. The actual endpoint is user/getProfile/:id
  static const getUserProfile = 'user/getProfile';
  static const updateProfile = 'user/updateProfile';
  static const updatePassword = 'user/changePassword';
  static const uploadAvatar = 'user/uploadAvatar';

  // JOB SPECIFIC API
  // TODO: this one also needs to append the user id to send the request. The actual endpoint is job/getJobForDriver/:driverId
  static const getJobs = 'job/getJobForDriver';
  // TODO: this one also needs to append the user id to send the request. The actual endpoint is job/getJobById/:jobId
  static const jobDeatils = "job/getJobById";

  // TODO: This one needs the job id as well. The actual endpoint is job/getAllCoord/:jobId;
  static const getAllCoordinates = "job/getAllCoord";
  // TODO: This one needs the job id as well. The actual endpoint is job/updateCoord/:jobId;
  static const updateCoordinates = "job/updateCoord";
}

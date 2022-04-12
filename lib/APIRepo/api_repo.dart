import 'package:dio/dio.dart';
import 'package:multi_video_list/Common/global.dart';
import 'package:multi_video_list/Model/getVideoModel.dart';

abstract class BaseRepository {
  Future<GetVideosModel> getVideoList();
}

class ApiRepository implements BaseRepository {
  Dio dio = Dio(dioBaseOptions);

  @override
  Future<GetVideosModel> getVideoList() async {
    try {
      Response response = await dio.get(
        getVideoURL,
      );
      return GetVideosModel.fromJson(response.data);
    } catch (error) {
      throw Exception(error);
    }
  }
}

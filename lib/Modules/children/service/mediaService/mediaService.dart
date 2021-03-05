import '../../model/media.dart';

abstract class MediaService{
  Future<int> saveMedia(Media media);
  Future<List> getAllMedia();
  Future<List> getItemMedias(int tableid,int itemId);
  Future<int> getMediaCount();
  Future<int> updateMedia(Media media);
  Future<int> deleteMedia(Media media);
  close();
}
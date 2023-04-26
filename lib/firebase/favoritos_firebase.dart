import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritosFirebase {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference? _favoritosCollection;

  FavoritosFirebase() {
    _favoritosCollection = _firestore.collection('favoritos');
  }

  Future<void> insFavorite(Map<String, dynamic> map) async {
    return _favoritosCollection!.doc().set(map);
  }

  Future<void> updFavorite(Map<String, dynamic> map, String id) async {
    return _favoritosCollection!.doc(id).update(map);
  }

  Future<void> delFavorite(Map<String, dynamic> map, String id) async {
    return _favoritosCollection!.doc(id).delete();
  }

  Stream<QuerySnapshot> getAllFavoritos() {
    return _favoritosCollection!.snapshots();
  }
}

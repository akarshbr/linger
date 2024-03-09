import 'package:flutter/material.dart';

import '../model/hotel_model.dart';


List<Hotel> hotelList = [
  Hotel(name: "Savoy", image: "assets/hotel/savoy1.jpg", price: 1200, rating: 4.1, place: "SN Park Rd, Kannur"),
  Hotel(name: "Broad Bean", image: "assets/hotel/broadbean.jpg", place: "New Bus stand, Kannur", price: 4042, rating: 4),
  Hotel(name: "Krishna Beach Resort", image: "assets/hotel/krishnabeachresort.jpg", place: "Payyambalam, Kannur", price: 3440, rating: 3),
  Hotel(name: "Mascot Beach Resort", image: "assets/hotel/mascot-beach-resort.jpg", place: "Burnassery, Kannur", price: 4995, rating: 3),
  Hotel(name: "Rainbow Suite", image: "assets/hotel/rainbow_suite.jpg", place: "Bellard Rd, Kannur", price: 2213, rating: 4),
  Hotel(name: "Royal Omars", image: "assets/hotel/royal-omars.jpg", place: "Thavakkara, Kannur", price: 1935, rating: 4),
  Hotel(name: "Sky Palace", image: "assets/hotel/skypalace.jpg", place: "Thavakkara Rd, Kannur", price: 1780, rating: 3),
  Hotel(name: "Surya Heritage", image: "assets/hotel/suryaheritage.jpg", place: "Sub Reg Office Rd, Kannur", price: 5812, rating: 4)
];

class HotelController extends ChangeNotifier {
  final List<Hotel> _hotel = hotelList;

  List<Hotel> get hotel => _hotel;

  final List<Hotel> _wishList = [];

  List<Hotel> get wishList => _wishList;
}

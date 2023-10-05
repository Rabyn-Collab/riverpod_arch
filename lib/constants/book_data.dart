


import 'package:flutterspod/models/book.dart';

const book_data = [
  {
    'title': 'Chariots of the Gods ',
    'detail': 'The main thesis of Chariots of the Gods is that extraterrestrial beings influenced ancient technology. Von Däniken suggests that some ancient structures and artifacts appear to reflect more sophisticated technological knowledge than is known or presumed to have existed at the times they were manufactured',
    'imageUrl': 'https://upload.wikimedia.org/wikipedia/en/2/29/Chariots_Of_The_Gods.jpg',
    'rating': '⭐⭐⭐⭐⭐',
    'genre': 'Sci-fiction'
  },
  {
    'title': 'Chariots of the Gods 1',
    'detail': 'The main thesis of Chariots of the Gods is that extraterrestrial beings influenced ancient technology. Von Däniken suggests that some ancient structures and artifacts appear to reflect more sophisticated technological knowledge than is known or presumed to have existed at the times they were manufactured',
    'imageUrl': 'https://upload.wikimedia.org/wikipedia/en/2/29/Chariots_Of_The_Gods.jpg',
    'rating': '⭐⭐⭐⭐⭐',
    'genre': 'Sci-fiction'
  },
  {
    'title': 'Chariots of the Gods 2',
    'detail': 'The main thesis of Chariots of the Gods is that extraterrestrial beings influenced ancient technology. Von Däniken suggests that some ancient structures and artifacts appear to reflect more sophisticated technological knowledge than is known or presumed to have existed at the times they were manufactured',
    'imageUrl': 'https://upload.wikimedia.org/wikipedia/en/2/29/Chariots_Of_The_Gods.jpg',
    'rating': '⭐⭐⭐⭐⭐',
    'genre': 'Sci-fiction'
  }
];


List<Book> books = book_data.map((e) => Book.fromJson(e)).toList();
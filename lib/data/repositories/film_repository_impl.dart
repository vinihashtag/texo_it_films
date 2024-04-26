import 'package:flutter/foundation.dart';
import 'package:texo_it_films/core/services/rest_client/rest_client_service.dart';
import 'package:texo_it_films/core/utils/custom_logger.dart';
import 'package:texo_it_films/data/models/min_max_producers_model.dart';
import 'package:texo_it_films/data/models/response_model.dart';
import 'package:texo_it_films/data/models/top_studios_model.dart';
import 'package:texo_it_films/data/models/winner_by_year_model.dart';
import 'package:texo_it_films/data/repositories/film_repository_interface.dart';

import '../../core/utils/erros.dart';
import '../models/film_pagination_model.dart';
import '../models/multiple_winners_model.dart';

class FilmRepositoryImpl implements IFilmRepository {
  final IRestClientService _restClientService;

  FilmRepositoryImpl(this._restClientService);

  @override
  Future<ResponseModel<MultipleWinnersModel, CustomException>> getMultipleWinners() async {
    try {
      if (kDebugMode) {
        return ResponseModel(
            data: MultipleWinnersModel.fromMap({
          "years": [
            {"year": 1986, "winnerCount": 2},
            {"year": 1990, "winnerCount": 2},
            {"year": 2015, "winnerCount": 2}
          ]
        }));
      }

      final response = await _restClientService.request(
        path: '',
        queryParameters: {'projection': 'years-with-multiple-winners'},
      );

      if (response.isError) return ResponseModel(error: response.error);

      return ResponseModel(data: MultipleWinnersModel.fromMap(response.data));
    } catch (e, s) {
      LoggerApp.error('Error on get multiple winners', e, s);
      return ResponseModel(
        error: CustomException(
          message: 'Error on get multiple winners',
          exception: e,
          stackTrace: s,
        ),
      );
    }
  }

  @override
  Future<ResponseModel<TopStudiosModel, CustomException>> getTopStudios() async {
    try {
      if (kDebugMode) {
        return ResponseModel(
            data: TopStudiosModel.fromMap({
          "studios": [
            {"name": "Columbia Pictures", "winCount": 7},
            {"name": "Paramount Pictures", "winCount": 6},
            {"name": "Warner Bros.", "winCount": 5},
            {"name": "20th Century Fox", "winCount": 4},
            {"name": "MGM", "winCount": 3},
            {"name": "Universal Studios", "winCount": 2},
            {"name": "Universal Pictures", "winCount": 2},
            {"name": "Hollywood Pictures", "winCount": 2},
            {"name": "Nickelodeon Movies", "winCount": 1},
            {"name": "C2 Pictures", "winCount": 1},
            {"name": "Summit Entertainment", "winCount": 1},
            {"name": "Hasbro", "winCount": 1},
            {"name": "Associated Film Distribution", "winCount": 1},
            {"name": "Revolution Studios", "winCount": 1},
            {"name": "First Look Pictures", "winCount": 1},
            {"name": "Focus Features", "winCount": 1},
            {"name": "Cannon Films", "winCount": 1},
            {"name": "United Artists", "winCount": 1},
            {"name": "Touchstone Pictures", "winCount": 1},
            {"name": "Samuel Goldwyn Films", "winCount": 1},
            {"name": "Quality Flix", "winCount": 1},
            {"name": "TriStar Pictures", "winCount": 1},
            {"name": "Franchise Pictures", "winCount": 1},
            {"name": "Relativity Media", "winCount": 1},
            {"name": "Castle Rock Entertainment", "winCount": 1},
            {"name": "Screen Gems", "winCount": 1},
            {"name": "Triumph Releasing", "winCount": 1},
            {"name": "DreamWorks", "winCount": 1}
          ]
        }));
      }
      final response = await _restClientService.request(
        path: '',
        queryParameters: {'projection': 'studios-with-win-count'},
      );

      if (response.isError) return ResponseModel(error: response.error);

      return ResponseModel(data: TopStudiosModel.fromMap(response.data));
    } catch (e, s) {
      LoggerApp.error('Error on get top studios', e, s);
      return ResponseModel(
        error: CustomException(
          message: 'Error on get top studios',
          exception: e,
          stackTrace: s,
        ),
      );
    }
  }

  @override
  Future<ResponseModel<MinMaxProducersModel, CustomException>> getMinMaxProducers() async {
    try {
      if (kDebugMode) {
        return ResponseModel(
            data: MinMaxProducersModel.fromMap({
          "min": [
            {"producer": "Joel Silver", "interval": 1, "previousWin": 1990, "followingWin": 1991}
          ],
          "max": [
            {"producer": "Matthew Vaughn", "interval": 13, "previousWin": 2002, "followingWin": 2015}
          ]
        }));
      }
      final response = await _restClientService.request(
        path: '',
        queryParameters: {'projection': 'max-min-win-interval-for-producers'},
      );

      if (response.isError) return ResponseModel(error: response.error);

      return ResponseModel(data: MinMaxProducersModel.fromMap(response.data));
    } catch (e, s) {
      LoggerApp.error('Error on get min max producers', e, s);
      return ResponseModel(
        error: CustomException(
          message: 'Error on get min max producers',
          exception: e,
          stackTrace: s,
        ),
      );
    }
  }

  @override
  Future<ResponseModel<List<WinnerByYearModel>, CustomException>> getWinnersByYear(int year) async {
    try {
      if (kDebugMode) {
        return ResponseModel(data: [
          WinnerByYearModel.fromMap({
            "id": 197,
            "year": 2018,
            "title": "Holmes & Watson",
            "studios": ["Columbia Pictures"],
            "producers": ["Adam McKay", "Clayton Townsend", "Jimmy Miller", "Will Ferrell"],
            "winner": true
          })
        ]);
      }
      final response = await _restClientService.request(
        path: '',
        queryParameters: {'winner': true, 'year': year},
      );

      if (response.isError) return ResponseModel(error: response.error);

      return ResponseModel(data: (response.data as List).map((e) => WinnerByYearModel.fromMap(e)).toList());
    } catch (e, s) {
      LoggerApp.error('Error on get winners by year', e, s);
      return ResponseModel(
        error: CustomException(
          message: 'Error on get winners by year',
          exception: e,
          stackTrace: s,
        ),
      );
    }
  }

  @override
  Future<ResponseModel<FilmPaginationModel, CustomException>> getFilmsByFilter(
      {required int page, int? year, bool? winner, int size = 15}) async {
    try {
      if (!kDebugMode) {
        return ResponseModel(
            data: FilmPaginationModel.fromMap({
          "content": [
            {
              "id": 100,
              "year": 1998,
              "title": "Spice World",
              "studios": ["Columbia Pictures"],
              "producers": ["Barnaby Thompson", "Mark L. Rosen", "Uri Fruchtan"],
              "winner": false
            },
            {
              "id": 101,
              "year": 1999,
              "title": "Wild Wild West",
              "studios": ["Warner Bros."],
              "producers": ["Barry Sonnenfeld", "Jon Peters"],
              "winner": true
            },
            {
              "id": 102,
              "year": 1999,
              "title": "Big Daddy",
              "studios": ["Columbia Pictures"],
              "producers": ["Jack Giarraputo", "Sidney Ganis"],
              "winner": false
            },
            {
              "id": 103,
              "year": 1999,
              "title": "The Blair Witch Project",
              "studios": ["Artisan Entertainment"],
              "producers": ["Gregg Hale", "Robin Cowie"],
              "winner": false
            },
            {
              "id": 104,
              "year": 1999,
              "title": "The Haunting",
              "studios": ["DreamWorks"],
              "producers": ["Colin Wilson", "Donna Roth", "Susan Arthur"],
              "winner": false
            },
            {
              "id": 105,
              "year": 1999,
              "title": "Star Wars: Episode I – The Phantom Menace",
              "studios": ["20th Century Fox"],
              "producers": ["George Lucas", "Rick McCallum"],
              "winner": false
            },
            {
              "id": 106,
              "year": 2000,
              "title": "Battlefield Earth",
              "studios": ["Franchise Pictures", "Warner Bros."],
              "producers": ["Elie Samaha", "John Travolta", "Jonathan D. Krane"],
              "winner": true
            },
            {
              "id": 107,
              "year": 2000,
              "title": "Book of Shadows: Blair Witch 2",
              "studios": ["Artisan Entertainment"],
              "producers": ["Bill Carraro"],
              "winner": false
            },
            {
              "id": 108,
              "year": 2000,
              "title": "The Flintstones in Viva Rock Vegas",
              "studios": ["Universal Studios"],
              "producers": ["Bruce Cohen"],
              "winner": false
            },
            {
              "id": 109,
              "year": 2000,
              "title": "Little Nicky",
              "studios": ["New Line Cinema"],
              "producers": ["Jack Giarraputo", "Robert Simonds"],
              "winner": false
            },
            {
              "id": 110,
              "year": 2000,
              "title": "The Next Best Thing",
              "studios": ["Paramount Pictures"],
              "producers": ["Leslie Dixon", "Linne Radmin", "Tom Rosenberg"],
              "winner": false
            },
            {
              "id": 111,
              "year": 2001,
              "title": "Freddy Got Fingered",
              "studios": ["20th Century Fox"],
              "producers": ["Howard Lapides", "Larry Brezner", "Lauren Lloyd"],
              "winner": true
            },
            {
              "id": 112,
              "year": 2001,
              "title": "Driven",
              "studios": ["Franchise Pictures", "Warner Bros."],
              "producers": ["Elie Samaha", "Renny Harlin", "Sylvester Stallone"],
              "winner": false
            },
            {
              "id": 113,
              "year": 2001,
              "title": "Glitter",
              "studios": ["20th Century Fox", "Columbia Pictures"],
              "producers": ["E. Bennett Walsh", "Laurence Mark"],
              "winner": false
            },
            {
              "id": 114,
              "year": 2001,
              "title": "Pearl Harbor",
              "studios": ["Touchstone Pictures"],
              "producers": ["Jerry Bruckheimer", "Michael Bay"],
              "winner": false
            },
            {
              "id": 115,
              "year": 2001,
              "title": "3000 Miles to Graceland",
              "studios": ["Franchise Pictures", "Warner Bros."],
              "producers": ["Andrew Stevens", "Demian Lichtenstein", "Elie Samaha", "Eric Manes", "Richard Spero"],
              "winner": false
            },
            {
              "id": 116,
              "year": 2002,
              "title": "Swept Away",
              "studios": ["Screen Gems"],
              "producers": ["Matthew Vaughn"],
              "winner": true
            },
            {
              "id": 117,
              "year": 2002,
              "title": "The Adventures of Pluto Nash",
              "studios": ["Warner Bros."],
              "producers": ["Louis A. Stroller", "Martin Bregman", "Michael Scott Bregman"],
              "winner": false
            },
            {
              "id": 118,
              "year": 2002,
              "title": "Crossroads",
              "studios": ["Paramount Pictures"],
              "producers": ["Ann Carli"],
              "winner": false
            },
            {
              "id": 119,
              "year": 2002,
              "title": "Pinocchio",
              "studios": ["Miramax Films"],
              "producers": ["Elda Ferri", "Gianluigi Braschi", "Nicoletta Braschi"],
              "winner": false
            },
            {
              "id": 120,
              "year": 2002,
              "title": "Star Wars: Episode II – Attack of the Clones",
              "studios": ["20th Century Fox"],
              "producers": ["George Lucas", "Rick McCallum"],
              "winner": false
            },
            {
              "id": 121,
              "year": 2003,
              "title": "Gigli",
              "studios": ["Columbia Pictures", "Revolution Studios"],
              "producers": ["Casey Silver", "Martin Brest"],
              "winner": true
            },
            {
              "id": 122,
              "year": 2003,
              "title": "The Cat in the Hat",
              "studios": ["DreamWorks", "Universal Studios"],
              "producers": ["Brian Grazer"],
              "winner": false
            },
            {
              "id": 123,
              "year": 2003,
              "title": "Charlie's Angels: Full Throttle",
              "studios": ["Columbia Pictures"],
              "producers": ["Drew Barrymore", "Leonard Goldberg", "Nancy Juvonen"],
              "winner": false
            },
            {
              "id": 124,
              "year": 2003,
              "title": "From Justin to Kelly",
              "studios": ["20th Century Fox"],
              "producers": ["John Steven Agoglia"],
              "winner": false
            },
            {
              "id": 125,
              "year": 2003,
              "title": "The Real Cancun",
              "studios": ["New Line Cinema"],
              "producers": ["Jamie Schutz", "Jonathan Murray", "Mary-Ellis Bunim", "Rick de Oliveira"],
              "winner": false
            },
            {
              "id": 126,
              "year": 2004,
              "title": "Catwoman",
              "studios": ["Warner Bros."],
              "producers": ["Denise Di Novi", "Edward McDonnell"],
              "winner": true
            },
            {
              "id": 127,
              "year": 2004,
              "title": "Alexander",
              "studios": ["Warner Bros."],
              "producers": ["Iain Smith", "Jon Kilik", "Moritz Borman", "Thomas Schuhly"],
              "winner": false
            },
            {
              "id": 128,
              "year": 2004,
              "title": "Superbabies: Baby Geniuses 2",
              "studios": ["Triumph Films"],
              "producers": ["Steven Paul"],
              "winner": false
            },
            {
              "id": 129,
              "year": 2004,
              "title": "Surviving Christmas",
              "studios": ["DreamWorks"],
              "producers": ["Betty Thomas", "Jenno Topping"],
              "winner": false
            },
            {
              "id": 130,
              "year": 2004,
              "title": "White Chicks",
              "studios": ["Columbia Pictures", "Revolution Studios"],
              "producers": ["Keenen Ivory Wayans", "Lee R. Mayes", "Marlon Wayans", "Rick Alvarez", "Shawn Wayans"],
              "winner": false
            },
            {
              "id": 131,
              "year": 2005,
              "title": "Dirty Love",
              "studios": ["First Look Pictures"],
              "producers": [
                "BJ Davis",
                "Jenny McCarthy",
                "John Mallory Asher",
                "Kimberley Kates",
                "Michael Manasseri",
                "Rod Hamilton",
                "Trent Walford"
              ],
              "winner": true
            },
            {
              "id": 132,
              "year": 2005,
              "title": "Deuce Bigalow: European Gigolo",
              "studios": ["Columbia Pictures"],
              "producers": ["Adam Sandler", "Rob Schneider"],
              "winner": false
            },
            {
              "id": 133,
              "year": 2005,
              "title": "The Dukes of Hazzard",
              "studios": ["Village Roadshow", "Warner Bros."],
              "producers": ["Bill Gerber"],
              "winner": false
            },
            {
              "id": 134,
              "year": 2005,
              "title": "House of Wax",
              "studios": ["Village Roadshow", "Warner Bros."],
              "producers": ["Joel Silver", "Robert Zemeckis", "Susan Levin"],
              "winner": false
            },
            {
              "id": 135,
              "year": 2005,
              "title": "Son of the Mask",
              "studios": ["New Line Cinema"],
              "producers": ["Erica Huggins", "Scott Kroopf"],
              "winner": false
            },
            {
              "id": 136,
              "year": 2006,
              "title": "Basic Instinct 2",
              "studios": ["C2 Pictures", "MGM"],
              "producers": ["Andrew G. Vajna", "Joel B. Michaels", "Mario Kassar"],
              "winner": true
            },
            {
              "id": 137,
              "year": 2006,
              "title": "BloodRayne",
              "studios": ["Romar Entertainment"],
              "producers": ["Dan Clarke", "Uwe Boll", "Wolfgang Herrold"],
              "winner": false
            },
            {
              "id": 138,
              "year": 2006,
              "title": "Lady in the Water",
              "studios": ["Warner Bros."],
              "producers": ["Jose L. Rodriguez", "M. Night Shyamalan", "Sam Mercer"],
              "winner": false
            },
            {
              "id": 139,
              "year": 2006,
              "title": "Little Man",
              "studios": ["Columbia Pictures", "Revolution Studios"],
              "producers": ["Lee Mays", "Marlon Wayans", "Rick Alvares", "Shawn Wayans"],
              "winner": false
            },
            {
              "id": 140,
              "year": 2006,
              "title": "The Wicker Man",
              "studios": ["Warner Bros."],
              "producers": ["Avi Lerner", "Joanne Sellar", "Nicolas Cage", "Norm Golightly", "Randall Emmett"],
              "winner": false
            },
            {
              "id": 141,
              "year": 2007,
              "title": "I Know Who Killed Me",
              "studios": ["TriStar Pictures"],
              "producers": ["David Grace", "Frank Mancuso Jr."],
              "winner": false
            },
            {
              "id": 142,
              "year": 2007,
              "title": "Bratz",
              "studios": ["Lionsgate"],
              "producers": ["Avi Arad", "Isaac Larian", "Steven Paul"],
              "winner": false
            },
            {
              "id": 143,
              "year": 2007,
              "title": "Daddy Day Camp",
              "studios": ["Revolution Studios", "TriStar Pictures"],
              "producers": ["John Davis", "Matt Berenson", "Wyck Godfrey"],
              "winner": false
            },
            {
              "id": 144,
              "year": 2007,
              "title": "I Now Pronounce You Chuck & Larry",
              "studios": ["Universal Studios"],
              "producers": ["Adam Sandler", "Tom Shadyac"],
              "winner": false
            },
            {
              "id": 145,
              "year": 2007,
              "title": "Norbit",
              "studios": ["DreamWorks"],
              "producers": ["Eddie Murphy", "John Davis", "Michael Tollin"],
              "winner": false
            },
            {
              "id": 146,
              "year": 2008,
              "title": "The Love Guru",
              "studios": ["Paramount Pictures"],
              "producers": ["Gary Barber", "Michael DeLuca", "Mike Myers"],
              "winner": true
            },
            {
              "id": 147,
              "year": 2008,
              "title": "Disaster Movie and Meet the Spartans",
              "studios": ["20th Century Fox", "Lionsgate"],
              "producers": ["Aaron Seltzer", "Jason Friedberg", "Peter Safran"],
              "winner": false
            },
            {
              "id": 148,
              "year": 2008,
              "title": "The Happening",
              "studios": ["20th Century Fox"],
              "producers": ["Barry Mendel", "M. Night Shyamalan", "Sam Mercer"],
              "winner": false
            },
            {
              "id": 149,
              "year": 2008,
              "title": "The Hottie & the Nottie",
              "studios": ["Regent Releasing"],
              "producers": ["Hadeel Reda"],
              "winner": false
            },
            {
              "id": 150,
              "year": 2008,
              "title": "In the Name of the King",
              "studios": ["Boll KG", "Brightlight Pictures"],
              "producers": ["Dan Clarke", "Shawn Williamson", "Uwe Boll", "Wolfgang Herrold"],
              "winner": false
            },
            {
              "id": 151,
              "year": 2009,
              "title": "Transformers: Revenge of the Fallen",
              "studios": ["DreamWorks", "Hasbro", "Paramount Pictures"],
              "producers": ["Don Murphy", "Ian Bryce", "Lorenzo di Bonaventura", "Tom DeSanto"],
              "winner": true
            },
            {
              "id": 152,
              "year": 2009,
              "title": "All About Steve",
              "studios": ["20th Century Fox"],
              "producers": ["Mary McLaglen", "Sandra Bullock"],
              "winner": false
            },
            {
              "id": 153,
              "year": 2009,
              "title": "G.I. Joe: The Rise of Cobra",
              "studios": ["Hasbro", "Paramount Pictures"],
              "producers": ["Bob Ducsay", "Brian Goldner", "Lorenzo di Bonaventura"],
              "winner": false
            },
            {
              "id": 154,
              "year": 2009,
              "title": "Land of the Lost",
              "studios": ["Universal Studios"],
              "producers": ["Jimmy Miller", "Marty Krofft", "Sid"],
              "winner": false
            },
            {
              "id": 155,
              "year": 2009,
              "title": "Old Dogs",
              "studios": ["Walt Disney Pictures"],
              "producers": ["Andrew Panay", "Peter Abrams", "Robert Levy"],
              "winner": false
            },
            {
              "id": 156,
              "year": 2010,
              "title": "The Last Airbender",
              "studios": ["Nickelodeon Movies", "Paramount Pictures"],
              "producers": ["Frank Marshall", "Kathleen Kennedy", "M. Night Shyamalan", "Sam Mercer"],
              "winner": true
            },
            {
              "id": 157,
              "year": 2010,
              "title": "The Bounty Hunter",
              "studios": ["Columbia Pictures"],
              "producers": ["Neal H. Moritz"],
              "winner": false
            },
            {
              "id": 158,
              "year": 2010,
              "title": "Sex and the City 2",
              "studios": ["HBO Films", "New Line Cinema", "Village Roadshow Pictures"],
              "producers": ["Darren Star", "John Melfi", "Michael Patrick King", "Sarah Jessica Parker"],
              "winner": false
            },
            {
              "id": 159,
              "year": 2010,
              "title": "The Twilight Saga: Eclipse",
              "studios": ["Summit Entertainment"],
              "producers": ["Karen Rosenfelt", "Wyck Godfrey"],
              "winner": false
            },
            {
              "id": 160,
              "year": 2010,
              "title": "Vampires Suck",
              "studios": ["20th Century Fox"],
              "producers": ["Aaron Seltzer", "Jason Friedberg", "Peter Safran"],
              "winner": false
            },
            {
              "id": 161,
              "year": 2011,
              "title": "Jack and Jill",
              "studios": ["Columbia Pictures"],
              "producers": ["Adam Sandler", "Jack Giarraputo", "Todd Garner"],
              "winner": true
            },
            {
              "id": 162,
              "year": 2011,
              "title": "Bucky Larson: Born to Be a Star",
              "studios": ["Columbia Pictures"],
              "producers": ["Allen Covert", "Barry Bernardi", "David Dorfman", "Jack Giarraputo"],
              "winner": false
            },
            {
              "id": 163,
              "year": 2011,
              "title": "New Year's Eve",
              "studios": ["New Line Cinema", "Warner Bros."],
              "producers": ["Garry Marshall", "Mike Karz", "Wayne Allan Rice"],
              "winner": false
            },
            {
              "id": 164,
              "year": 2011,
              "title": "Transformers: Dark of the Moon",
              "studios": ["Paramount Pictures"],
              "producers": ["Don Murphy", "Ian Bryce", "Lorenzo di Bonaventura", "Tom DeSanto"],
              "winner": false
            },
            {
              "id": 165,
              "year": 2011,
              "title": "The Twilight Saga: Breaking Dawn – Part 1",
              "studios": ["Summit Entertainment"],
              "producers": ["Karen Rosenfelt", "Stephenie Meyer", "Wyck Godfrey"],
              "winner": false
            },
            {
              "id": 166,
              "year": 2012,
              "title": "The Twilight Saga: Breaking Dawn – Part 2",
              "studios": ["Summit Entertainment"],
              "producers": ["Karen Rosenfelt", "Stephenie Meyer", "Wyck Godfrey"],
              "winner": true
            },
            {
              "id": 167,
              "year": 2012,
              "title": "Battleship",
              "studios": ["Universal Studios"],
              "producers": [
                "Bennett Schneir",
                "Brian Goldner",
                "Duncan Henderson",
                "Peter Berg",
                "Sarah Aubrey",
                "Scott Stuber"
              ],
              "winner": false
            },
            {
              "id": 168,
              "year": 2012,
              "title": "The Oogieloves in the Big Balloon Adventure",
              "studios": ["Kenn Viselman Presents", "Lionsgate Films", "Romar Entertainment"],
              "producers": ["Gayle Dickie", "Kenn Viselman"],
              "winner": false
            },
            {
              "id": 169,
              "year": 2012,
              "title": "That's My Boy",
              "studios": ["Columbia Pictures"],
              "producers": ["Adam Sandler", "Allen Covert", "Heather Parry", "Jack Giarraputo"],
              "winner": false
            },
            {
              "id": 170,
              "year": 2012,
              "title": "A Thousand Words",
              "studios": ["DreamWorks", "Paramount Pictures"],
              "producers": [
                "Alain Chabat",
                "Brian Robbinsand Sharla Sumpter Bridgett",
                "Nicolas Cage",
                "Norman Golightly",
                "Stephanie Danan"
              ],
              "winner": false
            },
            {
              "id": 171,
              "year": 2013,
              "title": "Movie 43",
              "studios": ["Relativity Media"],
              "producers": ["Charles B. Wessler", "John Penotti", "Peter Farrelly", "Ryan Kavanaugh"],
              "winner": true
            },
            {
              "id": 172,
              "year": 2013,
              "title": "After Earth",
              "studios": ["Columbia Pictures"],
              "producers": [
                "Caleeb Pinkett",
                "Jada Pinkett Smith",
                "Jaden Smith",
                "James Lassiter",
                "M. Night Shyamalan",
                "Will Smith"
              ],
              "winner": false
            },
            {
              "id": 173,
              "year": 2013,
              "title": "Grown Ups 2",
              "studios": ["Columbia Pictures"],
              "producers": ["Adam Sandler", "Jack Giarraputo"],
              "winner": false
            },
            {
              "id": 174,
              "year": 2013,
              "title": "The Lone Ranger",
              "studios": ["Walt Disney Pictures"],
              "producers": ["Gore Verbinski", "Jerry Bruckheimer"],
              "winner": false
            },
            {
              "id": 175,
              "year": 2013,
              "title": "A Madea Christmas",
              "studios": ["Lionsgate"],
              "producers": ["Matt Moore", "Ozzie Areu", "Tyler Perry"],
              "winner": false
            },
            {
              "id": 176,
              "year": 2014,
              "title": "Saving Christmas",
              "studios": ["Samuel Goldwyn Films"],
              "producers": ["Amanda Rosser", "Darren Doane", "David Shannon", "Raphi Henley"],
              "winner": true
            },
            {
              "id": 177,
              "year": 2014,
              "title": "Left Behind",
              "studios": ["Entertainment One", "Freestyle Releasing"],
              "producers": ["Michael Walker", "Paul LaLonde"],
              "winner": false
            },
            {
              "id": 178,
              "year": 2014,
              "title": "The Legend of Hercules",
              "studios": ["Summit Entertainment"],
              "producers": ["Boaz Davidson", "Danny Lerner", "Les Weldon", "Renny Harlin"],
              "winner": false
            },
            {
              "id": 179,
              "year": 2014,
              "title": "Teenage Mutant Ninja Turtles",
              "studios": ["Nickelodeon Movies", "Paramount Pictures", "Platinum Dunes"],
              "producers": [
                "Andrew Form",
                "Bradley Fuller",
                "Galen Walker",
                "Ian Bryce",
                "Michael Bay",
                "Scott Mednick"
              ],
              "winner": false
            },
            {
              "id": 180,
              "year": 2014,
              "title": "Transformers: Age of Extinction",
              "studios": ["Paramount Pictures"],
              "producers": ["Don Murphy", "Ian Bryce", "Lorenzo di Bonaventura", "Tom DeSanto"],
              "winner": false
            },
            {
              "id": 181,
              "year": 2015,
              "title": "Fantastic Four",
              "studios": ["20th Century Fox"],
              "producers": ["Gregory Goodman", "Hutch Parker", "Matthew Vaughn", "Robert Kulzer", "Simon Kinberg"],
              "winner": true
            },
            {
              "id": 182,
              "year": 2015,
              "title": "Fifty Shades of Grey",
              "studios": ["Focus Features", "Universal Pictures"],
              "producers": ["Dana Brunetti", "E. L. James", "Michael De Luca"],
              "winner": true
            },
            {
              "id": 183,
              "year": 2015,
              "title": "Jupiter Ascending",
              "studios": ["Warner Bros."],
              "producers": ["Grant Hill", "The Wachowskis"],
              "winner": false
            },
            {
              "id": 184,
              "year": 2015,
              "title": "Paul Blart: Mall Cop 2",
              "studios": ["Columbia Pictures"],
              "producers": ["Adam Sandler", "Kevin James", "Todd Garner"],
              "winner": false
            },
            {
              "id": 185,
              "year": 2015,
              "title": "Pixels",
              "studios": ["Columbia Pictures"],
              "producers": ["Adam Sandler", "Allen Covert", "Chris Columbus", "Mark Radcliffe"],
              "winner": false
            },
            {
              "id": 186,
              "year": 2016,
              "title": "Hillary's America: The Secret History of the Democratic Party",
              "studios": ["Quality Flix"],
              "producers": ["Gerald R. Molen"],
              "winner": true
            },
            {
              "id": 187,
              "year": 2016,
              "title": "Batman v Superman: Dawn of Justice",
              "studios": ["Warner Bros."],
              "producers": ["Charles Roven", "Deborah Snyder"],
              "winner": false
            },
            {
              "id": 188,
              "year": 2016,
              "title": "Dirty Grandpa",
              "studios": ["Lionsgate"],
              "producers": ["Barry Josephson", "Bill Block", "Jason Barrett", "Michael Simkin"],
              "winner": false
            },
            {
              "id": 189,
              "year": 2016,
              "title": "Gods of Egypt",
              "studios": ["Summit Entertainment"],
              "producers": ["Alex Proyas", "Basil Iwanyk"],
              "winner": false
            },
            {
              "id": 190,
              "year": 2016,
              "title": "Independence Day: Resurgence",
              "studios": ["20th Century Fox"],
              "producers": ["Dean Devlin", "Harald Kloser", "Roland Emmerich"],
              "winner": false
            },
            {
              "id": 191,
              "year": 2016,
              "title": "Zoolander 2",
              "studios": ["Paramount Pictures"],
              "producers": ["Ben Stiller", "Clayton Townsend", "Scott Rudin", "Stuart Cornfeld"],
              "winner": false
            },
            {
              "id": 192,
              "year": 2017,
              "title": "The Emoji Movie",
              "studios": ["Columbia Pictures"],
              "producers": ["Michelle Raimo Kouyate"],
              "winner": true
            },
            {
              "id": 193,
              "year": 2017,
              "title": "Baywatch",
              "studios": ["Paramount Pictures"],
              "producers": ["Beau Flynn", "Douglas Schwartz", "Gregory J. Bonann", "Ivan Reitman", "Michael Berk"],
              "winner": false
            },
            {
              "id": 194,
              "year": 2017,
              "title": "Fifty Shades Darker",
              "studios": ["Universal Pictures"],
              "producers": ["Dana Brunetti", "E. L. James", "Marcus Viscidi", "Michael De Luca"],
              "winner": false
            },
            {
              "id": 195,
              "year": 2017,
              "title": "The Mummy",
              "studios": ["Universal Pictures"],
              "producers": ["Alex Kurtzman", "Chris Morgan", "Sarah Bradshaw", "Sean Daniel"],
              "winner": false
            },
            {
              "id": 196,
              "year": 2017,
              "title": "Transformers: The Last Knight",
              "studios": ["Paramount Pictures"],
              "producers": ["Don Murphy", "Ian Bryce", "Lorenzo di Bonaventura", "Tom DeSanto"],
              "winner": false
            },
            {
              "id": 197,
              "year": 2018,
              "title": "Holmes & Watson",
              "studios": ["Columbia Pictures"],
              "producers": ["Adam McKay", "Clayton Townsend", "Jimmy Miller", "Will Ferrell"],
              "winner": true
            },
            {
              "id": 198,
              "year": 2018,
              "title": "Gotti",
              "studios": ["Vertical Entertainment"],
              "producers": ["George Furla", "Marc Fiore", "Michael Froch", "Randall Emmett"],
              "winner": false
            }
          ],
          "pageable": {
            "sort": {"unsorted": true, "sorted": false, "empty": true},
            "offset": 99,
            "pageSize": 99,
            "pageNumber": 1,
            "paged": true,
            "unpaged": false
          },
          "totalPages": 3,
          "totalElements": 206,
          "last": false,
          "size": 99,
          "number": 1,
          "sort": {"unsorted": true, "sorted": false, "empty": true},
          "first": false,
          "numberOfElements": 99,
          "empty": false
        }));
      }
      Map<String, dynamic> queryParameters = {
        'page': page,
        'size': size,
        if (year != null) 'year': year,
        if (winner != null) 'winner': winner,
      };

      final response = await _restClientService.request(
        path: '',
        queryParameters: queryParameters,
      );

      if (response.isError) return ResponseModel(error: response.error);

      return ResponseModel(data: FilmPaginationModel.fromMap(response.data));
    } catch (e, s) {
      LoggerApp.error('Error on get winners by year', e, s);
      return ResponseModel(
        error: CustomException(
          message: 'Error on get winners by year',
          exception: e,
          stackTrace: s,
        ),
      );
    }
  }
}

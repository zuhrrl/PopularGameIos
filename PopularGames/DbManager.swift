//
//  DbManager.swift
//  PopularGames
//
//  Created by WDT on 26/07/24.
//

import Foundation

import SQLite3

class DBManager{
    init(){
        db = openDatabase()
        createFavoriteGameTable()
    }
    
    let dataPath: String = "MyDB"
    var db: OpaquePointer?
    
    // Create DB
    func openDatabase()->OpaquePointer?{
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(dataPath)
        
        var db: OpaquePointer? = nil
        if sqlite3_open(filePath.path, &db) != SQLITE_OK{
            debugPrint("Cannot open DB.")
            return nil
        }
        else{
            print("DB already created and can be opened.")
            return db
        }
    }
    
    func createFavoriteGameTable() {
        let createTableString = """
            CREATE TABLE IF NOT EXISTS FavoriteGames (
                id INTEGER PRIMARY KEY,
                title TEXT,
                genres TEXT,
                rating TEXT,
                description TEXT,
                image_url TEXT,
                release_date TEXT,
                is_favorite INT
            );
        """

        var createTableStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("FavoriteGame table is created successfully.")
            } else {
                print("FavoriteGame table creation failed.")
            }
        } else {
            print("FvoriteGame table creation failed.")
        }

        sqlite3_finalize(createTableStatement)
    }
    
    func dropTable() {
        let createTableString = """
            DROP TABLE FavoriteGames;
        """

        var createTableStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("FavoriteGame table is DROP successfully.")
            } else {
                print("FavoriteGame table DROP failed.")
            }
        } else {
            print("FvoriteGame table creation failed.")
        }

        sqlite3_finalize(createTableStatement)
    }

    
    func addToFavorite(game: Game) -> Bool{
        let favorites = getAllFavoriteGame()
        debugPrint("Fetching favorites game from sqlite: \(favorites)")
        
        for item in favorites{
            if item.id == game.id {
                return false
            }
        }
        
        debugPrint("Trying to insert game \(game.title)")

        let insertStatementString = "INSERT INTO FavoriteGames (id, title, genres, rating, description, image_url, release_date, is_favorite ) VALUES (?, ?, ?, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(game.id))
            sqlite3_bind_text(insertStatement, 2, (game.title as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (game.genres as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, ("4.2" as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (game.description as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (game.imageUrl as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 7, (game.releasedDate as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 8, Int32(1))


            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Added to favorite successfully.")
                sqlite3_finalize(insertStatement)
                return true
            } else {
                debugPrint("cant add this to favorite")
                return false
            }
        } else {
            print("INSERT statement is failed.")
            return false
        }
    }

    func getAllFavoriteGame() -> [Game] {
        let queryStatementString = "SELECT * FROM FavoriteGames;"
        var queryStatement: OpaquePointer? = nil
        var favoriteGames : [Game] = []
        if sqlite3_prepare_v2(db,  queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let title = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let genres = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let rating = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let description = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let imageUrl = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let releaseDate = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))
                let isFavorite = sqlite3_column_int(queryStatement, 7)
                favoriteGames.append(Game(id: Int(id), title: title, genres: genres, rating: Double(rating)!, description: description, imageUrl: imageUrl, releasedDate: releaseDate, isFavorite: isFavorite == 1 ? true : false))
               
            }
        } else {
            print("SELECT statement is failed.")
        }
        sqlite3_finalize(queryStatement)
        return favoriteGames
    }
   
    func getFavoriteGameById(id:Int) -> Game? {
        let queryStatementString = "SELECT * FROM FavoriteGames WHERE id = ?;"
        var queryStatement: OpaquePointer? = nil
        var game : Game? = nil
        
        if sqlite3_prepare_v2(db,  queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(queryStatement, 1, (String(id) as NSString).utf8String, -1, nil)
            
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let title = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let genres = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let rating = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let description = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let imageUrl = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let releaseDate = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))
                let isFavorite = sqlite3_column_int(queryStatement, 7)
                
                game = Game(id: Int(id), title: title, genres: genres, rating: Double(rating)!, description: description, imageUrl: imageUrl, releasedDate: releaseDate, isFavorite: isFavorite == 1 ? true : false)
//                print("\(id) | \(title) | \(description)")
            }
        } else {
            print("SELECT statement is failed.")
        }
        sqlite3_finalize(queryStatement)
        return game
    }

    func updateGame(game: Game, status: Bool) -> Bool{
        let updateStatementString = "UPDATE FavoriteGames SET is_favorite=? WHERE id=?;"
        var updateStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(updateStatement, 1, Int32(truncating: status ? 1 : 0))
            sqlite3_bind_int(updateStatement, 2, Int32(game.id))

            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Game updated successfully.")
                sqlite3_finalize(updateStatement)
                return true
            } else {
                print("Could not update.")
                return false
            }
        } else {
            print("UPDATE statement is failed.")
            return false
        }
    }
    
    func deleteFavoriteGame(game: Game) -> Bool{
        let updateStatementString = "DELETE FROM FavoriteGames WHERE id=?;"
        var updateStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(updateStatement, 1, Int32(game.id))

            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Game deleted successfully.")
                sqlite3_finalize(updateStatement)
                return true
            } else {
                print("Could not delete.")
                return false
            }
        } else {
            print("DELETE statement is failed.")
            return false
        }
    }
    
}

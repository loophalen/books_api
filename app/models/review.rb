class Review
    
    if(ENV['DATABASE_URL'])
        uri = URI.parse(ENV['DATABASE_URL'])
        DB = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)
    else
        DB = PG.connect(host: "localhost", port: 5432, dbname: 'books_api_development')
    end

    def self.all
        result = DB.exec("SELECT * FROM reviews;")
        return result.map do |result|
            {
                "id" => result["id"].to_i,
                "book_id" => result["book_id"].to_i, 
                "user_id" => result["user_id"].to_i, 
                "review_content" => result["review_content"]
            }
        end
    end

    def self.find(id)
        results = DB.exec("SELECT * FROM reviews WHERE id=#{id};")
        return {
            "id" => results.first["id"].to_i,
            "book_id" => results.first["book_id"].to_i, 
            "user_id" => results.first["user_id"].to_i, 
            "review_content" => results.first["review_content"]
        }
    end

    def self.create(opts)
        results = DB.exec(
            <<-SQL
                INSERT INTO reviews (book_id, user_id, review_content)
                VALUES ( '#{opts["book_id"]}', '#{opts["user_id"]}', '#{opts["review_content"]}' )
                RETURNING id, book_id, user_id, review_content;
            SQL
        )
        return {
            "id" => results.first["id"].to_i,
            "book_id" => results.first["book_id"].to_i, 
            "user_id" => results.first["user_id"].to_i, 
            "review_content" => results.first["review_content"]
        }
    end

    def self.delete(id)
        results = DB.exec("DELETE FROM reviews WHERE id=#{id};")
        return { "deleted" => true }
    end

    def self.update(id, opts)
        results = DB.exec(
            <<-SQL
                UPDATE reviews
                SET book_id='#{opts["book_id"]}', user_id='#{opts["user_id"]}', review_content='#{opts["review_content"]}'
                WHERE id=#{id}
                RETURNING id, book_id, user_id, review_content; 
            SQL
        )
        return {
            "id" => results.first["id"].to_i,
            "book_id" => results.first["book_id"].to_i, 
            "user_id" => results.first["user_id"].to_i, 
            "review_content" => results.first["review_content"]
        }
    end

end 
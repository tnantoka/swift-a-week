import Vapor
import Fluent

let drop = Droplet()

let database = Database(MemoryDriver())
drop.database = database
drop.preparations.append(Post.self)

drop.get { req in
    return try drop.view.make("welcome", [
    	"message": drop.localization[req.lang, "welcome", "title"]
    ])
}

drop.resource("posts", PostController())

drop.run()

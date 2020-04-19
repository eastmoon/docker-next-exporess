var mongo = require('mongodb').MongoClient;
var url = "mongodb://db/runoob";

mongo.connect(url, { useNewUrlParser: true }, function(err, db) {
    if (err) throw err;
    console.log("Database connect success !");
    db.close();
});

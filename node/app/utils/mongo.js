const MongoClient = require('mongodb').MongoClient;


module.exports = function(url, dbName, docName) {
    //
    const connect = function(callback) {
        MongoClient.connect(url, { useNewUrlParser: true }, (err, client) => {
            if (err) throw err;
            console.log("Connected successfully to server");
            const database = client.db(dbName);
            if (typeof callback === "function") {
                callback(client, database);
            }
        });
    }
    //
    const createDoc = function(db, callback) {
        db.dropCollection(docName, (err, result) => {
            if (typeof callback === "function") {
                callback();
            }
        });
    }
    const insertDoc = function(db, data, callback) {
        const collection = db.collection(docName);
        collection.insertMany(data, (err, result) => {
            console.log(`Inserted ${result.ops.length} documents into the collection`);
            if (typeof callback === "function") {
                callback();
            }
        });
    }
    const infoDoc = function(db, callback) {
        const collection = db.collection(docName);
        collection.find({}).toArray((err, docs) => {
            console.log(`Total ${docs.length} document in collection`);
            if (typeof callback === "function") {
                callback();
            }
        });
    }
    const findDoc = function(db, target, callback) {
        const collection = db.collection(docName);
        collection.find(target).toArray((err, docs) => {
            console.log("Found the following records");
            console.log(docs)
            if (typeof callback === "function") {
                callback(docs);
            }
        });
    }
    const updateDoc = function(db, target, data, callback) {
        const collection = db.collection(docName);
        collection.updateOne(target, {$set: data}, (err, result) => {
            console.log(`Updated ${result.result.n} document.`);
            if (typeof callback === "function") {
                callback();
            }
        });
    }
    return {
        connect: connect,
        create: createDoc,
        insert: insertDoc,
        info: infoDoc,
        find: findDoc,
        update: updateDoc
    }
}

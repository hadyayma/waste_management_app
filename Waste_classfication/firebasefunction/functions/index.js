const strip = require('strip')('pk_test_51MyLo8Hu08yQS1TjpVZGNfvqey9aqGPl6wGkqRsY825opft9krIxuI5lzOb08VDCUZS5hE7ZK6EFprBiAiK9X6p300M3d0NP55');



const functions = require("firebase-functions");
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

exports.stripeCheckout = functions.https.onCall(async (data, context) => {
    var productId = data['id'];
    console.log('product id = ' + productId);

    var price = -1;
    var name = '';
    var image = '';

    // if you know the docId
    //
    // var db = admin.firestore();
    // var docId = '123';
    // var doc = await db.collection('clothes').doc(docId).get();
    // price = doc.data().price;
    // name = doc.data().name;
    // image = doc.data().image;


    // if you need to query for the doc
    //
    var db = admin.firestore();
    var querySnapshot = await db.collection('product').where('id', '==', productId).get();
    if (querySnapshot.docs.length > 0){
        var doc = querySnapshot.docs[0];
        price = doc.data().price;
        type = doc.data().type;
        name = doc.data().name;
        image = doc.data().image;
    }
    else {
        console.log('Error: document with product id ' + productId + ' not found');
        return null;
    }
    
    const session = await stripe.checkout.sessions.create({
        payment_method_types: ['card'],
        line_items: [{
            name: name,
            description: 'description!',
            images: [image],
            amount: Math.round(price * 100),                // round to the nearest whole number so we don't have float errors
            currency: 'usd',
            quantity: 1
        }],
        mode: 'payment',
        success_url: 'http://localhost:4205/home?action=success',
        cancel_url: 'http://localhost:4205/home?action=cancel',
    });

    return session.id;
})

// more examples 


exports.stripeCheckoutWithoutDbQueries = functions.https.onCall(async (data, context) => {
    var productName = data['productName'];
    var price = data['price'];
    console.log('data: ', data);
    console.log('product name = ', productName);
    console.log('price = ', price);

    const session = await stripe.checkout.sessions.create({
        payment_method_types: ['card'],
        line_items: [{
            name: productName,
            images: [image],
            amount: Math.round(price * 100),                // round to the nearest whole number so we don't have float errors
            currency: 'usd',
            quantity: 1

        }],
        mode: 'payment',
        success_url: 'http://localhost:4205/home?action=success',
        cancel_url: 'http://localhost:4205/home?action=cancel',
    });

    return session.id;
})


exports.randomNumberRequest = functions.https.onRequest((request, response) => {
    const number = Math.round(Math.random() * 100);
    console.log('number', number);
    response.send(number.toString());
})


exports.randomNumberCall = functions.https.onCall((data, context) => {
    const number = Math.round(Math.random() * 100);
    console.log('number', number);
    return (number);
})
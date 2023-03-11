const mongoose = require("mongoose");

const productSchema = new mongoose.Schema({
  title: { type: String, required: true },
  description: { type: String, required: true },
  price: { type: Number, required: true },
  imageUrl: { type: String, required: true },
  isFavourite: { type: Boolean, required: true },
});

const ProductModel = mongoose.model("product", productSchema);

module.exports = {
  ProductModel,
};
// Schema 
// final String id;
// final String title;
// final String description;
// final double price;
// final String imageUrl;

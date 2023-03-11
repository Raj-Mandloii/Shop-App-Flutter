const mongoose = require("mongoose");

const orderSchema = new mongoose.Schema({
  amount: { type: String, required: true },
  dateTime: { type: String, required: true },
  products: { type: Array, required: true },
});

const OrderModel = mongoose.model("order", orderSchema);

module.exports = {
  OrderModel,
};
// Schema
// final String id;
// final String title;
// final String description;
// final double price;
// final String imageUrl;

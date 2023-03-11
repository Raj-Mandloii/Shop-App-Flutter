const { Router } = require("express");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
require("dotenv").config();
const cors = require("cors");

const { OrderModel } = require("../models/orders.model.");

const ordersController = Router();

ordersController.use(cors());

ordersController.get("/", async (req, res) => {
  try {
    const data = await OrderModel.find();
    console.log(data);
    res.send(data);
  } catch (error) {
    throw new Error(error);
  }
});

ordersController.post("/create", async (req, res) => {
  const newOrder = new OrderModel(req.body);

  try {
    let order = await newOrder.save();
    res.status(201).send(order);
  } catch (err) {
    res.status(500).send("Something went wrong");
  }
});

ordersController.put("/:id", async (req, res) => {
  const { id } = req.params;

  try {
    const find = await OrderModel.updateOne(
      { _id: id },
      { $set: { ...req.body } }
    );
    res.send(find);
  } catch (error) {
    throw new Error(error);
  }
});

ordersController.delete("/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const deleted = await OrderModel.deleteOne({ _id: id });
    res.send(deleted);
  } catch (error) {
    throw new Error(error);
  }
});
module.exports = {
  ordersController,
};

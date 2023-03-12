const { Router } = require("express");
const bcrypt = require("bcrypt"); // to encrypt user password and save, so that password is not exposed to someone.
const jwt = require("jsonwebtoken"); // to generate token
require("dotenv").config();
const cors = require("cors");

const { ProductModel } = require("../models/product.model");

const productController = Router();

productController.use(cors());
// Get API.
productController.get("/", async (req, res) => {
  try {
    // Filtering
    const queryObj = { ...req.query };
    const excludeFields = ["page", "sort", "limit", "fields"];
    excludeFields.forEach((el) => delete queryObj[el]);
    let queryStr = JSON.stringify(queryObj);
    queryStr = queryStr.replace(/\b(gte|gt|lte|lt)\b/g, (match) => `$${match}`);
    let query = ProductModel.find(JSON.parse(queryStr));

    // Sorting

    if (req.query.sort) {
      const sortBy = req.query.sort.split(",").join(" ");
      query = query.sort(sortBy);
    } else {
      query = query.sort("-createdAt");
    }

    // limiting the fields

    if (req.query.fields) {
      const fields = req.query.fields.split(",").join(" ");
      query = query.select(fields);
    } else {
      query = query.select("-__v");
    }

    // pagination

    const page = req.query.page;
    const limit = req.query.limit;
    const skip = (page - 1) * limit;
    query = query.skip(skip).limit(limit);
    if (req.query.page) {
      const productCount = await ProductModel.countDocuments();
      if (skip >= productCount) throw new Error("This Page does not exists");
    }
    const product = await query;
    res.json(product);
  } catch (error) {
    throw new Error(error);
  }
});

// Create API.
productController.post("/create", async (req, res) => {
  const newProd = new ProductModel(req.body);

  try {
    let a = await newProd.save();
    res.status(201).send(a);
  } catch (err) {
    res.status(500).send("Something went wrong");
  }
});


// Edit/Patch/  API
productController.put("/:id", async (req, res) => {
  const { id } = req.params;

  try {
    const find = await ProductModel.updateOne(
      { _id: id },
      { $set: { ...req.body } }
    );
    res.send(find);
  } catch (error) {
    throw new Error(error);
  }
});
// Delete API
productController.delete("/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const deleted = await ProductModel.deleteOne({ _id: id });
    res.send(deleted);
  } catch (error) {
    throw new Error(error);
  }
});
module.exports = {
  productController,
};

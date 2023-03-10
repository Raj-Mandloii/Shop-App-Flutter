const express = require("express");
const cors = require("cors");
const { userController } = require("./routes/user.routes");
const { productController } = require("./routes/product.routes");
const { connection } = require("./config/db");
const { authentication } = require("./middlewares/authentication");

const app = express();
app.use(express.json());
app.use(cors());

app.use("/user", userController);
app.use("/product", productController);
// app.use('/orders',productController)

app.listen(process.env.PORT, async () => {
  try {
    await connection;
    console.log("Connected to DB");
  } catch (err) {
    console.log("Connected to DB");
  }
});

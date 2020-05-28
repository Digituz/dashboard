import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";
import axios from "axios";

export const loadProducts = createAsyncThunk("products/loadAll", async () => {
  const response = await axios.get("/v1/products");
  return response.data;
});

export const createNewProduct = createAsyncThunk(
  "products/create",
  async (newProduct) => {
    await axios.post("/v1/products", newProduct);
  }
);

export const loadProduct = createAsyncThunk("products/loadOne", async (sku) => {
  const response = await axios.get(`/v1/products/${sku}`);
  return response.data;
});

const productsSlice = createSlice({
  name: "productsSlice",
  initialState: {
    loading: null,
    products: [],
    product: null,
  },
  reducers: {
    showProducts: (state, action) => {
      state.products = action.payload;
    },
  },
  extraReducers: {
    [loadProducts.fulfilled]: (state, action) => {
      state.products.push(...action.payload);
      state.loading = false;
    },
    [loadProduct.pending]: (state) => {
      state.product = null;
      state.loading = true;
    },
    [loadProduct.fulfilled]: (state, action) => {
      state.product = action.payload;
      state.loading = false;
    },
    [loadProduct.rejected]: (state) => {
      state.product = null;
      state.loading = false;
    },
  },
});

export const { showProducts } = productsSlice.actions;

export default productsSlice.reducer;

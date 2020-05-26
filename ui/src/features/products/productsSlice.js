import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";
import axios from "axios";

// First, create the thunk
export const loadProducts = createAsyncThunk("products/load", async () => {
  const response = await axios.get("/v1/products");
  return response.data;
});

const productsSlice = createSlice({
  name: "productsSlice",
  initialState: {
    loading: null,
    products: [],
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
  },
});

export const { showProducts } = productsSlice.actions;

export default productsSlice.reducer;

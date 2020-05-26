import { createSlice } from "@reduxjs/toolkit";

const productsSlice = createSlice({
  name: "productsSlice",
  initialState: {
    loading: null,
    products: [
      {
        key: "1",
        name: "Mike",
        age: 32,
        address: "10 Downing Street",
      },
      {
        key: "2",
        name: "John",
        age: 42,
        address: "10 Downing Street",
      },
    ],
  },
  reducers: {
    loadProducts: (state) => {
      state.loading = true;
    },
    showProducts: (state, action) => {
      state.products = action.payload;
    },
  },
});

export const { loadProducts, showProducts } = productsSlice.actions;

export default productsSlice.reducer;

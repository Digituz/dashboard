import { combineReducers, configureStore } from "@reduxjs/toolkit";
import productsSlice from "../features/products/productsSlice";

const store = configureStore({
  reducer: combineReducers({
    productsSlice: productsSlice,
  }),
});

export default store;

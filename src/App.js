import React from 'react';
import { Button, InputNumber } from 'antd';
import './App.css';

const App = () => (
  <div className="App">
    <Button type="primary">Button</Button>
    <h2>Some button</h2>
    <InputNumber min={1} max={10} defaultValue={3} onChange={() => {}} />
  </div>
);

export default App;
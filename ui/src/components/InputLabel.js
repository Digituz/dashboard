import React from "react";
import styled from "styled-components";

const InputLabelContainer = styled.div`
  display: flex;
  align-items: center;
  height: 100%;
`;

function InputLabel(props) {
  return (
    <InputLabelContainer>
      <label htmlFor={props.htmlFor}>{props.children}</label>
    </InputLabelContainer>
  );
}

export default InputLabel;

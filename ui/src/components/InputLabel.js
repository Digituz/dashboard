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
      <label for={props.for}>{props.children}</label>
    </InputLabelContainer>
  );
}

export default InputLabel;

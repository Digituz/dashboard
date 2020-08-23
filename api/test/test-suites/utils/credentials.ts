import axios from 'axios';

export async function getCredentials() {
  const validCrendetials = {
    username: 'bruno.krebs@fridakahlo.com.br',
    password: 'lbX01as$',
  };

  const resp = await axios.post(
    'http://localhost:3005/v1/sign-in',
    validCrendetials,
  );
  const accessToken = resp.data.access_token;

  expect(accessToken).toBeDefined();

  return {
    headers: {
      authorization: `Bearer ${accessToken}`,
    },
  };
}

import axios from 'axios';

describe('authentication', () => {
  it('should be able to sign in', async () => {
    const validCrendetials = {
      username: 'bruno.krebs@fridakahlo.com.br',
      password: 'lbX01as$',
    };

    const resp = await axios.post(
      'http://localhost:3005/v1/sign-in',
      validCrendetials,
    );
    expect(resp).toBeDefined();
  });

  it('should block unknown users', async () => {
    try {
      const validCrendetials = {
        username: 'bruno.krebs@fridakahlo.com.br',
        password: 'invalidPassword',
      };

      await axios.post('http://localhost:3005/v1/sign-in', validCrendetials);
      fail('an error should be thrown by the line above');
    } catch (err) {
      expect(err).toBeDefined();
    }
  });
});

module.exports = {
  'extends': 'eslint:recommended',
  'env': {
    'node': true,
    'es6': true
  },
  'parser': 'esprima',
  'parserOptions': {
    'ecmaVersion': 7,
    'ecmaFeatures': {
      'experimentalObjectRestSpread': true
    }
  },
  'rules': {
    'indent': ['error', 2],
    'linebreak-style': ['error', 'unix'],
    'quotes': ['error', 'single'],
    'semi': ['error', 'always'],

    'comma-dangle': ['error', 'never'],
    'no-cond-assign': ['error', 'always'],

    'no-template-curly-in-string': ['error'],

    'no-console': 1
  },
  'globals': {
    'T': true,
    'describe': true,
    'it': true,
    'before': true,
    'beforeEach': true,
    'after': true,
    'afterEach': true
  }
};

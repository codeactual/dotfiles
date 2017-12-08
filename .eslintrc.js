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
    'require-await': ['error', 'always'],
    'no-return-await': ['error', 'always'],
    'prefer-promise-reject-errors': ['error', 'always'],

    'no-throw-literal': ['error', 'always'],
    'no-self-compare': ['error', 'always'],
    'no-return-assign': ['error', 'always'],
    'no-new': ['error', 'always'],
    'no-lone-blocks': ['error', 'always'],
    'no-invalid-this': ['error', 'always'],
    'no-eq-null': ['error', 'always'],
    'no-empty-function': ['error', 'always'],
    'no-else-return': ['error', 'always'],
    'default-case': ['error', 'always'],
    'array-callback-return': ['error', 'always'],
    'consistent-return': ['error', 'always'],

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

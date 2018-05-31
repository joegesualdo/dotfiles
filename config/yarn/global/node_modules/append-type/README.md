# append-type

[![NPM version](https://img.shields.io/npm/v/append-type.svg)](https://www.npmjs.com/package/append-type)
[![Bower version](https://img.shields.io/bower/v/append-type.svg)](https://github.com/shinnn/append-type/releases)
[![Build Status](https://travis-ci.org/shinnn/append-type.svg?branch=master)](https://travis-ci.org/shinnn/append-type)
[![Coverage Status](https://img.shields.io/coveralls/shinnn/append-type.svg)](https://coveralls.io/r/shinnn/append-type)
[![devDependencies Status](https://david-dm.org/shinnn/append-type/dev-status.svg)](https://david-dm.org/shinnn/append-type?type=dev)

Stringify the value with appending its [type](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Operators/typeof): `10` → ``'10 (number)'``

```javascript
import appendType from 'append-type';

appendType('123'); //=> 'foo (string)'
appendType(123); //=> '123 (number)'
```

## Installation

### [npm](https://www.npmjs.com/)

```
npm install append-type
```

### [bower](https://bower.io/)

```
bower install append-type
```

## API

### appendType(*value*)

*value*: any type  
Return: `String`

Essentially, it returns `String(value) + ' (' + typeof value + ')'`.

```javascript
appendType(() => {}); //=> '() => {} (function)'
```

When it takes `null` / `undefined`, it returns `'null'` / `'undefined'`.

```javascript
appendType(null); //=> 'null'
appendType(undefined); //=> 'undefined'
```

## Example

This module is useful for making `TypeError` error messages.

```javascript
function reverse(v) {
  if (typeof v !== 'boolean') {
    throw new TypeError(`Expected a Boolean value, but got ${appendType(v)}.`);
  }

  return !v;
};

reverse(1); //=> TypeError: Expected a Boolean value, but got 1 (number).
```

## License

Copyright (c) 2016 [Shinnosuke Watanabe](https://github.com/shinnn)

Licensed under [the MIT License](./LICENSE).

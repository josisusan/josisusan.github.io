---
layout: post
title: "Run Single Group of Test in Golang"
date: 2020-04-15 21:07:30 +0545
tags: [TIL, golang, testing]
categories: [golang, testing]
---

If there are more cases in a test file, it would be difficult to debug the failing test. Today, I learned about a simple command that can increase my focus and productivity while testing in Golang. Suppose, we have multiple function to test and it is organized as

```golang
func TestMathSum(t *testing.T) {
  ...
}

func TestMathProduct(t *testing.T) {
  ...
}
```

In Golang to test the whole file, following command can be used:

```bash
$ go test mathutil_test
```

To test only Sum method, following command can be used:

```bash
$ go test mathutil_test -run MathSum
```

Reference:
[Stackoverflow](https://stackoverflow.com/questions/48465080/how-do-i-run-specific-golang-test-using-go-test-run)
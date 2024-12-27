---
layout: post
title: "Easily Debug CLI app Using VSCode Debugger"
date: "2024-12-27"
category: [vscode]
tags: debug
---

Debugging can often be tedious when relying on print statements and rerunning the program repeatedly. However, Visual Studio Code (VS Code) provides a powerful feature to streamline debugging, especially for CLI-based applications. By integrating terminal input with the VS Code debugger, you can interact with your application seamlessly during a debugging session.

To enable this functionality, you need to configure your `launch.json` file. Add the following line to your debug configuration:
```json
  "console": "integratedTerminal"
```

![VSCode Debugger Configuration for integrated terminal]({{ site.baseurl }}/images/easily-debug-cli-app-using-vscode-debugger-1.webp){:.post-image}

With this configuration, VS Code listens to input provided through the CLI. Now, you can set breakpoints and interact with the CLI directly in the terminal—no more scattering print statements throughout your code.

![Demo for cli dbugger using vscode]({{ site.baseurl }}/images/easily-debug-cli-app-using-vscode-debugger-2.webp){:.post-image}

This simple setup can greatly enhance your debugging efficiency and keep your workflow smooth.

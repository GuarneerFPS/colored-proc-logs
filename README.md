# colored-cmw-logs

This repo contains a lightweight bash script to colorize process logs. It runs without any noticeable overhead and is used by simply calling the script before any regular command you'd normally use.

Although standard GCC has the `-fdiagnostics-color` flag from v4.9, it doesn't help if you're cross-compiling for legacy systems like me. There are many alternatives for modern machines with web access, but I hope this can help those working on dated systems that cannot be updated (yet!).

You won't lose any logs or performance. True color supporting terminal is recommended. 

## Usage

Simply pass your regular commands to start processes as an argument to the `cl.sh` script.

```sh
./cl.sh [command]
```

### Example

```sh
./cl.sh /path/to/bin/MyBin -someFlag /path/to/object/SomeDepObj
```

![Example](/screencapture.PNG)

## How it Works

The script looks for case-sensitive log-level keywords and colorizes lines containing the defined levels. You can modify the levels and colors as you wish.
*  It prints any stdout that doesn't contain the defined keywords as a normal line.
*  At the end of execution, it returns the shell exit status and reports if it's non-zero.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.


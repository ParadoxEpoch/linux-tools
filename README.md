# linux-tools

Dumping ground for some random Linux utils I've written.

## li

Alternative to "ls". Displays permissions in octal form, file size in KB, shows dotfiles by default and differentiates between directories, symlinks & files. Directory parameter can be backslash escaped or include unescaped spaces (positional params are combined to form path). Omitting the parameter will list the current directory, just like "ls". Throw this script in a directory that's in your `$PATH` env like _/usr/local/bin_ or _/usr/bin_ and have fun. Uses _stat_ for data, pipes to _awk_ & uses _sub_ and _printf_ for data processing.

```bash
> li ~/Desktop/linux-tools
drwxr-xr-x 755 paradox:paradox DIR -- .git/
-rw-r--r-- 644 paradox:paradox 0KB -- .gitattributes
drwxr-xr-x 755 paradox:paradox LNK -- testlnk >>
-rwxr-xr-x 755 paradox:paradox 0KB -- li
-rw-r--r-- 644 paradox:paradox 1KB -- LICENSE
-rw-r--r-- 644 paradox:paradox 0KB -- README.md
```

# ex-cast
#### A script to add explicit casts to C pointers
`warning: assignment to / initialization of ‘char *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]`

### Use ex-cast to make these warnings disappear! 🪄
# Installation
Just download the ex-cast.sh script.
# Usage
Prepend a call to this script to any build command that outputs errors like the one above.
```
bash /path/to/ex-cast.sh make --your-usual-arguments
```

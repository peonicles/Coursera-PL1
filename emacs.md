# Emacs

Notation
C : uppercase C is for `ctrl`
M : uppercase M is for `meta`, which is `alt`
- : key to press after `ctrl` or `meta`
    eg. C-x : ctrl-x
C-x C-s : Hold down `ctrl` while pressing the `x` and `s` keys
C-x 2   : `ctrl-x`, then `2`

Common commands
- C-g : Cancel current action
- C-x C-c : Quit emacs
- C-x C-f : Open a file
- C-x C-s : Save a file
- C-x C-w : Write a file, aka Save-as

Cut, copy, paste
- C-space : set a mark then move the cursor to set the region
- C-w : Cut the highlighted region
- M-w : Copy the highlighted region
- C-k : Cut (or Kill) from the cursor to end of line
- C-y : Paste (yank)

Buffers
- C-x 2 : Split the window into 2 buffers, top and bottom
- C-x 3 : Split the window into 2 buffers, left and right
- C-x o : Switch between buffers
- C-x 0 : Remove split, only 1 buffer
- C-x b : Switch to another buffer by entering its name
- C-x C-b : See a list of all current buffers

Help
- C-h : Display short help message in the minibuffer
- C-h b : Key bindings - list key bindings applicable to the current mode
- C-h a : Command apropos - type a symbol and press enter, a buffer will display matching symbols and functions

REPL
- C-c C-s : start a buffer running the sml repl
- C-c C-c : stops current processing. kills infinite loop.
- C-d : kill the current repl
- M-p : previous command
# Evil Lispy

Wrap [Lispy](https://github.com/abo-abo/lispy) in an
[Evil](https://gitorious.org/evil/pages/Home) sexp editing state.  I tried to
keep commands mappings close to similar vim mneumonics. Not every command has
been mapped yet. The motivation for this is essentially to make Lispy active
explicitly rather than implicitly.

# Command Reference
## Normal and Sexp state

 - Enter the sexp editing state with either `(` or `)`.
 - Exit it with ESC, or word motions (w/W b/B e/E) to return to normal state.
 - Use i, a, SPC, or RET to enter insert state.

 - x, X kill full sexps on the boundary
 - D, C preserve paren balance
 - S kills the current sexp and enters insert state

 - gv mark a symbol and enter sexp state
 - gV mark an sexp and enter sexp state

 - gJ split an sexp


## Navigation
    |-----+--------------------------+------------+-------------------|
    | key | command                  | key        | command           |
    |-----+--------------------------+------------+-------------------|
    | (   | `lispy-out-backward`     | )          | `lispy-out-forward`
    | a   | `lispy-backward`         | l          | `lispy-forward`   |
    | j   | `lispy-up`               | k          | `lispy-down`      |
    | f   | `lispy-flow`             |            |                   |
    | o   | `lispy-differnt`         | o          | reverses itself   |
    | gd  | `lispy-follow`           |            |                   |
    | G   | `lispy-goto`             |            |                   |
    | q   | `lispy-ace-paren`        |            |                   |
    | Q   | `lispy-ace-char`         |            |                   |
    |-----+--------------------------+------------+-------------------|

## Transformations

    |-----+--------------------------+------------+-------------------|
    | key | command                  | key        | command           |
    |-----+--------------------------+------------+-------------------|
    | C-k | `lispy-move-up`          | C-j        | `lispy-move-down` |
    | >   | `alter-sexp-right`       | <          | `alter-sexp-left` |
    | c   | `lispy-clone`            | DEL        |                   |
    | C   | `lispy-convolute`        | C          | Reverses itself   |
    | r   | `lispy-raise`            | u          | `lispy-undo`      |
    | R   | `lispy-raise-some`       | u          | `lispy-undo`      |
    | /   | `lispy-splice`           | u          | `lispy-undo`      |
    | gJ  | `lispy-split`            | J          | `lispy-join`      |
    | O   | `lispy-oneline`          | M          | `lispy-multiline` |
    | ;   | `lispy-comment`          | C-u ;      | `lispy-comment`   |
    | t   | `lispy-teleport`         |            |                   |
    |-----+--------------------------+------------+-------------------|

    < and > change the bounds of sexps contextually, depeding on which
    side they point is on.

## Kill related

    |-------+------------------------------------|
    | key   | command                            |
    |-------+------------------------------------|
    | DEL   | `lispy-delete-backward`            |
    | D     | `lispy-kill`                       |
    | C     | `lispy-kill` and enter insert      |
    | S     | `lispy-kill-at-point`              |
    | p     | `lispy-yank`                       |
    | y     | `lispy-new-copy`                   |
    |-------+------------------------------------|

## Marking

    |-------+------------------------------------|
    | key   | command                            |
    |-------+------------------------------------|
    | v     | `lispy-mark-symbol`                |
    | V     | `lispy-mark-list`                  |
    | s     | `lispy-ace-symbol`                 |
    | gs    | `lispy-ace-symbol-replace`         |
    |-------+------------------------------------|

## Misc

    |-------+------------------------------------|
    | key   | command                            |
    |-------+------------------------------------|
    | C-1   | `lispy-describe-inline             |
    | C-2   | `lispy-arglist-inline              |
    | u     | `lispy-undo`                       |
    | e     | `lispy-eval`                       |
    | E     | `lispy-eval-and-insert`            |
    | K     | `lispy-describe`                   |
    | A     | `lispy-arglist`                    |
    | gq    | `lispy-normalize`                  |
    | z     | `lispy-view`                       |
    | =     | `lispy-tab`                        |
    | TAB   | `lispy-shifttab`                   |
    |-------+------------------------------------|


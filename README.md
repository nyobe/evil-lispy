# Evil Lispy

Wrap [Lispy](https://github.com/abo-abo/lispy) in an
[Evil](https://gitorious.org/evil/pages/Home) sexp editing state.  I tried to
keep commands mappings close to similar vim mneumonics. Not every command has
been mapped yet. The motivation for this is essentially to make Lispy active
explicitly rather than implicitly.

# Command Reference
## Sexp state

Enter the sexp editing state with either `(` or `)`. Exit it with ESC, i, a,
SPC, or RET.

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
    | >   | `lispy-slurp`            | <          | `lispy-barf`      |
    | c   | `lispy-clone`            | DEL        |                   |
    | C   | `lispy-convolute`        | C          | reverses itself   |
    | r   | `lispy-raise`            | u          | `lispy-undo`      |
    | R   | `lispy-raise-some`       | u          | `lispy-undo`      |
    | /   | `lispy-splice`           | u          | `lispy-undo`      |
    | M-j | `lispy-split`            | J          | `lispy-join`      |
    | O   | `lispy-oneline`          | M          | `lispy-multiline` |
    | ;   | `lispy-comment`          | C-u ;      | `lispy-comment`   |
    | t   | `lispy-teleport`         |            |                   |
    |-----+--------------------------+------------+-------------------|

## Kill related

    |-------+------------------------------------|
    | key   | command                            |
    |-------+------------------------------------|
    | DEL   |                                    |
    | D     | `lispy-kill`                       |
    | S     | `lispy-kill-at-point`              |

## Marking

    | w     | `lispy-ace-symbol`                 |
    | W     | `lispy-ace-symbol-replace`         |
    | v     | `lispy-mark-symbol`                |
    | v     | `lispy-mark-list`                  |

## Misc

    | u     | `lispy-undo`                       |
    | e     | `lispy-eval`                       |
    | E     | `lispy-eval-and-insert`            |
    | K     | `lispy-describe`                   |
    | A     | `lispy-arglist`                    |
    | gq    | `lispy-normalize`                  |
    | z     | `lispy-view`                       |
    |-------+------------------------------------|


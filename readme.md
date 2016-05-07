# Nim StringBuilder

Used to efficiently build a string.

    # initial capacity is optional
    var sb = newStringBuilder(1024)

    sb.append("it's over")
    sb &= "9000!!1"         #same as append
    echo sb.len             #16

    sb.truncate(1)
    echo sb.len             #15


# ToString
There are two methods available for getting the current string. The first, using
`$`, creates a new string and copies the contents of the `StringBuilder` into it.
This follows the copy semantics of Nim strings, but it isn't particularly efficient:

  echo $sb      #it's over 9000!!

Calling `destroy` is a more efficient. However, subsequent calls to `StringBuilder`,
including calling `destroy` again, will result in undefined behavior.

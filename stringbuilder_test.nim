import unittest, stringbuilder

suite "stringbuilder":
  test "handles invalid capacity":
    check(newStringBuilder(0).capacity == 256)
    check(newStringBuilder(-1).capacity == 256)

  test "inits with a default value":
    var sb = newStringBuilder("over")
    check($sb == "over")
    sb.append(" 9000!")
    check($sb == "over 9000!")

  test "appends single value":
    var sb = newStringBuilder()
    sb.append("it's")
    check($sb == "it's")
    check(sb.len == 4)

  test "doubles capacity":
    var sb = newStringBuilder(6)
    check(sb.capacity == 6)

    sb &= "it's over"
    check(sb.capacity == 12)
    check($sb == "it's over")

    sb &= " "
    check(sb.capacity == 12)
    check($sb == "it's over ")
    check(sb.len == 10)

  test "linear capacity":
    var sb = newStringBuilder(2, linear(3))
    sb &= "123"
    check(sb.capacity == 6)
    check($sb == "123")

    sb &= "456"
    check(sb.capacity == 6)
    check($sb == "123456")

    sb &= "7"
    check(sb.capacity == 10)
    check($sb == "1234567")


  test "truncates":
    var sb = newStringBuilder("0123456789")
    sb.truncate(2)
    check($sb == "01234567")

    sb.truncate(100)
    check($sb == "")

  test "setLen":
    var sb = newStringBuilder("0123456789")
    sb.setLen(2)
    check($sb == "01")

    sb.setLen(4)
    check($sb == "01")

  test "seals the stringbuilder":
    var sb = newStringBuilder("it's over 9000!")
    sb &= "!!"
    check(sb.destroy == "it's over 9000!!!")

  test "appends chars":
    var sb = newStringBuilder(1)
    sb.append('a')
    check($sb == "a")
    sb &= 'b'
    check($sb == "ab")
    sb.append('c')
    check($sb == "abc")

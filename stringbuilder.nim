const defaultCapacity = 256

type
  StringBuilder = ref object
    len: int
    cap: int
    string: string

# gets the capacity (this is the length + extra space for future growth)
proc capacity*(sb: StringBuilder): int {.inline.} =
  sb.cap

# gets the length of the string
proc len*(sb: StringBuilder): int {.inline.} =
  sb.len

# creates a new string from the stringbuilder, see seal for an efficient alternative
proc `$`*(sb: StringBuilder): string {.inline.} =
  substr(sb.string, 0, <sb.len)

# efficiently converts the stringbuilder into a string.
# using any stringbuilder method after a call to destry (including additional
# calls to destroy) will have undefined behavior to both the stringbuilder and the
# returned string.
proc destroy*(sb: StringBuilder): string =
  shallowCopy result, sb.string
  result.setLen(sb.len)

proc ensureCapacity(sb: StringBuilder, n: int) =
  if sb.cap > n: return
  var newCapcity = sb.cap * 2
  if newCapcity < n: newCapcity = n
  sb.cap = newCapcity

  var tmp: string
  shallowCopy tmp, sb.string
  sb.string = newStringOfCap(newCapcity)
  sb.string.setLen(newCapcity)
  copyMem(addr sb.string[0] , addr tmp[0] , sb.len)

# appends the string
proc append*(sb: StringBuilder, value: string) =
  let newLength = value.len + sb.len
  sb.ensureCapacity(newLength)
  copyMem(addr sb.string[sb.len] , unsafeAddr value[0] , value.len)
  sb.len = newLength

# appends the string
proc `&=`*(sb: StringBuilder, value: string) {.inline.} =
  append(sb, value)

# truncates the string without changing the total capacity
proc truncate*(sb: StringBuilder, n: int) =
  sb.len = if n > sb.len: 0 else: sb.len - n

# sets the length of the string, cannot be greater than the current length
proc setLen*(sb: StringBuilder, n: int) =
  if n < sb.len: sb.len = n

# create a new stringbuilder with the specified, or default, capacity
proc newStringBuilder*(cap: int = defaultCapacity): StringBuilder =
  new(result)
  result.cap = if cap < 1: defaultCapacity else: cap
  result.string = newStringOfCap(result.cap)
  result.string.setLen(result.cap)

# create a new stringbuilder with an initial string
proc newStringBuilder*(init: string): StringBuilder =
  result = newStringBuilder(init.len + defaultCapacity)
  result.append(init)

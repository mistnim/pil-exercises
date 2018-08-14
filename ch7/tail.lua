-- Ex 7.4 Write a program that prints the last line of a text file. Try to avoid
-- reading the entire file when the file is large and seekable.

if #arg ~= 1 then
  os.exit()
end

f = assert(io.open(arg[1], "r"))

size = f:seek("end")
if (not size) or (size < 2^16) then
  f:seek("set")
  local last
  for l in f:lines() do
    last = l
  end
  io.write(last, "\n")
else
  f:seek("end", -2)
  while f:read(1) ~= "\n" do
    f:seek("cur", -2)
  end
  io.write(f:read("a"))
end
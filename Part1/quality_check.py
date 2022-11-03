import sys

if __name__ == '__main__':
  file_name = sys.argv[1]
  f = open(file_name, 'r')
  Lines = f.readlines()
  symbols = Lines[6].split("(")
  j = 0
  cur_symbol = symbols[1][j]
  res = ''
  while cur_symbol != '%':
    res += cur_symbol
    j += 1
    cur_symbol = symbols[1][j]
    
  if float(res) > 90.0:
    print("OK")
  else:
    print("Not OK") 

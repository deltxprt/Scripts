#!/usr/bin/python
def deleteLine():
 fn = 'C:\\Users\\vincd\\.ssh\\known_hosts'
 f = open(fn)
 output = []
 str= input('enter the ip you want to delete from the list: ')
 for line in f:
   if not line.startswith(str):
    output.append(line)
 f.close()
 f = open(fn, 'w')
 f.writelines(output)
 f.close()
deleteLine()
